1. Single-row subqueries
1. Products more expensive than the average product price
SELECT product_id, product_name, price
FROM products
WHERE price > (
   SELECT AVG(price)
   FROM products
);
2. Products cheaper than the average price
SELECT product_id, product_name, price
FROM products
WHERE price < (
   SELECT AVG(price)
   FROM products
);
3. Product with the highest price
SELECT product_id, product_name, price
FROM products
WHERE price = (
   SELECT MAX(price)
   FROM products
);
4. Product with the lowest price
SELECT product_id, product_name, price
FROM products
WHERE price = (
   SELECT MIN(price)
   FROM products
);
5. Customers who placed an order for the maximum order amount
SELECT customer_id, name
FROM customers
WHERE customer_id IN (
   SELECT customer_id
   FROM orders
   WHERE total_amount = (
       SELECT MAX(total_amount)
       FROM orders
   )
);

2. Subquery with IN
6. Customers who placed orders
SELECT customer_id, name
FROM customers
WHERE customer_id IN (
   SELECT customer_id
   FROM orders
);
7. Customers who never placed an order
SELECT customer_id, name
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
10. Customers who ordered products costing more than 5000
SELECT customer_id, name
FROM customers
WHERE customer_id IN (
   SELECT o.customer_id
   FROM orders o
   WHERE o.order_id IN (
       SELECT oi.order_id
       FROM order_items oi
       WHERE oi.product_id IN (
           SELECT product_id
           FROM products
           WHERE price > 5000
       )
   )
);

3. Subquery with EXISTS
11. Customers who have placed at least one order
SELECT c.customer_id, c.name
FROM customers c
WHERE EXISTS (
   SELECT 1
   FROM orders o
   WHERE o.customer_id = c.customer_id
);
12. Customers who have never placed an order
SELECT c.customer_id, c.name
FROM customers c
WHERE NOT EXISTS (
   SELECT 1
   FROM orders o
   WHERE o.customer_id = c.customer_id
);
13. Products that have been ordered
SELECT p.product_id, p.product_name
FROM products p
WHERE EXISTS (
   SELECT 1
   FROM order_items oi
   WHERE oi.product_id = p.product_id
);
14. Products that have never been ordered
SELECT p.product_id, p.product_name
FROM products p
WHERE NOT EXISTS (
   SELECT 1
   FROM order_items oi
   WHERE oi.product_id = p.product_id
);

4. Subquery + Aggregate Functions
15. Products above average price
SELECT product_name, price
FROM products
WHERE price > (
   SELECT AVG(price)
   FROM products
);
16. Customers whose order amount is above average
SELECT customer_id, total_amount
FROM orders
WHERE total_amount > (
   SELECT AVG(total_amount)
   FROM orders
);
17. Orders below average order amount
SELECT order_id, customer_id, total_amount
FROM orders
WHERE total_amount < (
   SELECT AVG(total_amount)
   FROM orders
);
18. Products having the maximum price in their table
SELECT product_name, price
FROM products
WHERE price = (
   SELECT MAX(price)
   FROM products
);

5. Subquery + GROUP BY
19. Customers whose total purchases exceed 10,000
SELECT customer_id, SUM(total_amount) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 10000;
Now compare each customer's total with the average customer spending:
SELECT customer_id, SUM(total_amount) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > (
   SELECT AVG(customer_total)
   FROM (
       SELECT customer_id,
              SUM(total_amount) AS customer_total
       FROM orders
       GROUP BY customer_id
   ) x
);
This is a subquery inside a derived table inside a HAVING clause.

6. Subquery + JOIN
20. Customer name and orders above average
SELECT
   c.name,
   o.order_id,
   o.total_amount
FROM customers c
JOIN orders o
   ON c.customer_id = o.customer_id
WHERE o.total_amount > (
   SELECT AVG(total_amount)
   FROM orders
);
21. Product name and order details for products above average price
SELECT
   p.product_name,
   p.price,
   oi.order_id,
   oi.quantity
FROM products p
JOIN order_items oi
   ON p.product_id = oi.product_id
WHERE p.price > (
   SELECT AVG(price)
   FROM products
);
22. Customer + order + products above average price
SELECT
   c.name,
   o.order_id,
   p.product_name,
   p.price
FROM customers c
JOIN orders o
   ON c.customer_id = o.customer_id
JOIN order_items oi
   ON o.order_id = oi.order_id
JOIN products p
   ON oi.product_id = p.product_id
WHERE p.price > (
   SELECT AVG(price)
   FROM products
);

7. Nested Subqueries
23. Customers who purchased products from a particular category
SELECT customer_id, name
FROM customers
WHERE customer_id IN (
   SELECT customer_id
   FROM orders
   WHERE order_id IN (
       SELECT order_id
       FROM order_items
       WHERE product_id IN (
           SELECT product_id
           FROM products
           WHERE category_id = 1
       )
   )
);
This has:
customers
  ↓
orders
  ↓
order_items
  ↓
products

8. Correlated Subqueries
A correlated subquery refers to a column from the outer query.
24. Products more expensive than the average price of their category
SELECT
   p.product_id,
   p.product_name,
   p.category_id,
   p.price
FROM products p
WHERE p.price > (
   SELECT AVG(p2.price)
   FROM products p2
   WHERE p2.category_id = p.category_id
);
This is an important interview-level query.

25. Customers whose order is greater than their own average order
SELECT
   o.customer_id,
   o.order_id,
   o.total_amount
FROM orders o
WHERE o.total_amount > (
   SELECT AVG(o2.total_amount)
   FROM orders o2
   WHERE o2.customer_id = o.customer_id
);

9. ANY
26. Products more expensive than ANY product in category 1
SELECT product_id, product_name, price
FROM products
WHERE price > ANY (
   SELECT price
   FROM products
   WHERE category_id = 1
);
> ANY means greater than at least one value returned by the subquery.

10. ALL
27. Products more expensive than ALL products in category 1
SELECT product_id, product_name, price
FROM products
WHERE price > ALL (
   SELECT price
   FROM products
   WHERE category_id = 1
);
> ALL means greater than every value returned by the subquery.

11. NOT EXISTS + Multiple Tables
28. Customers who have never purchased a product
SELECT c.customer_id, c.name
FROM customers c
WHERE NOT EXISTS (
   SELECT 1
   FROM orders o
   JOIN order_items oi
       ON o.order_id = oi.order_id
   WHERE o.customer_id = c.customer_id
);

12. Subquery + JOIN + GROUP BY + HAVING
29. Customers whose total purchase is greater than the average customer purchase
SELECT
   c.customer_id,
   c.name,
   SUM(o.total_amount) AS total_purchase
FROM customers c
JOIN orders o
   ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_amount) > (
   SELECT AVG(customer_total)
   FROM (
       SELECT customer_id,
              SUM(total_amount) AS customer_total
       FROM orders
       GROUP BY customer_id
   ) x
);
This combines:
JOIN
+
GROUP BY
+
SUM()
+
HAVING
+
Subquery
+
Derived Table

13. Multi-level Subquery + JOIN
30. Find customers who purchased the most expensive product
SELECT DISTINCT
   c.customer_id,
   c.name
FROM customers c
JOIN orders o
   ON c.customer_id = o.customer_id
JOIN order_items oi
   ON o.order_id = oi.order_id
WHERE oi.product_id IN (
   SELECT product_id
   FROM products
   WHERE price = (
       SELECT MAX(price)
       FROM products
   )
);

14. Subquery to Find Top Customer
31. Customer with the highest total purchase
SELECT
   c.customer_id,
   c.name,
   SUM(o.total_amount) AS total_purchase
FROM customers c
JOIN orders o
   ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_amount) = (
   SELECT MAX(customer_total)
   FROM (
       SELECT customer_id,
              SUM(total_amount) AS customer_total
       FROM orders
       GROUP BY customer_id
   ) x
);

15. Subquery + NOT IN
32. Products not purchased by any customer
SELECT p.product_id, p.product_name
FROM products p
WHERE p.product_id NOT IN (
   SELECT oi.product_id
   FROM order_items oi
);
In production SQL, be careful with NOT IN if the subquery can return NULL. NOT EXISTS is often safer.

16. Subquery with Date Filtering
33. Customers who placed orders after the average order date
For date comparisons, use an appropriate date expression rather than treating dates like numeric averages. For example, find customers with orders after a particular derived date:
SELECT DISTINCT
   c.customer_id,
   c.name
FROM customers c
JOIN orders o
   ON c.customer_id = o.customer_id
WHERE o.order_date > (
   SELECT MIN(order_date)
   FROM orders
);

17. Advanced: Product Sales Above Average
SELECT
   p.product_id,
   p.product_name,
   SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
   ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > (
   SELECT AVG(product_quantity)
   FROM (
       SELECT product_id,
              SUM(quantity) AS product_quantity
       FROM order_items
       GROUP BY product_id
   ) x
);

18. Advanced: Customers Who Purchased More Than Average Quantity
SELECT
   c.customer_id,
   c.name,
   SUM(oi.quantity) AS total_quantity
FROM customers c
JOIN orders o
   ON c.customer_id = o.customer_id
JOIN order_items oi
   ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.name
HAVING SUM(oi.quantity) > (
   SELECT AVG(customer_quantity)
   FROM (
       SELECT o2.customer_id,
              SUM(oi2.quantity) AS customer_quantity
       FROM orders o2
       JOIN order_items oi2
           ON o2.order_id = oi2.order_id
       GROUP BY o2.customer_id
   ) x
);

Complete Subquery Combination Map
For your SmartMart SQL practice, these are the combinations I recommend covering:
SUBQUERIES
│
├── 1. Single-row subquery
│   ├── =
│   ├── >
│   ├── <
│   ├── >=
│   └── <=
│
├── 2. Multi-row subquery
│   ├── IN
│   ├── NOT IN
│   ├── ANY
│   └── ALL
│
├── 3. EXISTS
│   ├── EXISTS
│   └── NOT EXISTS
│
├── 4. Aggregate + Subquery
│   ├── AVG
│   ├── MAX
│   ├── MIN
│   ├── SUM
│   └── COUNT
│
├── 5. Correlated Subquery
│
├── 6. Nested Subquery
│   ├── Subquery inside Subquery
│   └── Multiple levels
│
├── 7. Subquery + JOIN
│
├── 8. Subquery + Multiple JOINs
│
├── 9. Subquery + GROUP BY
│
├── 10. Subquery + HAVING
│
├── 11. Subquery + WHERE
│
├── 12. Subquery + SELECT
│
├── 13. Subquery + FROM
│   └── Derived table
│
├── 14. Subquery + JOIN + GROUP BY
│
├── 15. Subquery + JOIN + GROUP BY + HAVING
│
├── 16. Correlated Subquery + JOIN
│
├── 17. EXISTS + JOIN
│
├── 18. NOT EXISTS + JOIN
│
└── 19. Nested Subquery + JOIN + Aggregate + HAVING
For SmartMart, this gives you the progression:
Basic Subquery → Multi-row Subquery → Nested Subquery → Correlated Subquery → Subquery + JOIN → Subquery + GROUP BY → Subquery + HAVING → Advanced combinations.

