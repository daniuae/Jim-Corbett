# SQL Lab: Complex JOIN Operations

## Objective

Practice complex join operations in SQL.

## Summary

This lab introduces learners to advanced SQL joins:

* `INNER JOIN`
* `LEFT JOIN`
* `FULL OUTER JOIN`
* Self-join
* Table aliases
* `GROUP BY` with joins

The goal is to retrieve and combine data from multiple related tables.

---

# Step 1: Create the Tables

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

---

# Step 2: Insert Sample Data

## Customers

```sql
INSERT INTO customers VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Chicago'),
(3, 'Charlie', 'San Francisco');
```

## Products

```sql
INSERT INTO products VALUES
(1, 'Laptop', 1000.00),
(2, 'Tablet', 500.00),
(3, 'Smartphone', 800.00);
```

## Orders

```sql
INSERT INTO orders VALUES
(1, 1, 1, '2023-01-01', 2),
(2, 2, 2, '2023-02-15', 1),
(3, 3, 3, '2023-03-10', 3);
```

---

# Step 3: INNER JOIN

## Business Question

> Show every order along with the customer who placed it and the product that was purchased.

```sql
SELECT
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    o.quantity,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id;
```

### Key Idea

`INNER JOIN` returns only records where matching records exist in both tables.

---

# Step 4: LEFT JOIN

## Business Question

> Show every customer, including customers who have never placed an order.

```sql
SELECT
    c.name AS customer_name,
    o.order_id,
    o.quantity
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
```

### Key Idea

`LEFT JOIN` keeps **all rows from the left table**.

If a customer has no order, the order columns contain `NULL`.

---

# Step 5: FULL OUTER JOIN

## Business Question

> Show all customers and all products, whether or not they have matching IDs.

In databases that support `FULL OUTER JOIN`:

```sql
SELECT
    c.name AS customer_name,
    p.product_name
FROM customers c
FULL OUTER JOIN products p
    ON c.customer_id = p.product_id;
```

## Important: MySQL

MySQL does **not** support `FULL OUTER JOIN` directly.

We can simulate it using `LEFT JOIN` + `UNION`.

```sql
SELECT
    c.name AS customer_name,
    p.product_name
FROM customers c
LEFT JOIN products p
    ON c.customer_id = p.product_id

UNION

SELECT
    c.name AS customer_name,
    p.product_name
FROM products p
LEFT JOIN customers c
    ON c.customer_id = p.product_id;
```

### Concept

```text
LEFT JOIN
    +
LEFT JOIN in reverse direction
    +
UNION
    =
FULL OUTER JOIN
```

---

# Step 6: Using Table Aliases

Without aliases:

```sql
SELECT
    orders.order_id,
    customers.name,
    products.product_name
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.customer_id
INNER JOIN products
    ON orders.product_id = products.product_id;
```

With aliases:

```sql
SELECT
    o.order_id,
    cu.name AS customer_name,
    pr.product_name
FROM orders o
INNER JOIN customers cu
    ON o.customer_id = cu.customer_id
INNER JOIN products pr
    ON o.product_id = pr.product_id;
```

### Alias Meaning

```text
o  → orders
cu → customers
pr → products
```

Aliases make complex SQL easier to read and write.

---

# Step 7: Find Customers Who Never Placed an Order

## Business Question

> Which customers have never placed an order?

```sql
SELECT
    c.name AS customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

### Why Does This Work?

The `LEFT JOIN` returns every customer.

For customers without orders:

```text
o.order_id = NULL
```

Therefore:

```sql
WHERE o.order_id IS NULL
```

returns only customers without orders.

---

# Step 8: SELF JOIN

## Business Question

> Identify customers who have placed more than one order.

A self-join joins a table with itself.

```sql
SELECT
    o1.order_id AS order_1,
    o2.order_id AS order_2,
    o1.customer_id
FROM orders o1
INNER JOIN orders o2
    ON o1.customer_id = o2.customer_id
    AND o1.order_id < o2.order_id;
```

### Why Use `<` Instead of `!=`?

Using:

```sql
o1.order_id != o2.order_id
```

can produce duplicate pairs:

```text
Order 1 → Order 2
Order 2 → Order 1
```

Using:

```sql
o1.order_id < o2.order_id
```

returns only:

```text
Order 1 → Order 2
```

This avoids duplicate combinations.

---

# Step 9: Find Duplicate Orders

If an order is considered a duplicate when the same customer purchased the same product on the same date with the same quantity:

```sql
SELECT
    o1.order_id AS order_1,
    o2.order_id AS order_2
FROM orders o1
INNER JOIN orders o2
    ON o1.customer_id = o2.customer_id
    AND o1.product_id = o2.product_id
    AND o1.order_date = o2.order_date
    AND o1.quantity = o2.quantity
    AND o1.order_id < o2.order_id;
```

This is a better duplicate check than comparing only `customer_id`.

---

# Step 10: JOIN + GROUP BY

## Business Question

> How much revenue has each customer generated?

Revenue formula:

```text
Revenue = Quantity × Product Price
```

SQL:

```sql
SELECT
    c.name AS customer_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.name;
```

### Expected Result

| customer_name | total_revenue |
| ------------- | ------------: |
| Alice         |       2000.00 |
| Bob           |        500.00 |
| Charlie       |       2400.00 |

### Calculation

```text
Alice
2 × 1000 = 2000

Bob
1 × 500 = 500

Charlie
3 × 800 = 2400
```

---

# Step 11: JOIN + GROUP BY + HAVING

## Business Question

> Find customers whose total revenue is greater than 1,000.

```sql
SELECT
    c.name AS customer_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.name
HAVING SUM(o.quantity * p.price) > 1000;
```

### Important

`WHERE` filters rows **before aggregation**.

`HAVING` filters groups **after aggregation**.

---

# Step 12: Show Customers With or Without Orders

## Business Question

> Show every customer and their total spending. Customers with no orders should show `0`.

```sql
SELECT
    c.name AS customer_name,
    COALESCE(SUM(o.quantity * p.price), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name;
```

`COALESCE()` converts `NULL` into `0`.

---

# Step 13: Complete Business Query

## Business Question

> Show customer name, city, product, quantity, product price, order value, and order date.

```sql
SELECT
    c.name AS customer_name,
    c.city,
    p.product_name,
    p.price,
    o.quantity,
    o.quantity * p.price AS order_value,
    o.order_date
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id;
```

---

# Practice Challenges

## Challenge 1

Find the customer who generated the highest revenue.

**Hint:** Use:

```text
JOIN
→ GROUP BY
→ ORDER BY
→ LIMIT
```

---

## Challenge 2

Find the most expensive product that has been ordered.

---

## Challenge 3

Find customers who have placed more than one order.

---

## Challenge 4

Find the total number of products purchased by each customer.

---

## Challenge 5

Find the total revenue generated by each city.

---

## Challenge 6

Find customers whose total spending is greater than `2000`.

---

## Challenge 7

Display all customers and show `0` for customers who have never placed an order.

---

## Challenge 8

Find the product that generated the highest revenue.

---

## Challenge 9

Find the customer who purchased the largest quantity of products.

---

## Challenge 10

Display:

```text
Customer Name
City
Order ID
Order Date
Product Name
Quantity
Price
Order Value
```

Sort the result by highest order value first.

---

# JOIN Cheat Sheet

| Requirement                 | JOIN                            |
| --------------------------- | ------------------------------- |
| Only matching records       | `INNER JOIN`                    |
| Everything from left table  | `LEFT JOIN`                     |
| Everything from right table | `RIGHT JOIN`                    |
| Everything from both tables | `FULL OUTER JOIN`               |
| MySQL FULL OUTER JOIN       | `LEFT JOIN + UNION + LEFT JOIN` |
| Compare rows in same table  | `SELF JOIN`                     |
| Find missing matches        | `LEFT JOIN + IS NULL`           |
| Aggregate joined data       | `JOIN + GROUP BY`               |
| Filter aggregated results   | `HAVING`                        |

---

# Mental Model

When solving a JOIN problem, ask these questions:

```text
1. Which table contains the main information?

2. Which table should never lose its rows?

3. What column connects the tables?

4. Do I need only matching rows?

5. Do I need unmatched rows?

6. Do I need aggregation?

7. If I aggregate, do I need HAVING?

8. Can an alias make the query easier to understand?
```

## Remember

```text
INNER JOIN
    ↓
Only matching records

LEFT JOIN
    ↓
Everything from LEFT table

FULL OUTER JOIN
    ↓
Everything from BOTH tables

SELF JOIN
    ↓
Table joined with ITSELF

JOIN + GROUP BY
    ↓
Business-level aggregation

JOIN + GROUP BY + HAVING
    ↓
Aggregation + filtering
```
