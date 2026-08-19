# LTMB12 SQL Practice - Set 1
# Complete Solutions WITHOUT CTE

-- Database:
-- hospital_db

-- Tables:
-- patients
-- doctors
-- appointments
-- billing
-- treatments
-- medicines
-- prescriptions
-- appointment_audit

-- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = EASY LEVEL = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

------------------------------------------------------------
-- 1.
-- INNER JOIN Patients
-- with
--     completed appointments
--     and their doctors
------------------------------------------------------------

SELECT p.patient_name, d.doctor_name, a.appointment_date
FROM
    patients p
    INNER JOIN appointments a ON p.patient_id = a.patient_id
    INNER JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE
    a.status = 'Completed';

------------------------------------------------------------
-- 2.
-- LEFT JOIN All appointments
-- with
--     billing information
------------------------------------------------------------

SELECT a.appointment_id, a.appointment_date, b.bill_amount
FROM appointments a
    LEFT JOIN billing b ON a.appointment_id = b.appointment_id;

-- ------------------------------------------------------------
-- 3. SIMPLE SUBQUERY Doctors charging more than average consultation fee
------------------------------------------------------------

SELECT
    doctor_id,
    doctor_name,
    consultation_fee
FROM doctors
WHERE
    consultation_fee > (
        SELECT AVG(consultation_fee)
        FROM doctors
    );

------------------------------------------------------------
-- 4.
-- JOIN + AGGREGATE Number of appointments handled by every doctor
------------------------------------------------------------

SELECT d.doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors d
    LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name;

------------------------------------------------------------
-- 5.
-- JOIN + AGGREGATE +
-- HAVING
--     Doctors who handled more than 2 appointments
------------------------------------------------------------

SELECT d.doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors d
    INNER JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name
HAVING
    COUNT(a.appointment_id) > 2;

-- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = MEDIUM LEVEL = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

------------------------------------------------------------
-- 1.
-- JOIN + SUBQUERY Patients who consulted Cardiology doctors
------------------------------------------------------------

SELECT p.patient_name, d.doctor_name, a.appointment_date
FROM
    patients p
    INNER JOIN appointments a ON p.patient_id = a.patient_id
    INNER JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE
    d.doctor_id IN (
        SELECT doctor_id
        FROM doctors
        WHERE
            specialization = 'Cardiology'
    );

------------------------------------------------------------
-- 2.
-- JOIN + AGGREGATE + SUBQUERY Doctors whose total revenue is greater than the average doctor revenue
------------------------------------------------------------

SELECT d.doctor_name, SUM(b.bill_amount) AS total_revenue
FROM
    doctors d
    INNER JOIN appointments a ON d.doctor_id = a.doctor_id
    INNER JOIN billing b ON a.appointment_id = b.appointment_id
GROUP BY
    d.doctor_id,
    d.doctor_name
HAVING
    SUM(b.bill_amount) > (
        SELECT AVG(doctor_revenue)
        FROM (
                SELECT a2.doctor_id, SUM(b2.bill_amount) AS doctor_revenue
                FROM appointments a2
                    INNER JOIN billing b2 ON a2.appointment_id = b2.appointment_id
                GROUP BY
                    a2.doctor_id
            ) AS revenue_table
    );

------------------------------------------------------------
-- 3. ROW_NUMBER Most recent appointment for every patient
------------------------------------------------------------

SELECT
    patient_name,
    appointment_date,
    doctor_name
FROM (
        SELECT p.patient_name, a.appointment_date, d.doctor_name, ROW_NUMBER() OVER (
                PARTITION BY
                    p.patient_id
                ORDER BY a.appointment_date DESC
            ) AS rn
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN doctors d ON a.doctor_id = d.doctor_id
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 4. RANK Rank doctors based on total billing revenue
------------------------------------------------------------

SELECT
    doctor_name,
    total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM (
        SELECT d.doctor_id, d.doctor_name, SUM(b.bill_amount) AS total_revenue
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
        GROUP BY
            d.doctor_id, d.doctor_name
    ) AS x;

------------------------------------------------------------
-- 5. TOP REVENUE DOCTOR IN EACH SPECIALIZATION
------------------------------------------------------------

SELECT
    specialization,
    doctor_name,
    total_revenue
FROM (
        SELECT
            d.specialization, d.doctor_name, SUM(b.bill_amount) AS total_revenue, RANK() OVER (
                PARTITION BY
                    d.specialization
                ORDER BY SUM(b.bill_amount) DESC
            ) AS revenue_rank
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
        GROUP BY
            d.doctor_id, d.doctor_name, d.specialization
    ) AS x
WHERE
    revenue_rank = 1;

-- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 20 SQL JOINS +
-- WINDOW
--     FUNCTION QUESTIONS = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

-- ------------------------------------------------------------
-- 1. LATEST APPOINTMENT FOR EVERY PATIENT
------------------------------------------------------------

SELECT
    patient_name,
    appointment_date,
    doctor_name
FROM (
        SELECT p.patient_name, a.appointment_date, d.doctor_name, ROW_NUMBER() OVER (
                PARTITION BY
                    p.patient_id
                ORDER BY a.appointment_date DESC
            ) AS rn
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN doctors d ON a.doctor_id = d.doctor_id
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 2. RANK DOCTORS BASED ON CONSULTATION FEES
------------------------------------------------------------

SELECT
    doctor_name,
    specialization,
    consultation_fee,
    RANK() OVER (
        ORDER BY consultation_fee DESC
    ) AS fee_rank
FROM doctors;

------------------------------------------------------------
-- 3. HIGHEST BILL GENERATED BY EACH PATIENT
------------------------------------------------------------

SELECT
    patient_name,
    bill_amount,
    appointment_date
FROM (
        SELECT p.patient_id, p.patient_name, b.bill_amount, a.appointment_date, ROW_NUMBER() OVER (
                PARTITION BY
                    p.patient_id
                ORDER BY b.bill_amount DESC
            ) AS rn
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 4. RANK DOCTORS BY TOTAL REVENUE
------------------------------------------------------------

SELECT
    doctor_name,
    total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM (
        SELECT d.doctor_id, d.doctor_name, SUM(b.bill_amount) AS total_revenue
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
        GROUP BY
            d.doctor_id, d.doctor_name
    ) AS x;

------------------------------------------------------------
-- 5. MOST EXPENSIVE TREATMENT HANDLED BY EACH DOCTOR
------------------------------------------------------------

SELECT
    doctor_name,
    treatment_name,
    treatment_cost
FROM (
        SELECT d.doctor_id, d.doctor_name, t.treatment_name, t.treatment_cost, ROW_NUMBER() OVER (
                PARTITION BY
                    d.doctor_id
                ORDER BY t.treatment_cost DESC
            ) AS rn
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN treatments t ON a.appointment_id = t.appointment_id
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 6. APPOINTMENT NUMBERING FOR PATIENTS
------------------------------------------------------------

SELECT
    patient_name,
    appointment_date,
    ROW_NUMBER() OVER (
        PARTITION BY
            p.patient_id
        ORDER BY a.appointment_date
    ) AS visit_number
FROM patients p
    INNER JOIN appointments a ON p.patient_id = a.patient_id;

------------------------------------------------------------
-- 7. DENSE RANKING OF DOCTORS BY REVENUE
------------------------------------------------------------

SELECT
    doctor_name,
    total_revenue AS revenue,
    DENSE_RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS dense_rank
FROM (
        SELECT d.doctor_id, d.doctor_name, SUM(b.bill_amount) AS total_revenue
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
        GROUP BY
            d.doctor_id, d.doctor_name
    ) AS x;

------------------------------------------------------------
-- 8. PREVIOUS APPOINTMENT DATE
------------------------------------------------------------

SELECT
    p.patient_name,
    a.appointment_date AS current_appointment_date,
    LAG(a.appointment_date) OVER (
        PARTITION BY
            p.patient_id
        ORDER BY a.appointment_date
    ) AS previous_appointment_date
FROM patients p
    INNER JOIN appointments a ON p.patient_id = a.patient_id;

------------------------------------------------------------
-- 9. NEXT APPOINTMENT DATE
------------------------------------------------------------

SELECT
    p.patient_name,
    a.appointment_date AS current_appointment_date,
    LEAD(a.appointment_date) OVER (
        PARTITION BY
            p.patient_id
        ORDER BY a.appointment_date
    ) AS next_appointment_date
FROM patients p
    INNER JOIN appointments a ON p.patient_id = a.patient_id;

------------------------------------------------------------
-- 10. HIGHEST REVENUE DOCTOR IN EACH SPECIALIZATION
------------------------------------------------------------

SELECT
    specialization,
    doctor_name,
    total_revenue
FROM (
        SELECT d.specialization, d.doctor_name, SUM(b.bill_amount) AS total_revenue, ROW_NUMBER() OVER (
                PARTITION BY
                    d.specialization
                ORDER BY SUM(b.bill_amount) DESC
            ) AS rn
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
        GROUP BY
            d.doctor_id, d.doctor_name, d.specialization
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 11. RANK PATIENTS BASED ON TOTAL HOSPITAL SPENDING
------------------------------------------------------------

SELECT
    patient_name,
    total_billing_amount,
    RANK() OVER (
        ORDER BY total_billing_amount DESC
    ) AS patient_rank
FROM (
        SELECT p.patient_id, p.patient_name, SUM(b.bill_amount) AS total_billing_amount
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
        GROUP BY
            p.patient_id, p.patient_name
    ) AS x;

------------------------------------------------------------
-- 12. LATEST TREATMENT RECEIVED BY EACH PATIENT
------------------------------------------------------------

SELECT
    patient_name,
    treatment_name,
    appointment_date
FROM (
        SELECT p.patient_id, p.patient_name, t.treatment_name, a.appointment_date, ROW_NUMBER() OVER (
                PARTITION BY
                    p.patient_id
                ORDER BY a.appointment_date DESC
            ) AS rn
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN treatments t ON a.appointment_id = t.appointment_id
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 13. TOP 2 REVENUE - GENERATING DOCTORS
------------------------------------------------------------

SELECT
    doctor_name,
    total_revenue,
    revenue_rank
FROM (
        SELECT
            doctor_name, total_revenue, RANK() OVER (
                ORDER BY total_revenue DESC
            ) AS revenue_rank
        FROM (
                SELECT d.doctor_id, d.doctor_name, SUM(b.bill_amount) AS total_revenue
                FROM
                    doctors d
                    INNER JOIN appointments a ON d.doctor_id = a.doctor_id
                    INNER JOIN billing b ON a.appointment_id = b.appointment_id
                GROUP BY
                    d.doctor_id, d.doctor_name
            ) AS revenue
    ) AS ranked
WHERE
    revenue_rank <= 2;

------------------------------------------------------------
-- 14. RUNNING REVENUE GENERATED BY EACH DOCTOR
------------------------------------------------------------

SELECT d.doctor_name, a.appointment_date, b.bill_amount, SUM(b.bill_amount) OVER (
        PARTITION BY
            d.doctor_id
        ORDER BY a.appointment_date ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
    ) AS running_revenue
FROM
    doctors d
    INNER JOIN appointments a ON d.doctor_id = a.doctor_id
    INNER JOIN billing b ON a.appointment_id = b.appointment_id
ORDER BY d.doctor_name, a.appointment_date;

------------------------------------------------------------
-- 15. DIFFERENCE BETWEEN CURRENT AND PREVIOUS  BILL
------------------------------------------------------------

SELECT
    patient_name,
    appointment_date,
    current_bill,
    previous_bill,
    current_bill - previous_bill AS difference
FROM (
        SELECT
            p.patient_name, a.appointment_date, b.bill_amount AS current_bill, LAG(b.bill_amount) OVER (
                PARTITION BY
                    p.patient_id
                ORDER BY a.appointment_date
            ) AS previous_bill
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
    ) AS x;

------------------------------------------------------------
-- 16. MOST FREQUENTLY VISITED DOCTOR FOR EACH PATIENT
------------------------------------------------------------

SELECT
    patient_name,
    doctor_name,
    total_visits
FROM (
        SELECT p.patient_id, p.patient_name, d.doctor_id, d.doctor_name, COUNT(*) AS total_visits, ROW_NUMBER() OVER (
                PARTITION BY
                    p.patient_id
                ORDER BY COUNT(*) DESC
            ) AS rn
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN doctors d ON a.doctor_id = d.doctor_id
        GROUP BY
            p.patient_id, p.patient_name, d.doctor_id, d.doctor_name
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 17. RANK TREATMENTS BY COST WITHIN EACH DOCTOR
------------------------------------------------------------

SELECT
    doctor_name,
    treatment_name,
    treatment_cost,
    RANK() OVER (
        PARTITION BY
            doctor_id
        ORDER BY treatment_cost DESC
    ) AS treatment_rank
FROM (
        SELECT d.doctor_id, d.doctor_name, t.treatment_name, t.treatment_cost
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN treatments t ON a.appointment_id = t.appointment_id
    ) AS x;

------------------------------------------------------------
-- 18. FIRST APPOINTMENT OF EVERY PATIENT
------------------------------------------------------------

SELECT
    patient_name,
    appointment_date,
    doctor_name
FROM (
        SELECT p.patient_id, p.patient_name, a.appointment_date, d.doctor_name, ROW_NUMBER() OVER (
                PARTITION BY
                    p.patient_id
                ORDER BY a.appointment_date
            ) AS rn
        FROM
            patients p
            INNER JOIN appointments a ON p.patient_id = a.patient_id
            INNER JOIN doctors d ON a.doctor_id = d.doctor_id
    ) AS x
WHERE
    rn = 1;

------------------------------------------------------------
-- 19. DOCTOR REVENUE CONTRIBUTION PERCENTAGE
------------------------------------------------------------

SELECT
    doctor_name,
    total_revenue AS revenue_generated,
    ROUND(
        total_revenue * 100 / (
            SELECT SUM(bill_amount)
            FROM billing
        ),
        2
    ) AS revenue_contribution_percentage
FROM (
        SELECT d.doctor_id, d.doctor_name, SUM(b.bill_amount) AS total_revenue
        FROM
            doctors d
            INNER JOIN appointments a ON d.doctor_id = a.doctor_id
            INNER JOIN billing b ON a.appointment_id = b.appointment_id
        GROUP BY
            d.doctor_id, d.doctor_name
    ) AS x;

------------------------------------------------------------
-- 20. TOP 3 PATIENTS BY SPENDING IN EACH CITY
------------------------------------------------------------

SELECT
    city,
    patient_name,
    total_billing_amount,
    city_rank
FROM (
        SELECT
            city, patient_name, total_billing_amount, RANK() OVER (
                PARTITION BY
                    city
                ORDER BY total_billing_amount DESC
            ) AS city_rank
        FROM (
                SELECT p.patient_id, p.city, p.patient_name, SUM(b.bill_amount) AS total_billing_amount
                FROM
                    patients p
                    INNER JOIN appointments a ON p.patient_id = a.patient_id
                    INNER JOIN billing b ON a.appointment_id = b.appointment_id
                GROUP BY
                    p.patient_id, p.city, p.patient_name
            ) AS spending
    ) AS ranked
WHERE
    city_rank <= 3;
