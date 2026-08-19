-- ============================================================
-- SMARTMART SQL
-- SUBQUERIES, JOINS, NESTED QUERIES AND FILTERING
-- ============================================================

-- 1. SUBQUERIES

-- A. SINGLE-ROW SUBQUERIES

-- 1. Products above average price
-- Find products whose price is greater than the average product price.

SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- 2. Most expensive product

SELECT product_name, price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- 3. Cheapest product

SELECT product_name, price
FROM products
WHERE price = (
    SELECT MIN(price)
    FROM products
);

-- 4. Orders greater than average order amount

SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);

-- 5. Products with price greater than Laptop

SELECT product_name, price
FROM products
WHERE price > (
    SELECT price
    FROM products
    WHERE product_name = 'Laptop'
);


-- ============================================================
-- B. MULTI-ROW SUBQUERIES
-- ============================================================

-- 6. Customers who placed orders

SELECT
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

-- 7. Customers who never placed an order

SELECT
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- 8. Products that have been ordered

SELECT product_id, product_name
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM order_items
);

-- 9. Products that have never been ordered

SELECT product_id, product_name
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM order_items
);

-- 10. Customers who placed a DELIVERED order

SELECT
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_status = 'DELIVERED'
);


-- ============================================================
-- C. CORRELATED SUBQUERIES
-- ============================================================

-- 11. Products more expensive than their category average

SELECT
    p.product_name,
    p.category_id,
    p.price
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);

-- 12. Customers whose order is greater than their own average order

SELECT
    o.order_id,
    o.customer_id,
    o.total_amount
FROM orders o
WHERE o.total_amount > (
    SELECT AVG(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- 13. Most expensive product in each category

SELECT
    p.product_name,
    p.category_id,
    p.price
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);


-- ============================================================
-- 2. COMPLEX JOINS
-- ============================================================

-- Move from one table to multiple related tables.

-- A. TWO-TABLE JOINS

-- 14. Customer and orders

SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;

-- 15. Products and categories

SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

-- 16. Orders and payments

SELECT
    o.order_id,
    o.total_amount,
    p.payment_method,
    p.amount,
    p.payment_status
FROM orders o
INNER JOIN payments p
    ON o.order_id = p.order_id;


-- ============================================================
-- B. THREE-TABLE JOINS
-- ============================================================

-- 17. Customer → Orders → Payments

SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount,
    p.payment_method,
    p.payment_status
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id;

-- 18. Orders → Order Items → Products

SELECT
    o.order_id,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;

-- 19. Products → Categories → Inventory

SELECT
    p.product_name,
    c.category_name,
    i.warehouse_name,
    i.quantity
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
JOIN inventory i
    ON p.product_id = i.product_id;


-- ============================================================
-- C. FOUR/FIVE-TABLE JOINS
-- ============================================================

-- 20. Customer order details
-- The following original query is INVALID because alias "c"
-- is used for both customers and categories.

-- SELECT
--     c.first_name,
--     c.last_name,
--     o.order_id,
--     p.product_name,
--     oi.quantity,
--     oi.unit_price,
--     c.category_name
-- FROM customers c
-- JOIN orders o
--     ON c.customer_id = o.customer_id
-- JOIN order_items oi
--     ON o.order_id = oi.order_id
-- JOIN products p
--     ON oi.product_id = p.product_id
-- JOIN categories c
--     ON p.category_id = c.category_id;

-- Correct version

SELECT
    cu.first_name,
    cu.last_name,
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    ca.category_name
FROM customers cu
JOIN orders o
    ON cu.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories ca
    ON p.category_id = ca.category_id;


-- ============================================================
-- 3. SUBQUERIES + JOINS INTEGRATED
-- ============================================================

-- This section combines joins and subqueries.

-- 21. Customers who spent more than average

SELECT
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
);

-- 22. Products whose price is above category average
-- Using a join plus correlated subquery

SELECT
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);

-- 23. Customers who purchased Electronics

SELECT DISTINCT
    c.first_name,
    c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id IN (
    SELECT p.product_id
    FROM products p
    JOIN categories ca
        ON p.category_id = ca.category_id
    WHERE ca.category_name = 'Electronics'
);

-- 24. Customers who purchased Computers

SELECT DISTINCT
    c.first_name,
    c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id IN (
    SELECT p.product_id
    FROM products p
    JOIN categories ca
        ON p.category_id = ca.category_id
    WHERE ca.category_name = 'Computers'
);

-- 25. Customers who purchased the Laptop

SELECT DISTINCT
    c.first_name,
    c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id = (
    SELECT product_id
    FROM products
    WHERE product_name = 'Laptop'
);

-- 26. Orders containing products above average price

SELECT DISTINCT
    o.order_id,
    o.customer_id,
    o.total_amount
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.price > (
    SELECT AVG(price)
    FROM products
);

-- 27. Customers whose order amount is greater than average

SELECT DISTINCT
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);


-- ============================================================
-- 4. NESTED QUERIES AND SUBQUERIES
-- ============================================================

-- Here we use subquery inside subquery.

-- 28. Customers who purchased products from the most expensive category

SELECT DISTINCT
    c.first_name,
    c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id IN (
    SELECT product_id
    FROM products
    WHERE category_id = (
        SELECT category_id
        FROM categories
        WHERE category_id = (
            SELECT category_id
            FROM products
            WHERE price = (
                SELECT MAX(price)
                FROM products
            )
        )
    )
);

-- Query structure:
-- Outer Query
--     |
--     +-- Subquery
--           |
--           +-- Subquery
--                 |
--                 +-- Subquery
--                       |
--                       +-- MAX(price)

-- 29. Customers who purchased the most expensive product

SELECT DISTINCT
    c.first_name,
    c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id = (
    SELECT product_id
    FROM products
    WHERE price = (
        SELECT MAX(price)
        FROM products
    )
);

-- 30. Orders containing the cheapest product

SELECT DISTINCT
    o.order_id,
    o.customer_id,
    o.order_date
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id = (
    SELECT product_id
    FROM products
    WHERE price = (
        SELECT MIN(price)
        FROM products
    )
);

-- 31. Customer who placed the highest-value order

SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount = (
    SELECT MAX(total_amount)
    FROM orders
);


-- ============================================================
-- 5. FILTERING DATA
-- ============================================================

-- Combine WHERE, IN, NOT IN, EXISTS, NOT EXISTS,
-- BETWEEN, AND, OR, and joins.

-- 32. Active customers with orders

SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE c.customer_status = 'ACTIVE';

-- 33. Customers with orders above ₹50,000

SELECT DISTINCT
    c.first_name,
    c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > 50000;

-- 34. Delivered orders above ₹50,000

SELECT *
FROM orders
WHERE order_status = 'DELIVERED'
  AND total_amount > 50000;

-- 35. Products between ₹2,000 and ₹20,000

SELECT
    product_name,
    price
FROM products
WHERE price BETWEEN 2000 AND 20000;

-- 36. Electronics products above ₹5,000

SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics'
  AND p.price > 5000;


-- ============================================================
-- 6. EXISTS / NOT EXISTS
-- ============================================================

-- These are important interview combinations.

-- 37. Customers who have placed at least one order

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 38. Customers who have never placed an order

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 39. Products that have been ordered

SELECT
    p.product_id,
    p.product_name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);

-- 40. Products never ordered

SELECT
    p.product_id,
    p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);


-- ============================================================
-- 7. ADVANCED JOIN + SUBQUERY COMBINATIONS
-- ============================================================

-- These are excellent for interview preparation.

-- 41. Customer's total spending greater than
-- average customer spending

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            customer_id,
            SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) x
);

-- This contains:
-- Derived table
-- Aggregation
-- JOIN
-- GROUP BY
-- HAVING
-- Subquery

-- 42. Category whose average product price is highest

SELECT
    c.category_name,
    AVG(p.price) AS avg_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY
    c.category_id,
    c.category_name
HAVING AVG(p.price) = (
    SELECT MAX(avg_price)
    FROM (
        SELECT
            category_id,
            AVG(price) AS avg_price
        FROM products
        GROUP BY category_id
    ) x
);

-- 43. Customers who purchased more than one different product

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT oi.product_id) AS product_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT oi.product_id) > 1;

-- 44. Products whose total ordered quantity
-- is greater than average ordered quantity

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING SUM(oi.quantity) > (
    SELECT AVG(total_quantity)
    FROM (
        SELECT
            product_id,
            SUM(quantity) AS total_quantity
        FROM order_items
        GROUP BY product_id
    ) x
);

-- 45. Customers with successful payments greater than ₹50,000

SELECT DISTINCT
    c.first_name,
    c.last_name,
    p.amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'SUCCESS'
  AND p.amount > 50000;


-- ============================================================
-- 8. LEFT JOIN + SUBQUERY
-- ============================================================

-- 46. Customers with no orders

-- Using LEFT JOIN

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Equivalent using a subquery

SELECT
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- Useful comparison:
-- LEFT JOIN + IS NULL
-- VS
-- NOT IN subquery
-- VS
-- NOT EXISTS


-- ============================================================
-- 9. COMPLETE COMBINATION MATRIX
-- ============================================================

-- 1. Single table + filter             -> WHERE
-- 2. Single table + aggregate          -> GROUP BY
-- 3. Aggregate + filter                -> HAVING
-- 4. Subquery + WHERE                  -> Scalar subquery
-- 5. Subquery + IN                     -> Multi-row subquery
-- 6. Subquery + NOT IN                 -> Exclusion
-- 7. Correlated subquery               -> Outer/inner reference
-- 8. INNER JOIN                         -> Basic join
-- 9. LEFT JOIN                          -> Outer join
-- 10. Multiple INNER JOINs              -> Complex joins
-- 11. JOIN + WHERE                      -> Filtering joined data
-- 12. JOIN + GROUP BY                   -> Aggregation
-- 13. JOIN + HAVING                     -> Aggregate filtering
-- 14. JOIN + subquery                   -> Integrated query
-- 15. JOIN + IN subquery                -> Multi-table filtering
-- 16. JOIN + correlated subquery        -> Advanced filtering
-- 17. JOIN + EXISTS                     -> Existence
-- 18. JOIN + NOT EXISTS                 -> Non-existence
-- 19. Nested subquery                   -> Subquery inside subquery
-- 20. Nested subquery + JOIN            -> Advanced query
-- 21. JOIN + derived table              -> Inline view
-- 22. Derived table + GROUP BY          -> Advanced aggregation
-- 23. Derived table + HAVING            -> Compare aggregates
-- 24. Multiple subqueries               -> Complex business logic
-- 25. JOIN + multiple subqueries        -> Interview-level
-- 26. JOIN + subquery + GROUP BY        -> Advanced analytics
-- 27. JOIN + subquery + HAVING          -> Advanced analytics
-- 28. LEFT JOIN + IS NULL               -> Missing records
-- 29. NOT EXISTS + correlated query     -> Advanced exclusion
-- 30. JOIN + EXISTS + aggregation       -> Expert-level


-- ============================================================
-- 10. RECOMMENDED SMARTMART SQL LEARNING PATH
-- ============================================================

-- SMARTMART SQL
--
-- 01. Filtering
--     ├── WHERE
--     ├── AND / OR
--     ├── BETWEEN
--     ├── IN
--     └── NOT IN
--
-- 02. Aggregation
--     ├── COUNT
--     ├── SUM
--     ├── AVG
--     ├── MIN
--     ├── MAX
--     ├── GROUP BY
--     └── HAVING
--
-- 03. Basic Joins
--     ├── INNER JOIN
--     ├── LEFT JOIN
--     └── Multiple JOINs
--
-- 04. Subqueries
--     ├── Scalar
--     ├── Multi-row
--     ├── IN
--     ├── NOT IN
--     ├── EXISTS
--     ├── NOT EXISTS
--     └── Correlated
--
-- 05. JOIN + Subquery
--     ├── JOIN + WHERE + Subquery
--     ├── JOIN + IN
--     ├── JOIN + EXISTS
--     ├── JOIN + Correlated Subquery
--     └── JOIN + Multiple Subqueries
--
-- 06. Nested Queries
--     ├── Subquery inside Subquery
--     ├── Nested IN
--     ├── Nested Aggregate
--     └── Nested JOIN + Subquery
--
-- 07. Advanced Queries
--     ├── Derived Tables
--     ├── JOIN + Derived Table
--     ├── GROUP BY + Subquery
--     ├── HAVING + Subquery
--     └── Multiple Levels of Nesting
--
-- 08. Interview Problems
--     ├── Highest / Lowest
--     ├── Above Average
--     ├── Never Purchased
--     ├── Most Valuable Customer
--     ├── Best-Selling Product
--     ├── Best Category
--     └── Customer / Product Analysis


-- ============================================================
-- END OF SMARTMART SQL PRACTICE
-- ============================================================    FROM orders
);

5. Products with price greater than Laptop

SELECT product_name, price
FROM products
WHERE price > (
    SELECT price
    FROM products
    WHERE product_name = 'Laptop'
);
B. Multi-row subqueries

6. Customers who placed orders

SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

7. Customers who never placed an order

SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

8. Products that have been ordered

SELECT product_id, product_name
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM order_items
);

9. Products that have never been ordered

SELECT product_id, product_name
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM order_items
);

10. Customers who placed a DELIVERED order

SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_status = 'DELIVERED'
);
C. Correlated subqueries

11. Products more expensive than their category average

SELECT p.product_name,
       p.category_id,
       p.price
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);

12. Customers whose order is greater than their own average order

SELECT o.order_id,
       o.customer_id,
       o.total_amount
FROM orders o
WHERE o.total_amount > (
    SELECT AVG(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

13. Most expensive product in each category

SELECT p.product_name,
       p.category_id,
       p.price
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);
2. Complex Joins

Now move from one table to multiple related tables.

A. Two-table joins

14. Customer and orders

SELECT c.first_name,
       c.last_name,
       o.order_id,
       o.order_date,
       o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;

15. Products and categories

SELECT p.product_name,
       p.price,
       c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

16. Orders and payments

SELECT o.order_id,
       o.total_amount,
       p.payment_method,
       p.amount,
       p.payment_status
FROM orders o
INNER JOIN payments p
    ON o.order_id = p.order_id;
B. Three-table joins

17. Customer → Orders → Payments

SELECT c.first_name,
       c.last_name,
       o.order_id,
       o.total_amount,
       p.payment_method,
       p.payment_status
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id;

18. Orders → Order Items → Products

SELECT o.order_id,
       o.order_date,
       p.product_name,
       oi.quantity,
       oi.unit_price,
       oi.discount
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;

19. Products → Categories → Inventory

SELECT p.product_name,
       c.category_name,
       i.warehouse_name,
       i.quantity
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
JOIN inventory i
    ON p.product_id = i.product_id;
C. Four/five-table joins

20. Customer order details

SELECT c.first_name,
       c.last_name,
       o.order_id,
       p.product_name,
       oi.quantity,
       oi.unit_price,
       c.category_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id;

The above has an alias conflict, so the correct version is:

SELECT cu.first_name,
       cu.last_name,
       o.order_id,
       p.product_name,
       oi.quantity,
       oi.unit_price,
       ca.category_name
FROM customers cu
JOIN orders o
    ON cu.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories ca
    ON p.category_id = ca.category_id;
3. Subqueries + Joins Integrated

This is where the exercises become much more useful for interviews.

21. Customers who spent more than average
SELECT c.first_name,
       c.last_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
);
22. Products whose price is above category average

Using a join plus correlated subquery:

SELECT p.product_name,
       c.category_name,
       p.price
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);
23. Customers who purchased Electronics
SELECT DISTINCT
       c.first_name,
       c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id IN (
    SELECT p.product_id
    FROM products p
    JOIN categories ca
        ON p.category_id = ca.category_id
    WHERE ca.category_name = 'Electronics'
);
24. Customers who purchased Computers
SELECT DISTINCT
       c.first_name,
       c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id IN (
    SELECT p.product_id
    FROM products p
    JOIN categories ca
        ON p.category_id = ca.category_id
    WHERE ca.category_name = 'Computers'
);
25. Customers who purchased the Laptop
SELECT DISTINCT
       c.first_name,
       c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id = (
    SELECT product_id
    FROM products
    WHERE product_name = 'Laptop'
);
26. Orders containing products above average price
SELECT DISTINCT
       o.order_id,
       o.customer_id,
       o.total_amount
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.price > (
    SELECT AVG(price)
    FROM products
);
27. Customers whose order amount is greater than average
SELECT DISTINCT
       c.first_name,
       c.last_name,
       o.order_id,
       o.total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);
4. Nested Queries and Subqueries

Here we use subquery inside subquery.

28. Customers who purchased products from the most expensive category
SELECT DISTINCT
       c.first_name,
       c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id IN (
    SELECT product_id
    FROM products
    WHERE category_id = (
        SELECT category_id
        FROM categories
        WHERE category_id = (
            SELECT category_id
            FROM products
            WHERE price = (
                SELECT MAX(price)
                FROM products
            )
        )
    )
);

This demonstrates:

Outer Query
    |
    +-- Subquery
          |
          +-- Subquery
                |
                +-- Subquery
29. Customers who purchased the most expensive product
SELECT DISTINCT
       c.first_name,
       c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id = (
    SELECT product_id
    FROM products
    WHERE price = (
        SELECT MAX(price)
        FROM products
    )
);
30. Orders containing the cheapest product
SELECT DISTINCT
       o.order_id,
       o.customer_id,
       o.order_date
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.product_id = (
    SELECT product_id
    FROM products
    WHERE price = (
        SELECT MIN(price)
        FROM products
    )
);
31. Customer who placed the highest-value order
SELECT c.first_name,
       c.last_name,
       o.order_id,
       o.total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount = (
    SELECT MAX(total_amount)
    FROM orders
);
5. Filtering Data

Now combine WHERE, IN, NOT IN, EXISTS, NOT EXISTS, BETWEEN, AND, OR, and joins.

32. Active customers with orders
SELECT DISTINCT
       c.customer_id,
       c.first_name,
       c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE c.customer_status = 'ACTIVE';
33. Customers with orders above ₹50,000
SELECT DISTINCT
       c.first_name,
       c.last_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > 50000;
34. Delivered orders above ₹50,000
SELECT *
FROM orders
WHERE order_status = 'DELIVERED'
  AND total_amount > 50000;
35. Products between ₹2,000 and ₹20,000
SELECT product_name,
       price
FROM products
WHERE price BETWEEN 2000 AND 20000;
36. Electronics products above ₹5,000
SELECT p.product_name,
       p.price,
       c.category_name
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics'
  AND p.price > 5000;
6. EXISTS / NOT EXISTS

These are especially important interview combinations.

37. Customers who have placed at least one order
SELECT c.customer_id,
       c.first_name,
       c.last_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
38. Customers who have never placed an order
SELECT c.customer_id,
       c.first_name,
       c.last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
39. Products that have been ordered
SELECT p.product_id,
       p.product_name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);
40. Products never ordered
SELECT p.product_id,
       p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);
7. Advanced Join + Subquery Combinations

These are excellent for interview preparation.

41. Customer's total spending greater than average customer spending
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT customer_id,
               SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) x
);

This contains a derived table + aggregation + join + HAVING.

42. Category whose average product price is highest
SELECT c.category_name,
       AVG(p.price) AS avg_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id,
         c.category_name
HAVING AVG(p.price) = (
    SELECT MAX(avg_price)
    FROM (
        SELECT category_id,
               AVG(price) AS avg_price
        FROM products
        GROUP BY category_id
    ) x
);
43. Customers who purchased more than one different product
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(DISTINCT oi.product_id) AS product_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
HAVING COUNT(DISTINCT oi.product_id) > 1;
44. Products whose total ordered quantity is greater than average ordered quantity
SELECT p.product_id,
       p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id,
         p.product_name
HAVING SUM(oi.quantity) > (
    SELECT AVG(total_quantity)
    FROM (
        SELECT product_id,
               SUM(quantity) AS total_quantity
        FROM order_items
        GROUP BY product_id
    ) x
);
45. Customers with successful payments greater than ₹50,000
SELECT DISTINCT
       c.first_name,
       c.last_name,
       p.amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'SUCCESS'
  AND p.amount > 50000;
8. LEFT JOIN + Subquery
46. Customers with no orders
SELECT c.customer_id,
       c.first_name,
       c.last_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

Equivalent using a subquery:

SELECT customer_id,
       first_name,
       last_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

This is a useful exercise for understanding:

LEFT JOIN + IS NULL
        VS
NOT IN subquery
        VS
NOT EXISTS
9. Complete Combination Matrix

For your SmartMart SQL training, I would cover the combinations in this order:

#	Combination	Main SQL Concepts
1	Single table + filter	WHERE
2	Single table + aggregate	GROUP BY
3	Aggregate + filter	HAVING
4	Subquery + WHERE	Scalar subquery
5	Subquery + IN	Multi-row subquery
6	Subquery + NOT IN	Exclusion
7	Correlated subquery	Outer/inner reference
8	INNER JOIN	Basic join
9	LEFT JOIN	Outer join
10	Multiple INNER JOINs	Complex joins
11	JOIN + WHERE	Filtering joined data
12	JOIN + GROUP BY	Aggregation
13	JOIN + HAVING	Aggregate filtering
14	JOIN + subquery	Integrated query
15	JOIN + IN subquery	Multi-table filtering
16	JOIN + correlated subquery	Advanced filtering
17	JOIN + EXISTS	Existence
18	JOIN + NOT EXISTS	Non-existence
19	Nested subquery	Subquery inside subquery
20	Nested subquery + JOIN	Advanced query
21	JOIN + derived table	Inline view
22	Derived table + GROUP BY	Advanced aggregation
23	Derived table + HAVING	Compare aggregates
24	Multiple subqueries	Complex business logic
25	JOIN + multiple subqueries	Interview-level
26	JOIN + subquery + GROUP BY	Advanced analytics
27	JOIN + subquery + HAVING	Advanced analytics
28	LEFT JOIN + IS NULL	Missing records
29	NOT EXISTS + correlated query	Advanced exclusion
30	JOIN + EXISTS + aggregation	Expert-level
10. Recommended SmartMart Learning Path

For your application, I would structure the SQL exercises like this:

SMARTMART SQL
│
├── 01. Filtering
│   ├── WHERE
│   ├── AND / OR
│   ├── BETWEEN
│   ├── IN
│   └── NOT IN
│
├── 02. Aggregation
│   ├── COUNT
│   ├── SUM
│   ├── AVG
│   ├── MIN
│   ├── MAX
│   ├── GROUP BY
│   └── HAVING
│
├── 03. Basic Joins
│   ├── INNER JOIN
│   ├── LEFT JOIN
│   └── Multiple JOINs
│
├── 04. Subqueries
│   ├── Scalar
│   ├── Multi-row
│   ├── IN
│   ├── NOT IN
│   ├── EXISTS
│   ├── NOT EXISTS
│   └── Correlated
│
├── 05. Join + Subquery
│   ├── JOIN + WHERE + Subquery
│   ├── JOIN + IN
│   ├── JOIN + EXISTS
│   ├── JOIN + Correlated Subquery
│   └── JOIN + Multiple Subqueries
│
├── 06. Nested Queries
│   ├── Subquery inside Subquery
│   ├── Nested IN
│   ├── Nested Aggregate
│   └── Nested JOIN + Subquery
│
├── 07. Advanced Queries
│   ├── Derived Tables
│   ├── JOIN + Derived Table
│   ├── GROUP BY + Subquery
│   ├── HAVING + Subquery
│   └── Multiple Levels of Nesting
│
└── 08. Interview Problems
    ├── Highest / Lowest
    ├── Above Average
    ├── Never Purchased
    ├── Most Valuable Customer
    ├── Best-Selling Product
    ├── Best Category
    └── Customer/Product Analysis

The SmartMart schema is particularly suitable for this because orders connects customers to order items, order items connect products, and products connect categories, while payments and inventory provide additional branches for more complex joins.

Best next step: turn this into a 50–100 question SmartMart SQL assignment, with questions first and solutions separately, progressing from beginner → intermediate → advanced → interview-level.
