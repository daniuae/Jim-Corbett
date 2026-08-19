USE smartdb;

-- =====================================================
-- 1. Employees born in the 1980s
-- =====================================================

SELECT
    employee_id,
    employee_name,
    date_of_birth
FROM employees
WHERE YEAR(date_of_birth) BETWEEN 1980 AND 1989;


-- =====================================================
-- 2. Retirement date: 60 years after birth
-- =====================================================

SELECT
    employee_id,
    employee_name,
    date_of_birth,
    DATE_ADD(date_of_birth, INTERVAL 60 YEAR) AS retirement_date
FROM employees;


-- =====================================================
-- 3. Employees who joined within the last 5 years
-- =====================================================

SELECT
    employee_id,
    employee_name,
    join_date
FROM employees
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);


-- =====================================================
-- 4. Day and month of birth
-- =====================================================

SELECT
    employee_id,
    employee_name,
    date_of_birth,
    DAYOFWEEK(date_of_birth) AS day_number,
    DAYNAME(date_of_birth) AS birth_day,
    MONTHNAME(date_of_birth) AS birth_month
FROM employees;


-- =====================================================
-- 5. Days until next birthday
-- =====================================================

SELECT
    employee_id,
    employee_name,
    date_of_birth,
    DATEDIFF(
        CASE
            WHEN STR_TO_DATE(
                     CONCAT(
                         YEAR(CURDATE()),
                         '-',
                         DATE_FORMAT(date_of_birth, '%m-%d')
                     ),
                     '%Y-%m-%d'
                 ) >= CURDATE()
            THEN STR_TO_DATE(
                     CONCAT(
                         YEAR(CURDATE()),
                         '-',
                         DATE_FORMAT(date_of_birth, '%m-%d')
                     ),
                     '%Y-%m-%d'
                 )
            ELSE STR_TO_DATE(
                     CONCAT(
                         YEAR(CURDATE()) + 1,
                         '-',
                         DATE_FORMAT(date_of_birth, '%m-%d')
                     ),
                     '%Y-%m-%d'
                 )
        END,
        CURDATE()
    ) AS days_until_birthday
FROM employees;


-- =====================================================
-- 6. Employees born on weekends
-- =====================================================

SELECT
    employee_id,
    employee_name,
    date_of_birth,
    DAYNAME(date_of_birth) AS birth_day
FROM employees
WHERE DAYOFWEEK(date_of_birth) IN (1, 7);


-- =====================================================
-- 7. Average age of employees
-- =====================================================

SELECT
    AVG(
        TIMESTAMPDIFF(
            YEAR,
            date_of_birth,
            CURDATE()
        )
    ) AS average_age
FROM employees;
