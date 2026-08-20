-- Master Data

-- customers

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- categories

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- products

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

-- Transaction Data

-- orders

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

-- order_items

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- 2. Insert Master Data

-- Customers

INSERT INTO
    customers (customer_id, customer_name)
VALUES (1, 'Arun'),
    (2, 'Priya'),
    (3, 'Rahul'),
    (4, 'Sneha');

-- Categories

INSERT INTO
    categories (category_id, category_name)
VALUES (1, 'Electronics'),
    (2, 'Furniture');

-- Products

INSERT INTO
    products (
        product_id,
        product_name,
        category_id
    )
VALUES (101, 'Laptop', 1),
    (102, 'Phone', 1),
    (103, 'Mouse', 1),
    (201, 'Desk', 2),
    (202, 'Chair', 2),
    (203, 'Lamp', 2);

-- 3. Insert Orders

-- We'll create one order for every month of 2025.

INSERT INTO
    orders (
        order_id,
        customer_id,
        order_date
    )
VALUES (1001, 1, '2025-01-15'),
    (1002, 2, '2025-02-15'),
    (1003, 3, '2025-03-15'),
    (1004, 4, '2025-04-15'),
    (1005, 1, '2025-05-15'),
    (1006, 2, '2025-06-15'),
    (1007, 3, '2025-07-15'),
    (1008, 4, '2025-08-15'),
    (1009, 1, '2025-09-15'),
    (1010, 2, '2025-10-15'),
    (1011, 3, '2025-11-15'),
    (1012, 4, '2025-12-15');

-- 4. Insert Order Items

-- We'll use different quantities each month so that the revenue changes.

-- Prices:

-- Laptop = 1000
-- Phone = 500
-- Mouse = 50

-- Desk = 800
-- Chair = 400
-- Lamp = 100

-- January
INSERT INTO
    order_items (
        order_item_id,
        order_id,
        product_id,
        quantity,
        unit_price
    )
VALUES (1, 1001, 101, 10, 1000),
    (2, 1001, 102, 12, 500),
    (3, 1001, 103, 10, 50),
    (4, 1001, 201, 8, 800),
    (5, 1001, 202, 12, 400),
    (6, 1001, 203, 10, 100),
    (7, 1002, 101, 12, 1000),
    (8, 1002, 102, 14, 500),
    (9, 1002, 103, 12, 50),
    (10, 1002, 201, 10, 800),
    (11, 1002, 202, 14, 400),
    (12, 1002, 203, 12, 100),
    (13, 1003, 101, 14, 1000),
    (14, 1003, 102, 16, 500),
    (15, 1003, 103, 14, 50),
    (16, 1003, 201, 12, 800),
    (17, 1003, 202, 16, 400),
    (18, 1003, 203, 14, 100),
    (19, 1004, 101, 13, 1000),
    (20, 1004, 102, 15, 500),
    (21, 1004, 103, 11, 50),
    (22, 1004, 201, 11, 800),
    (23, 1004, 202, 15, 400),
    (24, 1004, 203, 11, 100),
    (25, 1005, 101, 16, 1000),
    (26, 1005, 102, 18, 500),
    (27, 1005, 103, 15, 50),
    (28, 1005, 201, 14, 800),
    (29, 1005, 202, 18, 400),
    (30, 1005, 203, 15, 100),
    (31, 1006, 101, 18, 1000),
    (32, 1006, 102, 20, 500),
    (33, 1006, 103, 18, 50),
    (34, 1006, 201, 16, 800),
    (35, 1006, 202, 20, 400),
    (36, 1006, 203, 18, 100),
    (37, 1007, 101, 15, 1000),
    (38, 1007, 102, 17, 500),
    (39, 1007, 103, 13, 50),
    (40, 1007, 201, 13, 800),
    (41, 1007, 202, 17, 400),
    (42, 1007, 203, 13, 100),
    (43, 1008, 101, 20, 1000),
    (44, 1008, 102, 22, 500),
    (45, 1008, 103, 20, 50),
    (46, 1008, 201, 18, 800),
    (47, 1008, 202, 22, 400),
    (48, 1008, 203, 20, 100),
    (49, 1009, 101, 17, 1000),
    (50, 1009, 102, 19, 500),
    (51, 1009, 103, 16, 50),
    (52, 1009, 201, 15, 800),
    (53, 1009, 202, 19, 400),
    (54, 1009, 203, 16, 100),
    (55, 1010, 101, 19, 1000),
    (56, 1010, 102, 21, 500),
    (57, 1010, 103, 19, 50),
    (58, 1010, 201, 17, 800),
    (59, 1010, 202, 21, 400),
    (60, 1010, 203, 19, 100),
    (61, 1011, 101, 22, 1000),
    (62, 1011, 102, 24, 500),
    (63, 1011, 103, 22, 50),
    (64, 1011, 201, 20, 800),
    (65, 1011, 202, 24, 400),
    (66, 1011, 203, 22, 100),
    (67, 1012, 101, 25, 1000),
    (68, 1012, 102, 27, 500),
    (69, 1012, 103, 25, 50),
    (70, 1012, 201, 23, 800),
    (71, 1012, 202, 27, 400),
    (72, 1012, 203, 25, 100);

-- 5. Step 1 — Get the Base Transaction Data

-- First don't think about ranking.

-- Start with:

SELECT o.order_id, o.order_date, oi.product_id, oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS revenue
FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
WHERE
    o.order_date >= '2025-01-01'
    AND o.order_date < '2026-01-01';

-- What does this layer answer?

-- How much revenue did each order-item generate?
-- Example:

-- order_id | order_date | product_id | quantity | unit_price | revenue
-- ---------|------------|------------|----------|------------|--------
-- 1001 | 2025-01-15 | 101 | 10 | 1000 | 10000
-- 1001 | 2025-01-15 | 102 | 12 | 500 | 6000

-- 6. Step 2 — Add Product Information

-- Now join products.

SELECT o.order_id, o.order_date, p.product_id, p.product_name, p.category_id, oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS revenue
FROM
    orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
WHERE
    o.order_date >= '2025-01-01'
    AND o.order_date < '2026-01-01';

-- Now we know:

-- product_id
-- product_name
-- category_id
-- quantity
-- unit_price
-- revenue

-- 7. Step 3 — Add Category

-- Now join categories.

SELECT o.order_date, p.product_id, p.product_name, c.category_id, c.category_name, oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS revenue
FROM
    orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
WHERE
    o.order_date >= '2025-01-01'
    AND o.order_date < '2026-01-01';

-- Now our data contains:

-- category
-- ↓
-- product
-- ↓
-- month
-- ↓
-- revenue

-- This corresponds to the source's table path:

-- orders
-- ↓
-- order_items
-- ↓
-- products
-- ↓
-- categories

-- 8. Step 4 — Calculate Monthly Product Revenue

-- Now we solve the first major business question:

-- What is the revenue for each product in each month?
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start,
    c.category_id,
    c.category_name,
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM
    orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
WHERE
    o.order_date >= '2025-01-01'
    AND o.order_date < '2026-01-01'
GROUP BY
    DATE_FORMAT(o.order_date, '%Y-%m-01'),
    c.category_id,
    c.category_name,
    p.product_id,
    p.product_name;

-- Grain now

-- 1 row = 1 product + 1 category + 1 month

-- This is exactly the grain identified in the source.

-- 9. Step 5 — Calculate Category Average

-- Now

-- What is the average product revenue within each category and month?
-- Use:

-- AVG(revenue) OVER (
-- PARTITION BY category_id, month_start
-- )

-- The source specifically identifies this pattern for comparing each product against its category/month average.

-- Complete query:

SELECT x.*, AVG(revenue) OVER (
        PARTITION BY
            category_id, month_start
    ) AS category_avg_revenue
FROM (
        SELECT
            DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start, c.category_id, c.category_name, p.product_id, p.product_name, SUM(oi.quantity * oi.unit_price) AS revenue
        FROM
            orders o
            JOIN order_items oi ON o.order_id = oi.order_id
            JOIN products p ON oi.product_id = p.product_id
            JOIN categories c ON p.category_id = c.category_id
        WHERE
            o.order_date >= '2025-01-01'
            AND o.order_date < '2026-01-01'
        GROUP BY
            DATE_FORMAT(o.order_date, '%Y-%m-01'), c.category_id, c.category_name, p.product_id, p.product_name
    ) x;

-- Now we have:

-- month
-- category
-- product
-- revenue
-- category_avg_revenue

-- 10. Step 6 — Rank Products

-- Now solve:

-- Which product is number 1, number 2, number 3, etc. within each category/month?
-- Use:

-- ROW_NUMBER() OVER (
-- PARTITION BY category_id, month_start
-- ORDER BY revenue DESC
-- )

-- The source explains that "top N within each group" is a window-function problem and that the partition causes ranking to restart for each category/month.

SELECT x.*, ROW_NUMBER() OVER (
        PARTITION BY
            category_id, month_start
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM (
        SELECT y.*, AVG(revenue) OVER (
                PARTITION BY
                    category_id, month_start
            ) AS category_avg_revenue
        FROM (
                SELECT
                    DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start, c.category_id, c.category_name, p.product_id, p.product_name, SUM(oi.quantity * oi.unit_price) AS revenue
                FROM
                    orders o
                    JOIN order_items oi ON o.order_id = oi.order_id
                    JOIN products p ON oi.product_id = p.product_id
                    JOIN categories c ON p.category_id = c.category_id
                WHERE
                    o.order_date >= '2025-01-01'
                    AND o.order_date < '2026-01-01'
                GROUP BY
                    DATE_FORMAT(o.order_date, '%Y-%m-01'), c.category_id, c.category_name, p.product_id, p.product_name
            ) y
    ) x;

-- 11. Step 7 — Calculate Previous Month Revenue

-- Now we solve a completely different question:

-- What was this product's revenue in the previous row/month?
-- Use:

-- LAG(revenue) OVER (
-- PARTITION BY product_id
-- ORDER BY month_start
-- )

-- The source explicitly recommends LAG() for previous-month revenue.

SELECT x.*, LAG(revenue) OVER (
        PARTITION BY
            product_id
        ORDER BY month_start
    ) AS previous_month_revenue
FROM (
        SELECT y.*, ROW_NUMBER() OVER (
                PARTITION BY
                    category_id, month_start
                ORDER BY revenue DESC
            ) AS revenue_rank
        FROM (
                SELECT x.*, AVG(revenue) OVER (
                        PARTITION BY
                            category_id, month_start
                    ) AS category_avg_revenue
                FROM (
                        SELECT
                            DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start, c.category_id, c.category_name, p.product_id, p.product_name, SUM(oi.quantity * oi.unit_price) AS revenue
                        FROM
                            orders o
                            JOIN order_items oi ON o.order_id = oi.order_id
                            JOIN products p ON oi.product_id = p.product_id
                            JOIN categories c ON p.category_id = c.category_id
                        WHERE
                            o.order_date >= '2025-01-01'
                            AND o.order_date < '2026-01-01'
                        GROUP BY
                            DATE_FORMAT(o.order_date, '%Y-%m-01'), c.category_id, c.category_name, p.product_id, p.product_name
                    ) x
            ) y
    ) x;

-- 12. Step 8 — Calculate Percentage Change

-- Business formula:

-- (current revenue - previous revenue)
-- ------------------------------------- × 100
-- previous revenue

-- Therefore:

-- (
-- revenue - previous_month_revenue
-- )
-- /
-- previous_month_revenue
-- * 100

-- The source explicitly separates the business formula from the SQL implementation.

-- 13. Step 9 — Apply the Final Filters

-- We now have:

-- revenue_rank
-- category_avg_revenue
-- previous_month_revenue
-- percentage_change

-- The final conditions are:

-- revenue_rank <= 2

-- and

-- revenue > category_avg_revenue

-- This is the final filtering layer described in the source.

-- 14. Final Query — No CTE Version

-- Since you have been working on teaching SQL without CTEs, here is the complete derived-table version:

SELECT z.month_start, z.category_name, z.product_name, z.revenue, z.previous_month_revenue, ROUND(
        (
            z.revenue - z.previous_month_revenue
        ) / z.previous_month_revenue * 100, 2
    ) AS percentage_change
FROM (
        /* Layer 3: Previous month revenue */
        SELECT y.*, LAG(y.revenue) OVER (
                PARTITION BY
                    y.product_id
                ORDER BY y.month_start
            ) AS previous_month_revenue
        FROM (
                /* Layer 2: Rank products */
                SELECT x.*, ROW_NUMBER() OVER (
                        PARTITION BY
                            x.category_id, x.month_start
                        ORDER BY x.revenue DESC
                    ) AS revenue_rank
                FROM (
                        /* Layer 1: Monthly product revenue + category average */
                        SELECT m.*, AVG(m.revenue) OVER (
                                PARTITION BY
                                    m.category_id, m.month_start
                            ) AS category_avg_revenue
                        FROM (
                                /* Base monthly revenue */
                                SELECT
                                    DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start, c.category_id, c.category_name, p.product_id, p.product_name, SUM(oi.quantity * oi.unit_price) AS revenue
                                FROM
                                    orders o
                                    JOIN order_items oi ON o.order_id = oi.order_id
                                    JOIN products p ON oi.product_id = p.product_id
                                    JOIN categories c ON p.category_id = c.category_id
                                WHERE
                                    o.order_date >= '2025-01-01'
                                    AND o.order_date < '2026-01-01'
                                GROUP BY
                                    DATE_FORMAT(o.order_date, '%Y-%m-01'), c.category_id, c.category_name, p.product_id, p.product_name
                            ) m
                    ) x
            ) y
    ) z
WHERE
    z.revenue_rank <= 2
    AND z.revenue > z.category_avg_revenue
    AND (
        z.previous_month_revenue IS NULL
        OR z.previous_month_revenue <> 0
    )
ORDER BY z.month_start, z.category_name, z.revenue_rank;

-- 15. One Important Teaching Point

-- There is a subtle reason we do not immediately filter revenue_rank <= 2 before calculating LAG().

-- Suppose:

-- January

-- Laptop 10,000
-- Phone 6,000
-- Mouse 500

-- and:

-- February

-- Laptop 12,000
-- Phone 7,000
-- Mouse 600

-- If we remove Mouse before calculating LAG(), it may not matter here, but in a more realistic dataset where a product's rank changes, filtering too early can change the rows available to later calculations.

-- So the safer teaching pattern is:

-- Monthly Revenue
-- ↓
-- Category Average
-- ↓
-- Rank
-- ↓
-- LAG
-- ↓
-- Percentage Change
-- ↓
-- Final Filter

-- This follows the layered approach in the source.

-- 16. The Complete SQL Problem as Layers

-- For your trainees, I would teach the query exactly like this:

-- LAYER 1
-- Get orders from 2025
-- ↓
-- LAYER 2
-- JOIN order_items
-- ↓
-- LAYER 3
-- JOIN products
-- ↓
-- LAYER 4
-- JOIN categories
-- ↓
-- LAYER 5
-- Calculate:
-- SUM(quantity * unit_price)
-- ↓
-- LAYER 6
-- Group by:
-- month + category + product
-- ↓
-- LAYER 7
-- Calculate:
-- AVG(revenue) OVER
-- (PARTITION BY category, month)
-- ↓
-- LAYER 8
-- Calculate:
-- ROW_NUMBER() OVER
-- (PARTITION BY category, month
-- ORDER BY revenue DESC)
-- ↓
-- LAYER 9
-- Calculate:
-- LAG(revenue)
-- PARTITION BY product
-- ORDER BY month
-- ↓
-- LAYER 10
-- Calculate:
-- percentage change
-- ↓
-- LAYER 11
-- Filter:
-- rank <= 2
-- ↓
-- LAYER 12
-- Filter:
-- revenue > category average
-- ↓
-- FINAL RESULT

-- This directly reflects the source's recommended sequence: business problem → grain → tables → joins → aggregates → windows → filters → final output.

-- The key teaching formula

-- Requirement
-- ↓
-- Question
-- ↓
-- Intermediate Result
-- ↓
-- SQL Operation
-- ↓
-- Next Layer

-- For this particular problem:

-- Requirement	Question	SQL
-- 2025	Which orders?	WHERE
-- Revenue	What is revenue?	SUM(quantity * unit_price)
-- Per month	What month?	DATE_FORMAT()
-- Per product	What is the grain?	GROUP BY product
-- Per category	Which group?	GROUP BY category
-- Category average	What is group's average?	AVG() OVER()
-- Top 2	Who ranks highest?	ROW_NUMBER()
-- Previous month	What came before?	LAG()
-- % change	How much did it change?	Arithmetic
-- Only qualifying rows	Which rows survive?	Outer WHERE
-- This is the strongest way to teach the problem because trainees learn why each SQL construct exists, rather than memorizing one large query.
