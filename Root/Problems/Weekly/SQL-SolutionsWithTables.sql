-- Trainee must identify whether the problem is:
-- SYN = Syntax error
-- LOG = Logic error
-- SEM = Semantic/meaning error
-- Then the solution section is completely separate.
-- The set progresses from Basic → Medium → Hard and deliberately mixes:

-- SELECT
-- WHERE
-- comparison operators
-- logical operators
-- IN
-- BETWEEN
-- LIKE
-- IS NULL
-- CASE
-- DISTINCT
-- ORDER BY
-- GROUP BY
-- HAVING
-- aggregate functions
-- all major joins
-- self joins
-- cross joins
-- subqueries
-- correlated subqueries
-- CTEs
-- UNION
-- EXISTS
-- NOT EXISTS
-- window functions
-- ROW_NUMBER
-- RANK
-- DENSE_RANK
-- LAG
-- LEAD
-- running totals
-- moving averages
-- partitioning
-- conditional aggregation
-- top-N problems
-- duplicate detection
-- NULL handling
-- date functions
-- string functions
-- nested queries
-- joins + windows
-- joins + aggregates
-- subqueries + windows
-- Compatibility: MySQL 8.0+. Window functions and CTEs require MySQL 8.0 or later.

-- 0. Practice Database
-- Use the following schema for all 100 questions.
-- Tables
-- CREATE DATABASE sql_training;

-- USE sql_training;
-- ============================================================
-- SQL TRAINING DATABASE
-- MySQL 8.0+
-- Designed to support the 100 SQL problems in SQL-Problems.pdf
-- ============================================================

DROP DATABASE IF EXISTS sql_training;

CREATE DATABASE sql_training;

USE sql_training;

-- ============================================================
-- 1. TABLES
-- ============================================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    manager_id INT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments (department_id),
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    segment VARCHAR(30) NOT NULL,
    signup_date DATE NOT NULL,
    sales_rep_id INT NULL,
    FOREIGN KEY (sales_rep_id) REFERENCES employees (employee_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    subcategory VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    supplier_id INT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    shipping_date DATE NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- ============================================================
-- 2. DEPARTMENTS
-- Includes one department with NO employees for LEFT JOIN tests.
-- ============================================================

INSERT INTO
    departments (
        department_id,
        department_name,
        location
    )
VALUES (1, 'Sales', 'Chennai'),
    (2, 'IT', 'Bangalore'),
    (3, 'Finance', 'Mumbai'),
    (4, 'HR', 'Delhi'),
    (5, 'Marketing', 'Hyderabad'),
    (6, 'Operations', 'Pune'),
    (7, 'Data', 'Chennai'),
    (8, 'Support', 'Kochi'),
    (9, 'Legal', 'Delhi'),
    (10, 'Research', 'Pune');

-- ============================================================
-- 3. EMPLOYEES
-- Salary ties are deliberately included for RANK/DENSE_RANK.
-- Manager relationships are included for self-join questions.
-- Department 10 intentionally has no employees.
-- ============================================================

INSERT INTO
    employees (
        employee_id,
        employee_name,
        department_id,
        manager_id,
        salary,
        hire_date,
        job_title
    )
VALUES (
        101,
        'Arun Kumar',
        1,
        NULL,
        95000.00,
        '2020-01-15',
        'Sales Director'
    ),
    (
        102,
        'Priya Sharma',
        1,
        101,
        72000.00,
        '2021-03-10',
        'Sales Manager'
    ),
    (
        103,
        'Rahul Verma',
        1,
        101,
        72000.00,
        '2021-06-20',
        'Sales Manager'
    ),
    (
        104,
        'Sneha Iyer',
        1,
        102,
        58000.00,
        '2022-02-12',
        'Sales Executive'
    ),
    (
        105,
        'Vikram Singh',
        1,
        103,
        52000.00,
        '2023-05-18',
        'Sales Executive'
    ),
    (
        201,
        'Karthik Rao',
        2,
        NULL,
        120000.00,
        '2019-04-01',
        'IT Director'
    ),
    (
        202,
        'Meena Nair',
        2,
        201,
        90000.00,
        '2020-08-14',
        'IT Manager'
    ),
    (
        203,
        'Suresh Babu',
        2,
        201,
        85000.00,
        '2021-01-20',
        'Senior Developer'
    ),
    (
        204,
        'Divya Menon',
        2,
        202,
        85000.00,
        '2022-07-11',
        'Developer'
    ),
    (
        205,
        'Ajay Das',
        2,
        202,
        65000.00,
        '2023-09-01',
        'Developer'
    ),
    (
        301,
        'Ramesh Gupta',
        3,
        NULL,
        110000.00,
        '2018-11-10',
        'Finance Director'
    ),
    (
        302,
        'Anita Patel',
        3,
        301,
        80000.00,
        '2020-02-17',
        'Finance Manager'
    ),
    (
        303,
        'Manoj Shah',
        3,
        301,
        65000.00,
        '2021-04-21',
        'Accountant'
    ),
    (
        304,
        'Pooja Jain',
        3,
        302,
        60000.00,
        '2022-10-05',
        'Accountant'
    ),
    (
        401,
        'Neha Kapoor',
        4,
        NULL,
        88000.00,
        '2020-05-12',
        'HR Manager'
    ),
    (
        402,
        'Amit Malhotra',
        4,
        401,
        62000.00,
        '2022-01-09',
        'HR Executive'
    ),
    (
        403,
        'Lakshmi Rao',
        4,
        401,
        58000.00,
        '2023-03-15',
        'HR Executive'
    ),
    (
        501,
        'Sanjay Mehta',
        5,
        NULL,
        92000.00,
        '2019-07-07',
        'Marketing Director'
    ),
    (
        502,
        'Tina Joseph',
        5,
        501,
        70000.00,
        '2021-08-19',
        'Marketing Manager'
    ),
    (
        503,
        'Nikhil Roy',
        5,
        502,
        60000.00,
        '2022-12-01',
        'Marketing Analyst'
    ),
    (
        601,
        'Deepak Joshi',
        6,
        NULL,
        98000.00,
        '2019-09-03',
        'Operations Manager'
    ),
    (
        602,
        'Farah Khan',
        6,
        601,
        68000.00,
        '2021-05-22',
        'Operations Analyst'
    ),
    (
        603,
        'Gopal Krishnan',
        6,
        601,
        55000.00,
        '2023-02-13',
        'Operations Executive'
    ),
    (
        701,
        'Vivek Anand',
        7,
        NULL,
        115000.00,
        '2018-06-06',
        'Data Director'
    ),
    (
        702,
        'Shalini Das',
        7,
        701,
        95000.00,
        '2020-10-16',
        'Data Manager'
    ),
    (
        703,
        'Rohit Kumar',
        7,
        702,
        82000.00,
        '2021-12-20',
        'Data Engineer'
    ),
    (
        704,
        'Isha Gupta',
        7,
        702,
        78000.00,
        '2022-04-25',
        'Data Engineer'
    ),
    (
        801,
        'Mohan Thomas',
        8,
        NULL,
        76000.00,
        '2020-03-03',
        'Support Manager'
    ),
    (
        802,
        'Asha George',
        8,
        801,
        50000.00,
        '2022-06-14',
        'Support Executive'
    );

-- ============================================================
-- 4. CUSTOMERS
-- Includes:
--   * India / USA / UK / UAE customers
--   * Consumer / Corporate / Small Business
--   * NULL sales representatives
--   * customers with no orders
--   * repeated city/country values for DISTINCT/GROUP BY
-- ============================================================

INSERT INTO
    customers (
        customer_id,
        customer_name,
        city,
        state,
        country,
        segment,
        signup_date,
        sales_rep_id
    )
VALUES (
        1,
        'Ananya Rao',
        'Chennai',
        'Tamil Nadu',
        'India',
        'Consumer',
        '2024-01-10',
        104
    ),
    (
        2,
        'Arjun Mehta',
        'Mumbai',
        'Maharashtra',
        'India',
        'Corporate',
        '2024-01-15',
        105
    ),
    (
        3,
        'Asha Nair',
        'Bangalore',
        'Karnataka',
        'India',
        'Consumer',
        '2024-02-05',
        104
    ),
    (
        4,
        'Amit Shah',
        'Delhi',
        'Delhi',
        'India',
        'Corporate',
        '2024-02-18',
        102
    ),
    (
        5,
        'Priya Iyer',
        'Chennai',
        'Tamil Nadu',
        'India',
        'Consumer',
        '2024-03-02',
        NULL
    ),
    (
        6,
        'Ravi Kumar',
        'Hyderabad',
        'Telangana',
        'India',
        'Corporate',
        '2024-03-15',
        103
    ),
    (
        7,
        'Sneha Rao',
        'Pune',
        'Maharashtra',
        'India',
        'Small Business',
        '2024-04-01',
        105
    ),
    (
        8,
        'Kiran Patel',
        'Ahmedabad',
        'Gujarat',
        'India',
        'Consumer',
        '2024-04-12',
        NULL
    ),
    (
        9,
        'Neel Shah',
        'Mumbai',
        'Maharashtra',
        'India',
        'Corporate',
        '2024-05-06',
        102
    ),
    (
        10,
        'Divya Menon',
        'Kochi',
        'Kerala',
        'India',
        'Consumer',
        '2024-05-20',
        104
    ),
    (
        11,
        'Alice Johnson',
        'New York',
        'New York',
        'USA',
        'Corporate',
        '2024-01-08',
        102
    ),
    (
        12,
        'Brian Smith',
        'Chicago',
        'Illinois',
        'USA',
        'Consumer',
        '2024-02-14',
        103
    ),
    (
        13,
        'Carol Brown',
        'Seattle',
        'Washington',
        'USA',
        'Corporate',
        '2024-03-11',
        105
    ),
    (
        14,
        'David Wilson',
        'Boston',
        'Massachusetts',
        'USA',
        'Consumer',
        '2024-04-09',
        NULL
    ),
    (
        15,
        'Emma Davis',
        'Austin',
        'Texas',
        'USA',
        'Corporate',
        '2024-05-17',
        102
    ),
    (
        16,
        'George Miller',
        'London',
        'England',
        'UK',
        'Corporate',
        '2024-01-19',
        103
    ),
    (
        17,
        'Helen Wilson',
        'Manchester',
        'England',
        'UK',
        'Consumer',
        '2024-02-21',
        NULL
    ),
    (
        18,
        'Ian Taylor',
        'Bristol',
        'England',
        'UK',
        'Corporate',
        '2024-03-22',
        105
    ),
    (
        19,
        'Jane Thomas',
        'London',
        'England',
        'UK',
        'Consumer',
        '2024-06-05',
        NULL
    ),
    (
        20,
        'Omar Ali',
        'Dubai',
        'Dubai',
        'UAE',
        'Corporate',
        '2024-01-25',
        104
    ),
    (
        21,
        'Sara Khan',
        'Abu Dhabi',
        'Abu Dhabi',
        'UAE',
        'Consumer',
        '2024-02-28',
        105
    ),
    (
        22,
        'Zaid Ahmed',
        'Dubai',
        'Dubai',
        'UAE',
        'Corporate',
        '2024-04-30',
        NULL
    ),
    (
        23,
        'NoOrder One',
        'Chennai',
        'Tamil Nadu',
        'India',
        'Consumer',
        '2024-07-01',
        NULL
    ),
    (
        24,
        'NoOrder Two',
        'New York',
        'New York',
        'USA',
        'Consumer',
        '2024-07-05',
        NULL
    ),
    (
        25,
        'NoOrder Three',
        'London',
        'England',
        'UK',
        'Corporate',
        '2024-07-10',
        NULL
    );

-- ============================================================
-- 5. PRODUCTS
-- Includes:
--   * multiple categories
--   * prices below 500, 500-999, 1000+
--   * different margins
--   * products never ordered
-- ============================================================

INSERT INTO
    products (
        product_id,
        product_name,
        category,
        subcategory,
        price,
        cost,
        supplier_id
    )
VALUES (
        1,
        'Wireless Mouse',
        'Electronics',
        'Accessories',
        250.00,
        120.00,
        101
    ),
    (
        2,
        'Mechanical Keyboard',
        'Electronics',
        'Accessories',
        850.00,
        450.00,
        101
    ),
    (
        3,
        '27-inch Monitor',
        'Electronics',
        'Displays',
        1500.00,
        900.00,
        102
    ),
    (
        4,
        'Laptop Pro 14',
        'Electronics',
        'Computers',
        1800.00,
        1200.00,
        103
    ),
    (
        5,
        'Laptop Air 13',
        'Electronics',
        'Computers',
        1250.00,
        800.00,
        103
    ),
    (
        6,
        'USB-C Hub',
        'Electronics',
        'Accessories',
        450.00,
        220.00,
        101
    ),
    (
        7,
        'Smartphone X',
        'Electronics',
        'Mobiles',
        1100.00,
        700.00,
        104
    ),
    (
        8,
        'Tablet Plus',
        'Electronics',
        'Tablets',
        900.00,
        550.00,
        104
    ),
    (
        9,
        'Noise Cancelling Headset',
        'Electronics',
        'Audio',
        650.00,
        300.00,
        105
    ),
    (
        10,
        'Office Chair',
        'Furniture',
        'Chairs',
        700.00,
        420.00,
        201
    ),
    (
        11,
        'Executive Chair',
        'Furniture',
        'Chairs',
        1400.00,
        850.00,
        201
    ),
    (
        12,
        'Standing Desk',
        'Furniture',
        'Desks',
        1600.00,
        950.00,
        202
    ),
    (
        13,
        'Office Desk',
        'Furniture',
        'Desks',
        950.00,
        600.00,
        202
    ),
    (
        14,
        'Bookshelf',
        'Furniture',
        'Storage',
        500.00,
        280.00,
        203
    ),
    (
        15,
        'SQL Fundamentals',
        'Books',
        'Technical',
        300.00,
        120.00,
        301
    ),
    (
        16,
        'Data Engineering',
        'Books',
        'Technical',
        550.00,
        220.00,
        301
    ),
    (
        17,
        'Cloud Computing',
        'Books',
        'Technical',
        750.00,
        300.00,
        302
    ),
    (
        18,
        'Analytics Course',
        'Services',
        'Training',
        1200.00,
        500.00,
        401
    ),
    (
        19,
        'Consulting Package',
        'Services',
        'Consulting',
        2500.00,
        1200.00,
        402
    ),
    (
        20,
        'Unused Product A',
        'Electronics',
        'Experimental',
        999.00,
        400.00,
        999
    ),
    (
        21,
        'Unused Product B',
        'Furniture',
        'Experimental',
        1999.00,
        900.00,
        999
    );

-- ============================================================
-- 6. ORDERS
-- Dates span 2025-2026.
-- Includes completed/pending/cancelled/shipped orders.
-- Includes orders shipped after order date and NULL shipping dates.
-- Several customers have multiple orders.
-- ============================================================

INSERT INTO
    orders (
        order_id,
        customer_id,
        employee_id,
        order_date,
        status,
        shipping_date
    )
VALUES (
        1001,
        1,
        104,
        '2026-01-02',
        'Completed',
        '2026-01-04'
    ),
    (
        1002,
        1,
        104,
        '2026-01-10',
        'Completed',
        '2026-01-12'
    ),
    (
        1003,
        1,
        104,
        '2026-02-15',
        'Completed',
        '2026-02-18'
    ),
    (
        1004,
        2,
        105,
        '2026-01-05',
        'Completed',
        '2026-01-07'
    ),
    (
        1005,
        2,
        105,
        '2026-03-12',
        'Pending',
        NULL
    ),
    (
        1006,
        3,
        104,
        '2026-01-12',
        'Completed',
        '2026-01-15'
    ),
    (
        1007,
        3,
        104,
        '2026-04-05',
        'Completed',
        '2026-04-07'
    ),
    (
        1008,
        4,
        102,
        '2026-01-20',
        'Completed',
        '2026-01-22'
    ),
    (
        1009,
        4,
        102,
        '2026-05-11',
        'Cancelled',
        NULL
    ),
    (
        1010,
        5,
        104,
        '2026-01-25',
        'Pending',
        NULL
    ),
    (
        1011,
        6,
        103,
        '2026-02-02',
        'Completed',
        '2026-02-05'
    ),
    (
        1012,
        6,
        103,
        '2026-02-20',
        'Completed',
        '2026-02-22'
    ),
    (
        1013,
        6,
        103,
        '2026-06-10',
        'Completed',
        '2026-06-13'
    ),
    (
        1014,
        7,
        105,
        '2026-03-01',
        'Completed',
        '2026-03-03'
    ),
    (
        1015,
        9,
        102,
        '2026-01-28',
        'Completed',
        '2026-01-30'
    ),
    (
        1016,
        9,
        102,
        '2026-04-18',
        'Completed',
        '2026-04-20'
    ),
    (
        1017,
        10,
        104,
        '2026-02-10',
        'Completed',
        '2026-02-12'
    ),
    (
        1018,
        11,
        102,
        '2026-01-08',
        'Completed',
        '2026-01-10'
    ),
    (
        1019,
        11,
        102,
        '2026-03-18',
        'Completed',
        '2026-03-20'
    ),
    (
        1020,
        11,
        102,
        '2026-05-22',
        'Completed',
        '2026-05-25'
    ),
    (
        1021,
        12,
        103,
        '2026-02-05',
        'Completed',
        '2026-02-08'
    ),
    (
        1022,
        12,
        103,
        '2026-04-14',
        'Pending',
        NULL
    ),
    (
        1023,
        13,
        105,
        '2026-02-25',
        'Completed',
        '2026-02-27'
    ),
    (
        1024,
        13,
        105,
        '2026-05-15',
        'Completed',
        '2026-05-18'
    ),
    (
        1025,
        14,
        102,
        '2026-03-08',
        'Completed',
        '2026-03-10'
    ),
    (
        1026,
        15,
        102,
        '2026-01-18',
        'Completed',
        '2026-01-20'
    ),
    (
        1027,
        15,
        102,
        '2026-06-02',
        'Completed',
        '2026-06-05'
    ),
    (
        1028,
        16,
        103,
        '2026-02-12',
        'Completed',
        '2026-02-15'
    ),
    (
        1029,
        16,
        103,
        '2026-04-22',
        'Completed',
        '2026-04-24'
    ),
    (
        1030,
        18,
        105,
        '2026-03-14',
        'Completed',
        '2026-03-16'
    ),
    (
        1031,
        20,
        104,
        '2026-01-30',
        'Completed',
        '2026-02-02'
    ),
    (
        1032,
        20,
        104,
        '2026-05-05',
        'Completed',
        '2026-05-08'
    ),
    (
        1033,
        21,
        105,
        '2026-02-18',
        'Pending',
        NULL
    ),
    (
        1034,
        22,
        105,
        '2026-03-25',
        'Completed',
        '2026-03-28'
    );

-- ============================================================
-- 7. ORDER ITEMS
-- Discount is stored as a PERCENTAGE, e.g. 10.00 = 10%.
-- This supports Q44's discount calculation.
-- ============================================================

INSERT INTO
    order_items (
        order_item_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        discount
    )
VALUES (1, 1001, 4, 2, 1800.00, 10.00),
    (2, 1001, 1, 3, 250.00, 0.00),
    (3, 1002, 3, 2, 1500.00, 5.00),
    (4, 1002, 6, 4, 450.00, 0.00),
    (5, 1003, 7, 2, 1100.00, 10.00),
    (6, 1004, 12, 1, 1600.00, 5.00),
    (7, 1004, 10, 2, 700.00, 0.00),
    (8, 1005, 5, 2, 1250.00, 0.00),
    (9, 1006, 2, 3, 850.00, 5.00),
    (10, 1006, 15, 4, 300.00, 0.00),
    (11, 1007, 4, 1, 1800.00, 0.00),
    (12, 1007, 9, 2, 650.00, 10.00),
    (
        13,
        1008,
        11,
        2,
        1400.00,
        10.00
    ),
    (14, 1008, 14, 3, 500.00, 0.00),
    (15, 1009, 13, 1, 950.00, 0.00),
    (16, 1010, 1, 5, 250.00, 0.00),
    (
        17,
        1011,
        18,
        2,
        1200.00,
        5.00
    ),
    (18, 1011, 16, 3, 550.00, 0.00),
    (
        19,
        1012,
        19,
        2,
        2500.00,
        10.00
    ),
    (20, 1012, 17, 2, 750.00, 0.00),
    (21, 1013, 3, 3, 1500.00, 5.00),
    (22, 1014, 10, 4, 700.00, 0.00),
    (23, 1014, 1, 2, 250.00, 0.00),
    (24, 1015, 5, 2, 1250.00, 5.00),
    (25, 1015, 6, 3, 450.00, 0.00),
    (
        26,
        1016,
        12,
        2,
        1600.00,
        10.00
    ),
    (27, 1017, 9, 3, 650.00, 0.00),
    (28, 1017, 15, 2, 300.00, 0.00),
    (
        29,
        1018,
        4,
        3,
        1800.00,
        10.00
    ),
    (30, 1018, 7, 2, 1100.00, 0.00),
    (31, 1019, 3, 2, 1500.00, 0.00),
    (
        32,
        1019,
        18,
        2,
        1200.00,
        5.00
    ),
    (
        33,
        1020,
        19,
        3,
        2500.00,
        10.00
    ),
    (34, 1021, 2, 4, 850.00, 0.00),
    (35, 1021, 16, 2, 550.00, 0.00),
    (36, 1022, 8, 2, 900.00, 0.00),
    (
        37,
        1023,
        11,
        2,
        1400.00,
        5.00
    ),
    (38, 1023, 13, 2, 950.00, 0.00),
    (
        39,
        1024,
        12,
        2,
        1600.00,
        10.00
    ),
    (40, 1024, 10, 2, 700.00, 0.00),
    (41, 1025, 14, 5, 500.00, 0.00),
    (42, 1025, 1, 4, 250.00, 0.00),
    (43, 1026, 7, 2, 1100.00, 5.00),
    (44, 1026, 9, 2, 650.00, 0.00),
    (
        45,
        1027,
        4,
        2,
        1800.00,
        10.00
    ),
    (
        46,
        1028,
        18,
        1,
        1200.00,
        0.00
    ),
    (47, 1028, 17, 3, 750.00, 0.00),
    (
        48,
        1029,
        19,
        2,
        2500.00,
        10.00
    ),
    (49, 1030, 16, 4, 550.00, 0.00),
    (50, 1030, 2, 2, 850.00, 0.00),
    (51, 1031, 3, 2, 1500.00, 5.00),
    (52, 1031, 6, 4, 450.00, 0.00),
    (
        53,
        1032,
        19,
        2,
        2500.00,
        10.00
    ),
    (
        54,
        1032,
        12,
        1,
        1600.00,
        0.00
    ),
    (55, 1033, 5, 1, 1250.00, 0.00),
    (
        56,
        1034,
        11,
        1,
        1400.00,
        0.00
    ),
    (57, 1034, 10, 3, 700.00, 0.00);

-- ============================================================
-- 8. VALIDATION / QUICK CHECKS
-- ============================================================

SELECT 'departments' AS table_name, COUNT(*) AS row_count
FROM departments
UNION ALL
SELECT 'employees', COUNT(*)
FROM employees
UNION ALL
SELECT 'customers', COUNT(*)
FROM customers
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'order_items', COUNT(*)
FROM order_items;

-- Customers with no orders
SELECT c.customer_id, c.customer_name
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE
    o.order_id IS NULL;

-- Products never ordered
SELECT p.product_id, p.product_name
FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE
    oi.product_id IS NULL;

-- Department with no employees
SELECT d.department_id, d.department_name
FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
WHERE
    e.employee_id IS NULL;

-- Employees with managers
SELECT e.employee_name, m.employee_name AS manager_name
FROM employees e
    LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

-- Salary ties for ranking exercises
SELECT salary, COUNT(*) AS employee_count
FROM employees
GROUP BY
    salary
HAVING
    COUNT(*) > 1
ORDER BY salary DESC;

-- ============================================================
-- 9. HELPER VIEW FOR ADVANCED SALES QUESTIONS
-- The original PDF sometimes refers to order_value/daily_sales
-- even though those are not physical columns. These views make
-- the concepts easy to practice without changing the base schema.
-- ============================================================

CREATE OR REPLACE VIEW order_values AS
SELECT
    o.order_id,
    o.customer_id,
    o.employee_id,
    o.order_date,
    o.status,
    o.shipping_date,
    SUM(
        oi.quantity * oi.unit_price * (1 - oi.discount / 100)
    ) AS order_value,
    SUM(oi.quantity * oi.unit_price) AS gross_order_value
FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.customer_id,
    o.employee_id,
    o.order_date,
    o.status,
    o.shipping_date;

CREATE OR REPLACE VIEW daily_sales AS
SELECT
    o.order_date,
    SUM(
        oi.quantity * oi.unit_price * (1 - oi.discount / 100)
    ) AS daily_sales,
    SUM(oi.quantity * oi.unit_price) AS gross_daily_sales
FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    o.order_date;

-- ============================================================
-- 10. OPTIONAL CHECK QUERIES FOR THE TRAINER
-- ============================================================

-- Q31: products above average price
SELECT *
FROM products
WHERE
    price > (
        SELECT AVG(price)
        FROM products
    );

-- Q33: customers with at least one order
SELECT *
FROM customers
WHERE
    customer_id IN (
        SELECT customer_id
        FROM orders
    );

-- Q34: customers with no orders
SELECT *
FROM customers
WHERE
    customer_id NOT IN(
        SELECT customer_id
        FROM orders
    );

-- Q35: products that have been ordered
SELECT *
FROM products p
WHERE
    EXISTS (
        SELECT 1
        FROM order_items oi
        WHERE
            oi.product_id = p.product_id
    );

-- Q58: product above its category average
SELECT *
FROM products p
WHERE
    price > (
        SELECT AVG(p2.price)
        FROM products p2
        WHERE
            p2.category = p.category
    );

-- Q59: employees above department average
SELECT *
FROM employees e
WHERE
    salary > (
        SELECT AVG(e2.salary)
        FROM employees e2
        WHERE
            e2.department_id = e.department_id
    );

-- Q62: highest-paid employee
SELECT *
FROM employees
WHERE
    salary = (
        SELECT MAX(salary)
        FROM employees
    );

-- Q63: second-highest salary
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE
    salary < (
        SELECT MAX(salary)
        FROM employees
    );

-- Q72: top 3 employees per department
WITH
    ranked_employees AS (
        SELECT e.*, RANK() OVER (
                PARTITION BY
                    department_id
                ORDER BY salary DESC
            ) AS rnk
        FROM employees e
    )
SELECT *
FROM ranked_employees
WHERE
    rnk <= 3;

-- Q100: top 3 customers in each country with country percentage
WITH
    customer_sales AS (
        SELECT c.customer_id, c.customer_name, c.country, SUM(
                oi.quantity * oi.unit_price * (1 - oi.discount / 100)
            ) AS revenue
        FROM
            customers c
            JOIN orders o ON c.customer_id = o.customer_id
            JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY
            c.customer_id,
            c.customer_name,
            c.country
    ),
    ranked AS (
        SELECT
            *,
            RANK() OVER (
                PARTITION BY
                    country
                ORDER BY revenue DESC
            ) AS country_rank,
            SUM(revenue) OVER (
                PARTITION BY
                    country
            ) AS country_total
        FROM customer_sales
    )
SELECT
    customer_name,
    country,
    revenue,
    country_rank,
    ROUND(
        revenue / country_total * 100,
        2
    ) AS country_percentage
FROM ranked
WHERE
    country_rank <= 3
ORDER BY
    country,
    country_rank,
    customer_name;

-- ============================================================
-- END
-- ============================================================

-- CREATE TABLE departments (
--     department_id INT PRIMARY KEY,
--     department_name VARCHAR(50),
--     location VARCHAR(50)
-- );

-- CREATE TABLE employees (
--     employee_id INT PRIMARY KEY,
--     employee_name VARCHAR(100),
--     department_id INT,
--     manager_id INT NULL,
--     salary DECIMAL(10, 2),
--     hire_date DATE,
--     job_title VARCHAR(50),
--     FOREIGN KEY (department_id) REFERENCES departments (department_id)
-- );

-- CREATE TABLE customers (
--     customer_id INT PRIMARY KEY,
--     customer_name VARCHAR(100),
--     city VARCHAR(50),
--     state VARCHAR(50),
--     country VARCHAR(50),
--     segment VARCHAR(30),
--     signup_date DATE,
--     sales_rep_id INT NULL
-- );

-- CREATE TABLE products (
--     product_id INT PRIMARY KEY,
--     product_name VARCHAR(100),
--     category VARCHAR(50),
--     subcategory VARCHAR(50),
--     price DECIMAL(10, 2),
--     cost DECIMAL(10, 2),
--     supplier_id INT NULL
-- );

-- CREATE TABLE orders (
--     order_id INT PRIMARY KEY,
--     customer_id INT,
--     employee_id INT,
--     order_date DATE,
--     status VARCHAR(30),
--     shipping_date DATE NULL,
--     FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
--     FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
-- );

-- CREATE TABLE order_items (
--     order_item_id INT PRIMARY KEY,
--     order_id INT,
--     product_id INT,
--     quantity INT,
--     unit_price DECIMAL(10, 2),
--     discount DECIMAL(5, 2),
--     FOREIGN KEY (order_id) REFERENCES orders (order_id),
--     FOREIGN KEY (product_id) REFERENCES products (product_id)
-- );

-- PART A — BASIC
-- Queries 1–35
-- These concentrate on fundamentals and simple combinations.

-- Q1 — Basic SELECT
-- Error type: SEM
SELECT customer_id, customer_name, salary FROM customers;

-- Task: Find the error.

-- Q2 — WHERE
-- Error type: SYN
SELECT * FROM customers WHERE country = 'India' AND;

-- Q3 — Comparison Operator
-- Error type: LOG
SELECT * FROM products WHERE price < 500 AND price > 1000;

-- Q4 — BETWEEN
-- Error type: SEM
SELECT * FROM products WHERE price BETWEEN 1000 AND 500;

-- Q5 — IN
-- Error type: SYN
SELECT * FROM customers WHERE country IN 'India', 'USA';

-- Q6 — LIKE
-- Error type: LOG
SELECT * FROM customers WHERE customer_name LIKE '%a';

-- Task: Find customers whose names start with A.

-- Q7 — NULL
-- Error type: SEM
SELECT * FROM customers WHERE sales_rep_id = NULL;

-- Q8 — DISTINCT
-- Error type: LOG
SELECT DISTINCT customer_id, city FROM customers;

-- SELECT DISTINCT city
-- FROM customers;

-- Task: Find distinct cities only.

-- Q9 — ORDER BY
-- Error type: SYN
SELECT customer_name, city FROM customers ORDER BY city DESCENDING;

-- Q10 — LIMIT
-- Error type: LOG
SELECT * FROM products ORDER BY price DESC LIMIT 5, 10;

-- Task: Find the five most expensive products.

-- Q11 — AND / OR
-- Error type: LOG
SELECT *
FROM products
WHERE
    category = 'Electronics'
    OR category = 'Furniture'
    AND price > 1000;

-- Task: Products must be either Electronics or Furniture and price > 1000.

-- Q12 — Parentheses
-- Error type: LOG
SELECT *
FROM customers
WHERE
    country = 'India'
    AND segment = 'Consumer'
    OR segment = 'Corporate';

-- Task: Find Indian customers belonging to Consumer or Corporate.

-- Q13 — CASE
-- Error type: SYN
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 1000 THEN 'Expensive'
        WHEN price >= 500 'Medium'
        ELSE 'Cheap'
    END AS price_category
FROM products;

-- Q14 — Calculated Column
-- Error type: SEM
SELECT product_name, price, cost,
    --     price - price AS profit
FROM products;

-- Q15 — Aggregate
-- Error type: LOG
SELECT COUNT(customer_id) FROM customers;

-- Task: Count all customers, including customers where customer_id could be NULL.

-- Q16 — SUM
-- Error type: SEM
SELECT SUM(price)
FROM products
WHERE
    category = 'Electronics'
GROUP BY
    product_name;

-- Task: Find total Electronics sales value, not one total per product.

-- Q17 — AVG
-- Error type: SYN
SELECT AVG(price), category
FROM products
    -- GROUP category;

-- Q18 — GROUP BY
-- Error type: SEM
SELECT category, product_name, AVG(price)
FROM products
GROUP BY
    category;

-- Q19 — HAVING
-- Error type: LOG
SELECT category, AVG(price) AS avg_price
FROM products
WHERE
    AVG(price) > 1000
GROUP BY
    category;

-- Q20 — WHERE vs HAVING
-- Error type: LOG
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY
    category
HAVING
    category = 'Electronics'
    AND product_count > 5;

-- JOINS — BASIC
-- Q21 — INNER JOIN
-- Error type: SYN
SELECT
    --     c.customer_name,
    --     o.order_id
FROM customers c
    JOIN orders o ON c.customer_id o.customer_id;

-- Q22 — INNER JOIN + filter
-- Error type: LOG
SELECT
    --     c.customer_name,
    --     o.order_id
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
WHERE
    o.status = 'Completed'
    AND c.country = 'India'
    OR c.country = 'USA';

-- Task: Completed orders from customers in India or USA.

-- Q23 — LEFT JOIN
-- Error type: LOG
SELECT
    --     c.customer_name,
    --     o.order_id
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE
    o.order_id IS NOT NULL;

-- Task: Return all customers, including customers with no orders.

-- Q24 — RIGHT JOIN
-- Error type: SEM
SELECT
    --     c.customer_name,
    --     o.order_id
FROM customers c
    RIGHT JOIN orders o ON c.customer_id = o.order_id;

-- Q25 — Three-table JOIN
-- Error type: SYN
SELECT
    --     c.customer_name,
    --     o.order_id,
    --     oi.quantity
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi
    --     oi.order_id = o.order_id;

-- Q26 — JOIN Products
-- Error type: LOG
SELECT
    --     o.order_id,
    --     p.product_name,
    --     oi.quantity
FROM
    orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = oi.product_id;

-- Q27 — Four-table JOIN
-- Error type: SEM
SELECT
    --     c.customer_name,
    --     o.order_id,
    --     p.product_name,
    --     oi.quantity
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
WHERE
    oi.quantity = 0;

-- Task: Find orders containing products with quantity greater than zero.

-- Q28 — LEFT JOIN + COUNT
-- Error type: LOG
SELECT
    --     c.customer_name,
    COUNT(o.order_id) AS orders
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE
    COUNT(o.order_id) > 2
GROUP BY
    c.customer_name;

-- Q29 — GROUP BY + JOIN
-- Error type: SEM
SELECT
    --     c.country,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_id;

-- Q30 — Employee Department
-- Error type: LOG
SELECT
    --     e.employee_name,
    --     d.department_name
FROM employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
WHERE
    d.department_name IS NULL;

-- Task: Find employees who belong to a department.

-- SUBQUERIES — BASIC
-- Q31
-- Error type: LOG
-- Find products more expensive than the average product price.
SELECT *
FROM products
WHERE
    price > (
        SELECT price
        FROM products
    );

-- Q32
-- Error type: SYN
SELECT * FROM products WHERE price > SELECT AVG(price) FROM products;

-- Q33
-- Error type: SEM
-- Find customers who have placed at least one order.
SELECT *
FROM customers
WHERE
    customer_id IN (
        SELECT order_id
        FROM orders
    );

-- Q34
-- Error type: LOG
-- Find customers who have never placed an order.
SELECT *
FROM customers
WHERE
    customer_id IN (
        SELECT customer_id
        FROM orders
    );

-- Q35
-- Error type: SEM
SELECT *
FROM products p
WHERE
    EXISTS (
        SELECT product_id
        FROM order_items oi
    );

-- Task: Find products that have actually been ordered.

-- PART B — MEDIUM
-- Queries 36–70
-- Now the trainee must combine multiple concepts.

-- Q36 — Aggregation + JOIN
-- Error type: LOG
SELECT
    --     c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_id;

-- Q37 — Revenue by product
-- Error type: SEM
SELECT
    --     p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY
    p.category;

-- Q38 — HAVING
-- Error type: LOG
SELECT
    --     c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_name
HAVING
    total_sales > 10000;

-- Q39 — Conditional Aggregation
-- Error type: LOG
SELECT
    --     customer_id,
    SUM(status = 'Completed') AS completed_orders
FROM orders
GROUP BY
    customer_id;

-- Task: Count completed orders using conditional aggregation.

-- Q40 — Date Filter
-- Error type: SEM
SELECT *
FROM orders
WHERE
    order_date BETWEEN '2026-01-01' AND '2026-01-31'
    AND shipping_date <= order_date;

-- Task: Find orders shipped after the order date.

-- Q41 — DATE functions
-- Error type: SYN
SELECT YEAR(order_date) AS year, MONTH(order_date) AS month, COUNT(*) AS orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY year month;

-- Q42 — GROUP BY expression
-- Error type: LOG
SELECT YEAR(order_date) AS order_year, COUNT(*) AS total_orders
FROM orders
GROUP BY
    order_date;

-- Q43 — Product margin
-- Error type: LOG
SELECT product_name, price, cost,
    --     price + cost AS margin
FROM products;

-- Q44 — Discount
-- Error type: SEM
-- Assume discount is percentage.
SELECT product_id,
    --     quantity * unit_price AS gross_sales,
    --     quantity * unit_price - discount AS net_sales
FROM order_items;

-- Q45 — DISTINCT customers
-- Error type: LOG
SELECT COUNT(customer_id) FROM orders;

-- Task: Count distinct customers who ordered.

JOIN COMBINATIONS
-- Q46 — LEFT JOIN + aggregation
-- Error type: LOG
SELECT
    --     c.customer_name,
    COUNT(*) AS order_count
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_name;

-- Q47 — Customers with zero orders
-- Error type: LOG
SELECT
    --     c.customer_name
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE
    o.order_id = NULL;

-- Q48 — Customers with multiple orders
-- Error type: SYN
SELECT
    --     c.customer_name,
    COUNT(o.order_id)
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_name
HAVING
    COUNT(o.order_id) >;

-- Q49 — Employees + managers
-- Self join.
-- Error type: SEM
SELECT
    --     e.employee_name,
    --     m.employee_name AS manager_name
FROM employees e
    JOIN employees m ON e.employee_id = m.manager_id;

-- Q50 — Employee's manager
-- Error type: LOG
SELECT
    --     e.employee_name,
    --     m.employee_name AS manager_name
FROM employees e
    LEFT JOIN employees m ON e.manager_id = e.employee_id;

-- Q51 — Department salary
-- Error type: LOG
SELECT
    --     d.department_name,
    AVG(e.salary) AS avg_salary
FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
WHERE
    e.salary > 50000
GROUP BY
    d.department_name;

-- Q52 — Departments without employees
-- Error type: LOG
SELECT d.department_name
FROM departments d
    INNER JOIN employees e ON d.department_id = e.department_id
WHERE
    e.employee_id IS NULL;

-- Q53 — CROSS JOIN
-- Error type: SEM
SELECT
    --     c.customer_name,
    --     p.product_name
FROM customers c
    CROSS JOIN products p ON c.customer_id = p.product_id;

-- Q54 — FULL OUTER JOIN simulation
-- MySQL does not directly support FULL OUTER JOIN.
-- Error type: SYN
SELECT *
FROM customers c FULL OUTER
    JOIN orders o ON c.customer_id = o.customer_id;

SET
    OPERATORS
    -- Q55 — UNION
    -- Error type: SEM
SELECT customer_id
FROM customers
UNION
SELECT customer_name
FROM customers;

-- Q56 — UNION ALL
-- Error type: LOG
SELECT customer_id
FROM customers
UNION ALL
SELECT customer_id
FROM orders;
-- Task: Return customer IDs appearing in either table.

-- Q57 — INTERSECT alternative
-- MySQL 8.0 does not support INTERSECT in the traditional MySQL approach.
-- Error type: SYN
SELECT customer_id
FROM customers INTERSECT
SELECT customer_id
FROM orders;

SUBQUERIES
-- Q58 — Correlated subquery
-- Error type: LOG
-- Find products whose price is greater than the average price of their own category.
SELECT *
FROM products p
WHERE
    price > (
        SELECT AVG(price)
        FROM products
    );

-- Q59
-- Error type: SEM
-- Find employees earning above their department average.
SELECT *
FROM employees e
WHERE
    salary > (
        SELECT AVG(salary)
        FROM employees x
        WHERE
            x.department_id = x.department_id
    );

-- Q60 — EXISTS
-- Error type: LOG
SELECT *
FROM customers c
WHERE
    EXISTS (
        SELECT 1
        FROM orders o
        WHERE
            o.customer_id != c.customer_id
    );

-- Q61 — NOT EXISTS
-- Error type: LOG
-- Find products never ordered.
SELECT *
FROM products p
WHERE
    NOT EXISTS (
        SELECT 1
        FROM order_items oi
        WHERE
            oi.product_id != p.product_id
    );

-- Q62 — MAX subquery
-- Error type: LOG
-- Find the highest-paid employee.
SELECT *
FROM employees
WHERE
    salary < (
        SELECT MAX(salary)
        FROM employees
    );

-- Q63 — Second highest salary
-- Error type: LOG
SELECT MAX(salary) FROM employees WHERE salary < MAX(salary);

WINDOW FUNCTIONS
-- Q64 — ROW_NUMBER
-- Error type: SYN
SELECT
    employee_name,
    salary,
--     ROW_NUMBER OVER (
        ORDER BY salary DESC
    ) AS rn
FROM employees;

-- Q65 — RANK
-- Error type: LOG
SELECT
    employee_name,
    salary,
    RANK() OVER (
        ORDER BY salary ASC
    ) AS salary_rank
FROM employees;
-- Task: Highest salary should have rank 1.

-- Q66 — PARTITION BY
-- Error type: SEM
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY
            employee_id
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;

-- Q67 — Department ranking
-- Error type: LOG
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;
-- Task: Rank employees within each department.

-- Q68 — DENSE_RANK
-- Error type: LOG
SELECT
    employee_name,
    salary,
    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees
WHERE
    salary_rank <= 3;

-- Q69 — LAG
-- Error type: SYN
SELECT order_id, order_date, LAG(order_date) OVER
ORDER BY order_date AS previous_date
FROM orders;

-- Q70 — Running total
-- Error type: LOG
SELECT order_date, SUM(total_sales) OVER (
        ORDER BY order_date
    ) AS running_sales
FROM orders;

-- PART C — HARD
-- Queries 71–100
-- These combine joins, CTEs, subqueries, windows, aggregates and business logic.

-- Q71 — Top 3 employees per department
-- Error type: LOG
SELECT *
FROM (
        SELECT
            employee_name, department_id, salary, RANK() OVER (
                ORDER BY salary DESC
            ) AS rnk
        FROM employees
    ) x
WHERE
    rnk <= 3;

-- Q72 — Correct partition but wrong ranking
-- Error type: LOG
SELECT *
FROM (
        SELECT
            employee_name, department_id, salary, RANK() OVER (
                PARTITION BY
                    department_id
                ORDER BY salary ASC
            ) AS rnk
        FROM employees
    ) x
WHERE
    rnk <= 3;
-- Task: Top three highest-paid employees per department.

-- Q73 — Top product per category
-- Error type: LOG
SELECT *
FROM (
        SELECT
            product_name, category, price, ROW_NUMBER() OVER (
                PARTITION BY
                    category
                ORDER BY price ASC
            ) AS rn
        FROM products
    ) x
WHERE
    rn = 1;

-- Q74 — Revenue ranking
-- Error type: SEM
SELECT
    --     p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue, RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY
    p.product_name;

-- Q75 — Customer ranking
-- Error type: LOG
SELECT
    --     c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales, RANK() OVER (
        PARTITION BY
            c.customer_id
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS rnk
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name;
-- Task: Rank customers globally by sales.

-- Q76 — LAG sales
-- Error type: LOG
SELECT
    order_date,
    SUM(oi.quantity * oi.unit_price) AS daily_sales,
    LAG(
        SUM(oi.quantity * oi.unit_price)
    ) OVER (
        ORDER BY order_date
    ) AS previous_sales
FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    order_date;
-- Task: Find the difference from previous day's sales.

-- Q77 — LEAD
-- Error type: SYN
SELECT order_date, LEAD(order_date) OVER (
        ORDER BY order_date
    ) AS next_order_date
FROM orders

-- Q78 — Running revenue
-- Error type: LOG
SELECT
    --     o.order_date,
    SUM(oi.quantity * oi.unit_price) AS daily_sales,
    SUM(oi.quantity * oi.unit_price) OVER (
        ORDER BY o.order_date
    ) AS running_sales
FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    o.order_date;

-- Q79 — Moving average
-- Error type: LOG
SELECT
    order_date,
    daily_sales,
    AVG(daily_sales) OVER (
        ORDER BY order_date ROWS BETWEEN 7 PRECEDING
            AND CURRENT ROW
    ) AS moving_avg
FROM daily_sales;

-- Assume daily_sales is not a table.

-- Q80 — CTE
-- Error type: SYN
WITH
    customer_sales AS
SELECT
    --     c.customer_id,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    c.customer_id

SELECT * FROM customer_sales;

-- Q81 — CTE + HAVING
-- Error type: LOG
WITH
    customer_sales AS (
        SELECT
            --         c.customer_id,
            SUM(oi.quantity * oi.unit_price) AS total_sales
        FROM
            customers c
            JOIN orders o ON c.customer_id = o.customer_id
            JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY
            c.customer_id
    )
SELECT *
FROM customer_sales
WHERE
    total_sales > 10000;

-- Q82 — Customer above average
-- Error type: LOG
WITH
    customer_sales AS (
        SELECT
            --         customer_id,
            SUM(oi.quantity * oi.unit_price) AS total_sales
        FROM orders o
            JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY
            customer_id
    )
SELECT *
FROM customer_sales
WHERE
    total_sales > AVG(total_sales);

-- Q83 — CTE + ranking
-- Error type: LOG
WITH
    customer_sales AS (
        SELECT
            --         c.customer_id,
            --         c.customer_name,
            SUM(oi.quantity * oi.unit_price) AS total_sales
        FROM
            customers c
            JOIN orders o ON c.customer_id = o.customer_id
            JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY
            c.customer_id,
            c.customer_name
    )
SELECT *, RANK() OVER (
        PARTITION BY
            customer_id
        ORDER BY total_sales DESC
    ) AS rnk
FROM customer_sales;

-- Q84 — Department average
-- Error type: LOG
SELECT
    --     e.employee_name,
    --     e.department_id,
    --     e.salary,
    AVG(e.salary) OVER () AS dept_avg
FROM employees e;

-- Q85 — Salary difference from department average
-- Error type: LOG
SELECT
    employee_name,
    department_id,
    salary,
    --     salary - AVG(salary) OVER () AS difference
FROM employees;

-- Q86 — Employee salary percentage
-- Error type: LOG
SELECT employee_name, salary,
    --     salary / SUM(salary) OVER () AS salary_percentage
FROM employees;

-- Task: Percentage of total departmental salary.

-- Q87 — Duplicate customers
-- Error type: SEM
SELECT customer_name, COUNT(*)
FROM customers
GROUP BY
    customer_id
HAVING
    COUNT(*) > 1;

-- Q88 — Duplicate detection using window
-- Error type: LOG
SELECT *
FROM (
        SELECT
            --         customer_name,
            ROW_NUMBER() OVER (
                PARTITION BY
                    customer_id
                ORDER BY customer_name
            ) AS rn
        FROM customers
    ) x
WHERE
    rn = 2;

-- Q89 — Latest order per customer
-- Error type: LOG
SELECT
    --     customer_id,
    order_id, order_date
FROM (
        SELECT
            --         customer_id,
            order_id, order_date, ROW_NUMBER() OVER (
                PARTITION BY
                    customer_id
                ORDER BY order_date ASC
            ) AS rn
        FROM orders
    ) x
WHERE
    rn = 1;

-- Q90 — Second highest salary per department
-- Error type: LOG
SELECT *
FROM (
        SELECT
            employee_name, department_id, salary, DENSE_RANK() OVER (
                PARTITION BY
                    department_id
                ORDER BY salary DESC
            ) AS rnk
        FROM employees
    ) x
WHERE
    rnk = 1;

ADVANCED COMBINATIONS
-- Q91 — Customer's first and last order
-- Error type: LOG
SELECT
    --     customer_id,
    FIRST_VALUE(order_date) OVER (
        PARTITION BY
            customer_id
        ORDER BY order_date DESC
    ) AS first_order,
    LAST_VALUE(order_date) OVER (
        PARTITION BY
            customer_id
        ORDER BY order_date
    ) AS last_order
FROM orders;

-- Q92 — Orders between first and last order
-- Error type: SEM
SELECT
    --     customer_id,
    COUNT(*) AS orders
FROM orders
GROUP BY
    customer_id
HAVING
    order_date BETWEEN MIN(order_date) AND MAX(order_date);

-- Q93 — Customer order sequence
-- Error type: LOG
SELECT
    --     customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER (
        ORDER BY order_date
    ) AS order_number
FROM orders;
-- Task: Number orders separately for each customer.

-- Q94 — Time between orders
-- Error type: SEM
SELECT
    --     customer_id,
    order_date, DATEDIFF(
        order_date, LAG(order_date) OVER (
            PARTITION BY
                customer_id
            ORDER BY order_date
        )
    ) AS days_between
FROM orders;

-- Q95 — Customers with increasing order values
-- Error type: LOG
SELECT
    --     customer_id,
    order_id,
    order_value,
    LAG(order_value) OVER (
        ORDER BY order_date
    ) AS previous_value
FROM orders;
-- Assume order_value is not an existing column.

-- Q96 — Highest-selling category
-- Error type: LOG
SELECT
    --     p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY
    p.category
ORDER BY revenue ASC
LIMIT 1;

-- Q97 — Category percentage of total revenue
-- Error type: LOG
SELECT
    --     p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue, SUM(oi.quantity * oi.unit_price)
    --         / SUM(SUM(oi.quantity * oi.unit_price))
    OVER (
        PARTITION BY
            p.category
    ) AS percentage
FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY
    p.category;

-- Q98 — Top customer in each country
-- Error type: LOG
WITH
    customer_sales AS (
        SELECT
            --         c.customer_id,
            --         c.customer_name,
            --         c.country,
            SUM(oi.quantity * oi.unit_price) AS sales
        FROM
            customers c
            JOIN orders o ON c.customer_id = o.customer_id
            JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY
            --         c.customer_id,
            --         c.customer_name,
            --         c.country
    )
SELECT *
FROM (
        SELECT *, RANK() OVER (
                ORDER BY sales DESC
            ) AS rnk
        FROM customer_sales
    ) x
WHERE
    rnk = 1;

-- Q99 — Employees earning above department average AND company average
-- Error type: LOG
SELECT
    employee_name,
    department_id,
    salary
FROM employees e
WHERE
    salary > (
        SELECT AVG(salary)
        FROM employees
        WHERE
            department_id = e.department_id
    )
    AND salary > (
        SELECT AVG(salary)
        FROM employees
        WHERE
            department_id = e.department_id
    );

-- Q100 — Advanced sales analysis
-- Error type: LOG
-- Find the top 3 customers in each country based on total revenue, including:
-- customer
-- country
-- revenue
-- rank
-- percentage of country revenue
WITH
    customer_sales AS (
        SELECT c.customer_id, c.customer_name, c.country, SUM(oi.quantity * oi.unit_price) AS revenue
        FROM
            customers c
            JOIN orders o ON c.customer_id = o.customer_id
            JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY
            c.customer_id,
            c.customer_name,
            c.country
    )
SELECT
    customer_name,
    country,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS country_rank,
    revenue / SUM(revenue) OVER () * 100 AS country_percentage
FROM customer_sales
WHERE
    country_rank <= 3;
