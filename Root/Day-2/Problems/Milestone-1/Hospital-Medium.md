# 1. Join + Subquery

## Scenario

The medical director wants to identify patients who consulted doctors from the **Cardiology** department.

## Question

Write a query to display:

- Patient Name
- Doctor Name
- Appointment Date

Use a subquery to first identify all Cardiology doctors.

## Solution

```sql
SELECT
    p.patient_name,
    d.doctor_name,
    a.appointment_date
FROM appointments a
JOIN patients p
    ON a.patient_id = p.patient_id
JOIN doctors d
    ON a.doctor_id = d.doctor_id
WHERE a.doctor_id IN (
    SELECT doctor_id
    FROM doctors
    WHERE department = 'Cardiology'
);
