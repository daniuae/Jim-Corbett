USE smartdb;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    manager_id INT,
    date_of_birth DATE,
    join_date DATE,
    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);




INSERT INTO employees
(employee_id, employee_name, manager_id, date_of_birth, join_date)
VALUES
(1, 'John', NULL, '1978-05-15', '2010-06-10'),
(2, 'Alice', 1, '1982-08-20', '2018-03-12'),
(3, 'Bob', 1, '1985-11-02', '2021-07-19'),
(4, 'Charlie', 2, '1989-01-28', '2023-01-15'),
(5, 'David', 2, '1992-06-10', '2019-09-25'),
(6, 'Emma', 3, '1987-12-25', '2024-02-20'),
(7, 'Frank', 3, '1975-03-08', '2015-11-30'),
(8, 'Grace', 4, '1990-09-16', '2022-05-05'),
(9, 'Henry', 4, '1983-04-23', '2020-08-17'),
(10, 'Irene', 5, '1995-07-01', '2025-01-10');


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

| Requirement              | MySQL Function    |
| ------------------------ | ----------------- |
| Extract birth year       | `YEAR()`          |
| Add 60 years             | `DATE_ADD()`      |
| Last 5 years             | `DATE_SUB()`      |
| Day number               | `DAYOFWEEK()`     |
| Day name                 | `DAYNAME()`       |
| Month name               | `MONTHNAME()`     |
| Difference between dates | `DATEDIFF()`      |
| Current date             | `CURDATE()`       |
| Calculate age            | `TIMESTAMPDIFF()` |
| Average age              | `AVG()`           |
| Format date              | `DATE_FORMAT()`   |
| Convert string to date   | `STR_TO_DATE()`   |

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
