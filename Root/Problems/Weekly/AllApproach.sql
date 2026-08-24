-- 1. Correlated subquery — your approach
SELECT c.customer_name, p.purchase_date, p.purchase_amount
FROM customers c
    JOIN purchases p ON c.customer_id = p.customer_id
WHERE
    p.purchase_date = (
        SELECT MAX(p1.purchase_date)
        FROM purchases p1
        WHERE
            p1.customer_id = p.customer_id
    );
-- Concept: For every purchase row, find the maximum purchase date for that customer.

-- 2. MAX() + GROUP BY + JOIN
-- First find the latest date for each customer, then join back to purchases.
SELECT c.customer_name, p.purchase_date, p.purchase_amount
FROM
    customers c
    JOIN (
        SELECT
            customer_id,
            MAX(purchase_date) AS latest_purchase_date
        FROM purchases
        GROUP BY
            customer_id
    ) latest ON c.customer_id = latest.customer_id
    JOIN purchases p ON p.customer_id = latest.customer_id
    AND p.purchase_date = latest.latest_purchase_date;
-- Concept:
-- GROUP BY customer
--        ↓
-- MAX(purchase_date)
--        ↓
-- JOIN back to purchases
-- This is one of the most important alternatives to understand.

-- 3. ROW_NUMBER() — best when you want exactly one row
SELECT
    customer_name,
    purchase_date,
    purchase_amount
FROM (
        SELECT c.customer_name, p.purchase_date, p.purchase_amount, ROW_NUMBER() OVER (
                PARTITION BY
                    p.customer_id
                ORDER BY p.purchase_date DESC
            ) AS rn
        FROM customers c
            JOIN purchases p ON c.customer_id = p.customer_id
    ) x
WHERE
    rn = 1;
-- Concept:
-- Each customer
--      ↓
-- Sort purchases DESC
--      ↓
-- Latest purchase = ROW_NUMBER 1
-- ⚠️ If two purchases have the same latest date, ROW_NUMBER() returns only one of them.
-- If you have purchase_id, make the ordering deterministic:
-- ROW_NUMBER() OVER (
--     PARTITION BY p.customer_id
--     ORDER BY p.purchase_date DESC,
--              p.purchase_id DESC
-- )

-- 4. RANK() — returns all tied latest purchases
-- If a customer has two purchases on the same latest date and you want both, use RANK().
SELECT
    customer_name,
    purchase_date,
    purchase_amount
FROM (
        SELECT c.customer_name, p.purchase_date, p.purchase_amount, RANK() OVER (
                PARTITION BY
                    p.customer_id
                ORDER BY p.purchase_date DESC
            ) AS rnk
        FROM customers c
            JOIN purchases p ON c.customer_id = p.customer_id
    ) x
WHERE
    rnk = 1;
-- Example:
-- Customer A

-- 2026-08-20   ₹500   ← RANK 1
-- 2026-08-20   ₹700   ← RANK 1
-- 2026-08-15   ₹300   ← RANK 3
-- Both August 20 purchases are returned.

-- 5. DENSE_RANK()
-- You can also use DENSE_RANK():
SELECT
    customer_name,
    purchase_date,
    purchase_amount
FROM (
        SELECT c.customer_name, p.purchase_date, p.purchase_amount, DENSE_RANK() OVER (
                PARTITION BY
                    p.customer_id
                ORDER BY p.purchase_date DESC
            ) AS dr
        FROM customers c
            JOIN purchases p ON c.customer_id = p.customer_id
    ) x
WHERE
    dr = 1;
-- For = 1, this behaves like RANK() for this particular requirement.

-- 6. NOT EXISTS — very useful interview approach

SELECT c.customer_name, p.purchase_date, p.purchase_amount
FROM customers c
    JOIN purchases p ON c.customer_id = p.customer_id
WHERE
    NOT EXISTS (
        SELECT 1
        FROM purchases p2
        WHERE
            p2.customer_id = p.customer_id
            AND p2.purchase_date > p.purchase_date
    );
-- This returns all purchases for which no later purchase exists.
-- It therefore handles ties naturally.

-- 7. ALL subquery
-- Another less commonly used approach:
SELECT c.customer_name, p.purchase_date, p.purchase_amount
FROM customers c
    JOIN purchases p ON c.customer_id = p.customer_id
WHERE
    p.purchase_date >= ALL (
        SELECT p1.purchase_date
        FROM purchases p1
        WHERE
            p1.customer_id = p.customer_id
    );
-- Meaning:
-- Return the purchase whose date is greater than or equal to all other purchase dates for that customer.

-- 8. PostgreSQL DISTINCT ON
-- Since you've been working with PostgreSQL, this is an important PostgreSQL-specific solution.
SELECT DISTINCT
    ON (p.customer_id) c.customer_name,
    p.purchase_date,
    p.purchase_amount
FROM customers c
    JOIN purchases p ON c.customer_id = p.customer_id
ORDER BY p.customer_id, p.purchase_date DESC;

This is very concise.
However, it returns one row per customer, not all rows tied on the latest date.
For deterministic selection:
SELECT DISTINCT ON (p.customer_id)
       c.customer_name,
       p.purchase_date,
       p.purchase_amount
FROM customers c
JOIN purchases p
  ON c.customer_id = p.customer_id
ORDER BY p.customer_id,
         p.purchase_date DESC,
         p.purchase_id DESC;
