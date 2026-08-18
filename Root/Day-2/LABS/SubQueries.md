# SQL Lab: Complex JOIN Operations

## Objective

Practice complex join operations in SQL.

## Summary

This lab introduces learners to advanced SQL joins, including:

* `INNER JOIN`
* `LEFT JOIN`
* `FULL OUTER JOIN`
* Self-join
* `GROUP BY` with joins
* Table aliases

Learners will practice retrieving and combining data from multiple related tables.

---

## 1. Create the Tables

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

## 2. Insert Sample Data

### Customers

```sql
INSERT INTO customers VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Chicago'),
(3, 'Charlie', 'San Francisco');
```

### Products

```sql
INSERT INTO products VALUES
(1, 'Laptop', 1000.00),
(2, 'Tablet', 500.00),
(3, 'Smartphone', 800.00);
```

### Orders

```sql
INSERT INTO orders VALUES
(1, 1, 1, '2023-01-01', 2),
(2, 2, 2, '2023-02-15', 1),
(3, 3, 3, '2023-03-10', 3);
```

---

# Exercises

## 3. INNER JOIN – Orders with Customer and Product Details

Write a query using an `INNER JOIN` to fetch all orders along with customer and product details.

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

### Expected Result

| order_id | customer_name | product_name | quantity | order_date |
| -------: | ------------- | ------------ | -------: | ---------- |
|        1 | Alice         | Laptop       |        2 | 2023-01-01 |
|        2 | Bob           | Tablet       |        1 | 2023-02-15 |
|        3 | Charlie       | Smartphone   |        3 | 2023-03-10 |

---

## 4. LEFT JOIN – All Customers and Their Orders

Write a query to fetch **all customers**, including customers who have never placed an order.

```sql
SELECT
    c.name AS customer_name,
    o.order_id,
    o.quantity
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
```

A `LEFT JOIN` keeps every row from the left table (`customers`), even when there is no matching row in `orders`.

---

## 5. FULL OUTER JOIN

Write a query using a `FULL OUTER JOIN` to combine customer and product data.

> **Note:** MySQL does not directly support `FULL OUTER JOIN`.

The following query works in databases that support `FULL OUTER JOIN`:

```sql
SELECT
    c.name AS customer_name,
    p.product_name
FROM customers c
FULL OUTER JOIN products p
    ON c.customer_id = p.product_id;
```

### Simulating FULL OUTER JOIN in MySQL

In MySQL, combine a `LEFT JOIN` and a reversed `LEFT JOIN` using `UNION`:

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

---

## 6. Using Table Aliases

Use aliases to make queries shorter and easier to read.

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

Here:

* `o` → `orders`
* `cu` → `customers`
* `pr` → `products`

---

## 7. Find Customers Who Never Placed an Order

Use a `LEFT JOIN` to identify customers who have no corresponding order.

```sql
SELECT
    c.name AS customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

### Why does this work?

The `LEFT JOIN` keeps all customers.

For a customer without an order, the columns from `orders` contain `NULL`.

Therefore:

```sql
WHERE o.order_id IS NULL
```

filters only customers without orders.

---

## 8. Self-Join – Identify Duplicate Orders

Use a self-join to compare rows within the same table.

```sql
SELECT
    o1.order_id AS order_id_1,
    o2.order_id AS order_id_2
FROM orders o1
INNER JOIN orders o2
    ON o1.customer_id = o2.customer_id
    AND o1.order_id != o2.order_id;
```

### Important

This query identifies multiple orders belonging to the same customer. It does **not necessarily prove that the orders are duplicates**.

For example, if Alice has orders `1` and `4`, the query identifies them as multiple orders for the same customer.

A more meaningful duplicate-order check might compare customer, product, date, and quantity:

```sql
SELECT
    o1.order_id AS order_id_1,
    o2.order_id AS order_id_2
FROM orders o1
INNER JOIN orders o2
    ON o1.customer_id = o2.customer_id
    AND o1.product_id = o2.product_id
    AND o1.order_date = o2.order_date
    AND o1.quantity = o2.quantity
    AND o1.order_id < o2.order_id;
```

Using:

```sql
o1.order_id < o2.order_id
```

prevents returning the same pair twice.

---

## 9. JOIN + GROUP BY – Calculate Total Revenue per Customer

Calculate the total revenue generated by each customer.

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

### Revenue Calculation

The formula is:

```text
Revenue = Quantity × Product Price
```

For example:

```text
Alice
2 × $1,000 = $2,000
```

```text
Bob
1 × $500 = $500
```

```text
Charlie
3 × $800 = $2,400
```

### Expected Result

| customer_name | total_revenue |
| ------------- | ------------: |
| Alice         |       2000.00 |
| Bob           |        500.00 |
| Charlie       |       2400.00 |

---

# Challenge Questions

## Challenge 1

Display:

* Customer name
* City
* Product name
* Quantity
* Product price
* Total order value

```sql
SELECT
    c.name AS customer_name,
    c.city,
    p.product_name,
    o.quantity,
    p.price,
    o.quantity * p.price AS order_value
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id;
```

---

## Challenge 2

Find customers whose total spending is greater than `1000`.

```sql
SELECT
    c.name AS customer_name,
    SUM(o.quantity * p.price) AS total_spending
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.quantity * p.price) > 1000;
```

---

## Challenge 3

Display all customers, including customers who have never ordered anything, along with their total spending.

```sql
SELECT
    c.name AS customer_name,
    COALESCE(SUM(o.quantity * p.price), 0) AS total_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name;
```

`COALESCE()` converts `NULL` into `0`.

---

## Challenge 4

Find the customer who generated the highest revenue.

```sql
SELECT
    c.name AS customer_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC
LIMIT 1;
```

---

# Key Learning Points

| JOIN / Concept      | Purpose                                                    |
| ------------------- | ---------------------------------------------------------- |
| `INNER JOIN`        | Returns only matching records                              |
| `LEFT JOIN`         | Returns all records from the left table                    |
| `FULL OUTER JOIN`   | Returns matching and non-matching records from both tables |
| `SELF JOIN`         | Joins a table with itself                                  |
| `UNION`             | Can help simulate `FULL OUTER JOIN` in MySQL               |
| Table Alias         | Makes complex queries shorter and easier to read           |
| `GROUP BY` + `JOIN` | Aggregates data across related tables                      |
| `HAVING`            | Filters aggregated results                                 |
| `COALESCE()`        | Replaces `NULL` with another value                         |
