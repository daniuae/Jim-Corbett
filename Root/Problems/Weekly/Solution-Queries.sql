CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_date DATE,
    purchase_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

INSERT INTO
    customers (
        customer_id,
        customer_name,
        city
    )
VALUES (101, 'Rahul', 'Bangalore'),
    (102, 'Priya', 'Chennai'),
    (103, 'Arjun', 'Hyderabad'),
    (104, 'Sneha', 'Pune');

INSERT INTO
    purchases (
        purchase_id,
        customer_id,
        purchase_date,
        purchase_amount
    )
VALUES (
        5001,
        101,
        '2025-01-10',
        1250.00
    ),
    (
        5002,
        101,
        '2025-02-15',
        1850.00
    ),
    (
        5003,
        101,
        '2025-03-20',
        2200.00
    ),
    (
        5004,
        102,
        '2025-01-05',
        950.00
    ),
    (
        5005,
        102,
        '2025-02-25',
        1750.00
    ),
    (
        5006,
        103,
        '2025-01-18',
        3200.00
    ),
    (
        5007,
        103,
        '2025-03-12',
        2800.00
    ),
    (
        5008,
        103,
        '2025-04-05',
        4500.00
    ),
    (
        5009,
        104,
        '2025-02-10',
        1500.00
    ),
    (
        5010,
        104,
        '2025-03-30',
        2100.00
    );

SELECT c.customer_name, p.purchase_date, p.purchase_amount
FROM customers c
    JOIN purchases p ON c.customer_id = p.customer_id
WHERE
    p.purchase_date = (
        SELECT MAX(p2.purchase_date)
        FROM purchases p2
        WHERE
            p2.customer_id = p.customer_id
    );

-- SELECT c.customer_name, p.purchase_date, p.purchase_amount, ROW_NUMBER() OVER (
--         PARTITION BY
--             p.customer_id
--         ORDER BY p.purchase_date DESC
--     ) AS rn
-- FROM customers c
--     JOIN purchases p ON c.customer_id = p.customer_id;





-- ============================================================
-- Find the most recent purchase made by each SmartMart customer
-- along with the purchase date and amount.
--
-- Approach: Correlated Subquery
-- ============================================================


-- ============================================================
-- 1. UNDERSTAND THE TABLES
-- ============================================================

-- customers
--
-- customer_id | customer_name | city
-- ------------|---------------|----------
-- 1           | Ravi           | Chennai
-- 2           | Priya          | Bangalore


-- purchases
--
-- purchase_id | customer_id | purchase_date | purchase_amount
-- ------------|-------------|---------------|----------------
-- 101         | 1           | 2026-08-01    | 500
-- 102         | 1           | 2026-08-15    | 800
-- 103         | 2           | 2026-08-05    | 300


-- Relationship:
--
-- customers
--     |
--     | customer_id
--     |
-- purchases


-- ============================================================
-- 2. WHAT DOES "RECENT PURCHASE" MEAN?
-- ============================================================

-- For EACH customer, we need:
--
-- MAX(purchase_date)


-- Customer 1:
--
-- 2026-08-01
-- 2026-08-15
--
-- MAX = 2026-08-15


-- Customer 2:
--
-- 2026-08-05
--
-- MAX = 2026-08-05


-- Problem pattern:
--
-- "Find the maximum value for each customer."


-- ============================================================
-- 3. WHY DO WE NEED A CORRELATED SUBQUERY?
-- ============================================================

-- The MAX() must be calculated for the CURRENT customer.


-- This is NOT sufficient:
--
-- SELECT MAX(purchase_date)
-- FROM purchases;
--
-- Because this returns the most recent purchase across
-- ALL customers.


-- Instead, we calculate MAX() for each customer:
--
-- SELECT MAX(p2.purchase_date)
-- FROM purchases p2
-- WHERE p2.customer_id = c.customer_id;


-- Important condition:
--
-- WHERE p2.customer_id = c.customer_id
--
-- This connects the inner query to the current row
-- of the outer query.
--
-- Therefore, this is called a:
--
-- Correlated Subquery


-- ============================================================
-- 4. UNDERSTAND THE INNER QUERY FIRST
-- ============================================================

-- The inner query is:
--
-- SELECT MAX(p2.purchase_date)
-- FROM purchases p2
-- WHERE p2.customer_id = c.customer_id;


-- Suppose the outer query is currently processing:
--
-- customer_id = 1


-- Conceptually, the inner query becomes:
--
-- SELECT MAX(purchase_date)
-- FROM purchases
-- WHERE customer_id = 1;


-- Result:
--
-- 2026-08-15


-- For customer 2:
--
-- SELECT MAX(purchase_date)
-- FROM purchases
-- WHERE customer_id = 2;


-- Result:
--
-- 2026-08-05


-- Therefore:
--
-- The subquery produces a different MAX date
-- for each customer.


-- ============================================================
-- 5. OUTER QUERY
-- ============================================================

SELECT
    c.customer_name,
    p.purchase_date,
    p.purchase_amount
FROM customers c
JOIN purchases p
    ON c.customer_id = p.customer_id
WHERE p.purchase_date = (
    SELECT MAX(p2.purchase_date)
    FROM purchases p2
    WHERE p2.customer_id = c.customer_id
);


-- ============================================================
-- 6. BREAKING DOWN THE OUTER QUERY
-- ============================================================

-- SELECT
--
-- We want three columns:
--
-- 1. Customer name
-- 2. Purchase date
-- 3. Purchase amount


-- FROM customers c
--
-- Start with the customers table.
--
-- "c" is an alias for customers.
--
-- customers -> c


-- Therefore:
--
-- c.customer_name
--
-- means:
--
-- customer_name from customers.


-- ============================================================
-- 7. JOIN PURCHASES
-- ============================================================

-- JOIN purchases p
--     ON c.customer_id = p.customer_id
--
-- This connects each customer to their purchases.


-- After the JOIN, conceptually:
--
-- customer | purchase_date | amount
-- ---------|---------------|-------
-- Ravi     | Aug 1         | 500
-- Ravi     | Aug 15        | 800
-- Priya    | Aug 5         | 300


-- At this point, we still have ALL purchases.


-- ============================================================
-- 8. THE WHERE CLAUSE IS THE KEY
-- ============================================================

-- The condition is:
--
-- WHERE p.purchase_date = (
--     SELECT MAX(p2.purchase_date)
--     FROM purchases p2
--     WHERE p2.customer_id = c.customer_id
-- )


-- Meaning:
--
-- "Keep the purchase only when its date equals
--  the latest purchase date for that customer."


-- For Ravi:
--
-- Purchases:
-- 2026-08-01
-- 2026-08-15
--
-- MAX = 2026-08-15
--
-- 2026-08-01 -> FALSE -> discard
-- 2026-08-15 -> TRUE  -> keep


-- For Priya:
--
-- 2026-08-05
--
-- MAX = 2026-08-05
--
-- 2026-08-05 -> TRUE -> keep


-- ============================================================
-- 9. FINAL RESULT
-- ============================================================

-- customer_name | purchase_date | purchase_amount
-- --------------|---------------|----------------
-- Ravi          | 2026-08-15    | 800
-- Priya         | 2026-08-05    | 300


-- ============================================================
-- 10. LOGICAL FLOW
-- ============================================================

-- Customer
--     ↓
-- Find all purchases
--     ↓
-- For each customer
--     ↓
-- Find MAX(purchase_date)
--     ↓
-- Compare each purchase date with MAX date
--     ↓
-- Keep the matching purchase


-- ============================================================
-- 11. IMPORTANT PATTERN TO RECOGNIZE
-- ============================================================

-- When you see:
--
-- "Find the latest/recent purchase for each customer"
--
-- Recognize:
--
-- LATEST / MOST RECENT
--         ↓
-- MAX(date)
--         ↓
-- FOR EACH CUSTOMER
--         ↓
-- Correlation using customer_id


-- General pattern:
--
-- WHERE date_column = (
--     SELECT MAX(date_column)
--     FROM table
--     WHERE customer_id = outer.customer_id
-- )


-- This is a classic CORRELATED SUBQUERY pattern.


-- ============================================================
-- 12. IMPORTANT CORRECTION
-- ============================================================

-- Do NOT write:
--
-- WHERE MAX(p.purchase_date)
--
-- because MAX() is an aggregate function.


-- Instead, calculate MAX() inside the subquery:
--
-- WHERE p.purchase_date = (
--     SELECT MAX(p2.purchase_date)
--     FROM purchases p2
--     WHERE p2.customer_id = c.customer_id
-- )


-- ============================================================
-- 13. HOW TO THINK ABOUT IT
-- ============================================================

-- Outer query:
-- "What is this purchase?"
--
--         ↓
--
-- Inner query:
-- "What is the latest purchase date for THIS customer?"
--
--         ↓
--
-- Compare them
--
--         ↓
--
-- Keep the latest one.


-- ============================================================
-- 14. FIVE-STEP SQL PROBLEM-SOLVING METHOD
-- ============================================================

-- STEP 1: OUTPUT
--
-- customer_name
-- purchase_date
-- purchase_amount


-- STEP 2: OUTPUT GRAIN
--
-- One latest purchase per customer.


-- STEP 3: TABLES
--
-- customers
-- purchases


-- STEP 4: CALCULATION
--
-- MAX(purchase_date)


-- STEP 5: SQL PATTERN
--
-- Correlated subquery


-- ============================================================
-- FINAL SOLUTION
-- ============================================================

SELECT
    c.customer_name,
    p.purchase_date,
    p.purchase_amount
FROM customers c
JOIN purchases p
    ON c.customer_id = p.customer_id
WHERE p.purchase_date = (
    SELECT MAX(p2.purchase_date)
    FROM purchases p2
    WHERE p2.customer_id = c.customer_id
);
