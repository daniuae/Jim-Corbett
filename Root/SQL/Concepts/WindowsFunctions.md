# SmartMart SQL Window Functions — 5 Practice Problems

## Overview

These five problems provide a progressive hands-on exercise set for learning MySQL 8+ window functions using a consistent **SmartMart** business scenario.

### Functions Covered

| Problem | Main Functions |
|---|---|
| 1. Customer Purchase Ranking | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `NTILE()` |
| 2. Customer Purchase History | `LAG()`, `LEAD()` |
| 3. Running Total and Moving Average | `SUM() OVER()`, `AVG() OVER()`, `COUNT() OVER()` |
| 4. First, Last and Nth Purchase | `FIRST_VALUE()`, `LAST_VALUE()`, `NTH_VALUE()` |
| 5. Advanced Customer Analytics | `PERCENT_RANK()`, `CUME_DIST()`, window aggregates |

---

# 1. Customer Purchase Ranking

## Business Problem

SmartMart wants to analyze customers based on their total purchase amount.

For every customer, calculate:

1. Total amount spent.
2. `ROW_NUMBER()` based on total spending.
3. `RANK()` based on total spending.
4. `DENSE_RANK()` based on total spending.
5. Divide customers into four spending groups using `NTILE(4)`.
6. Display customers from highest spender to lowest spender.

## Database

```sql
CREATE DATABASE smartmart;

USE smartmart;
```

## Customers Table

```sql
CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
```

## Purchases Table

```sql
CREATE TABLE purchases
(
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_date DATE,
    purchase_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
```

## Insert Customers

```sql
INSERT INTO customers
(customer_id, customer_name, city)
VALUES
(1, 'Arun', 'Chennai'),
(2, 'Bala', 'Coimbatore'),
(3, 'Chitra', 'Bangalore'),
(4, 'Divya', 'Chennai'),
(5, 'Elango', 'Coimbatore'),
(6, 'Farah', 'Bangalore'),
(7, 'Gokul', 'Madurai'),
(8, 'Hari', 'Chennai');
```

## Insert Purchases

```sql
INSERT INTO purchases
(purchase_id, customer_id, purchase_date, purchase_amount)
VALUES
(101, 1, '2026-01-05', 5000),
(102, 1, '2026-02-10', 3000),

(103, 2, '2026-01-15', 7000),
(104, 2, '2026-02-20', 1000),

(105, 3, '2026-01-20', 8000),
(106, 3, '2026-03-05', 2000),

(107, 4, '2026-01-25', 6000),
(108, 4, '2026-02-15', 4000),

(109, 5, '2026-02-01', 9000),

(110, 6, '2026-02-05', 3000),
(111, 6, '2026-03-10', 2000),

(112, 7, '2026-02-10', 5000),

(113, 8, '2026-03-01', 10000);
```

## Solution

```sql
SELECT
    customer_id,
    customer_name,
    total_spent,

    ROW_NUMBER() OVER
    (
        ORDER BY total_spent DESC
    ) AS row_num,

    RANK() OVER
    (
        ORDER BY total_spent DESC
    ) AS customer_rank,

    DENSE_RANK() OVER
    (
        ORDER BY total_spent DESC
    ) AS dense_customer_rank,

    NTILE(4) OVER
    (
        ORDER BY total_spent DESC
    ) AS spending_quartile

FROM
(
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.purchase_amount) AS total_spent

    FROM customers c
    JOIN purchases p
        ON c.customer_id = p.customer_id

    GROUP BY
        c.customer_id,
        c.customer_name
) x

ORDER BY total_spent DESC;
```

### Key Learning

If two customers have the same amount:

```text
ROW_NUMBER() → 1, 2
RANK()       → 1, 1, 3
DENSE_RANK() → 1, 1, 2
```

---

# 2. Customer Purchase History

## Business Problem

SmartMart wants to understand how customer purchases change over time.

For every purchase, display:

1. Customer name.
2. Purchase date.
3. Current purchase amount.
4. Previous purchase amount.
5. Next purchase amount.
6. Difference between current and previous purchase.
7. Percentage change from the previous purchase.

Use:

- `LAG()`
- `LEAD()`

## Solution

```sql
SELECT
    c.customer_name,
    p.purchase_date,
    p.purchase_amount,

    LAG(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
    ) AS previous_purchase,

    LEAD(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
    ) AS next_purchase,

    p.purchase_amount
    -
    LAG(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
    ) AS difference_from_previous,

    ROUND
    (
        (
            p.purchase_amount
            -
            LAG(p.purchase_amount) OVER
            (
                PARTITION BY p.customer_id
                ORDER BY p.purchase_date
            )
        )
        /
        NULLIF
        (
            LAG(p.purchase_amount) OVER
            (
                PARTITION BY p.customer_id
                ORDER BY p.purchase_date
            ),
            0
        )
        * 100,
        2
    ) AS percentage_change

FROM purchases p

JOIN customers c
    ON p.customer_id = c.customer_id

ORDER BY
    c.customer_name,
    p.purchase_date;
```

## Pattern

When the question contains:

- **previous / prior / before** → `LAG()`
- **next / following / upcoming** → `LEAD()`

---

# 3. Running Total and Moving Average

## Business Problem

SmartMart wants to monitor each customer's spending progression.

For every purchase, calculate:

1. Purchase amount.
2. Total purchases made by the customer.
3. Running total spent by the customer.
4. Average purchase amount for the customer.
5. Number of purchases made by the customer.
6. Average of the current purchase and previous purchase.

Use:

- `SUM() OVER()`
- `AVG() OVER()`
- `COUNT() OVER()`

## Solution

```sql
SELECT
    c.customer_name,
    p.purchase_date,
    p.purchase_amount,

    SUM(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
    ) AS total_customer_spending,

    SUM(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND CURRENT ROW
    ) AS running_total,

    AVG(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
    ) AS average_purchase,

    COUNT(*) OVER
    (
        PARTITION BY p.customer_id
    ) AS purchase_count,

    AVG(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
        ROWS BETWEEN 1 PRECEDING
             AND CURRENT ROW
    ) AS two_purchase_moving_average

FROM purchases p

JOIN customers c
    ON p.customer_id = c.customer_id

ORDER BY
    c.customer_name,
    p.purchase_date;
```

## Three Important Patterns

### Customer Total

```sql
SUM(amount) OVER
(
    PARTITION BY customer_id
)
```

Every row receives the same customer total.

### Running Total

```sql
SUM(amount) OVER
(
    PARTITION BY customer_id
    ORDER BY purchase_date
)
```

The value grows row by row.

### Moving Average

```sql
AVG(amount) OVER
(
    PARTITION BY customer_id
    ORDER BY purchase_date
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
)
```

Only the current and previous rows participate.

---

# 4. First, Last and Nth Purchase

## Business Problem

SmartMart wants to compare every purchase against a customer's purchase history.

For every purchase, display:

1. First purchase amount.
2. Last purchase amount.
3. Second purchase amount.
4. Difference between current purchase and first purchase.
5. Difference between current purchase and last purchase.

Use:

- `FIRST_VALUE()`
- `LAST_VALUE()`
- `NTH_VALUE()`

## Important MySQL Concept

For `LAST_VALUE()`, use an explicit frame when you need the actual final value of the partition:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING
```

Otherwise, the result can be the current row rather than the final row.

## Solution

```sql
SELECT
    c.customer_name,
    p.purchase_date,
    p.purchase_amount,

    FIRST_VALUE(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
    ) AS first_purchase,

    LAST_VALUE(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
    ) AS last_purchase,

    NTH_VALUE(p.purchase_amount, 2) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
    ) AS second_purchase,

    p.purchase_amount
    -
    FIRST_VALUE(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
    ) AS difference_from_first,

    p.purchase_amount
    -
    LAST_VALUE(p.purchase_amount) OVER
    (
        PARTITION BY p.customer_id
        ORDER BY p.purchase_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
    ) AS difference_from_last

FROM purchases p

JOIN customers c
    ON p.customer_id = c.customer_id

ORDER BY
    c.customer_name,
    p.purchase_date;
```

## Pattern

| Requirement | Function |
|---|---|
| First value | `FIRST_VALUE()` |
| Last value | `LAST_VALUE()` |
| Nth value | `NTH_VALUE()` |

---

# 5. Advanced Customer Analytics

## Business Problem

SmartMart wants to classify customers based on total spending.

Calculate:

1. Total customer spending.
2. Customer rank.
3. Percentage rank.
4. Cumulative distribution.
5. Running percentage of total company revenue.
6. Difference between customer spending and average customer spending.
7. Whether the customer is above or below average.

Use:

- `RANK()`
- `PERCENT_RANK()`
- `CUME_DIST()`
- `SUM() OVER()`
- `AVG() OVER()`

## Solution

```sql
SELECT
    customer_id,
    customer_name,
    total_spent,

    RANK() OVER
    (
        ORDER BY total_spent DESC
    ) AS customer_rank,

    ROUND
    (
        PERCENT_RANK() OVER
        (
            ORDER BY total_spent
        ),
        4
    ) AS percent_rank,

    ROUND
    (
        CUME_DIST() OVER
        (
            ORDER BY total_spent
        ),
        4
    ) AS cumulative_distribution,

    ROUND
    (
        SUM(total_spent) OVER
        (
            ORDER BY total_spent DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
        )
        /
        SUM(total_spent) OVER ()
        * 100,
        2
    ) AS cumulative_revenue_percentage,

    ROUND
    (
        total_spent
        -
        AVG(total_spent) OVER (),
        2
    ) AS difference_from_average,

    CASE
        WHEN total_spent > AVG(total_spent) OVER ()
            THEN 'Above Average'

        WHEN total_spent < AVG(total_spent) OVER ()
            THEN 'Below Average'

        ELSE 'Average'
    END AS spending_category

FROM
(
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.purchase_amount) AS total_spent

    FROM customers c

    JOIN purchases p
        ON c.customer_id = p.customer_id

    GROUP BY
        c.customer_id,
        c.customer_name
) x

ORDER BY
    total_spent DESC;
```

---

# Complete Window Function Cheat Sheet

## 1. Ranking Functions

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
NTILE()
```

Use when you need to:

> Rank rows or divide rows into groups.

---

## 2. Navigation Functions

```sql
LAG()
LEAD()
```

Use when you need:

> Previous or next row information.

---

## 3. Value Functions

```sql
FIRST_VALUE()
LAST_VALUE()
NTH_VALUE()
```

Use when you need:

> A value from a particular position within the window.

---

## 4. Distribution Functions

```sql
PERCENT_RANK()
CUME_DIST()
```

Use when you need:

> Relative position within a distribution.

---

## 5. Aggregate Window Functions

```sql
SUM() OVER()
AVG() OVER()
COUNT() OVER()
MIN() OVER()
MAX() OVER()
```

Use when you need:

> Aggregate information without collapsing individual rows.

---

# GROUP BY vs Window Functions

## GROUP BY

```text
Multiple rows
      ↓
GROUP BY
      ↓
One result row per group
```

Example:

```sql
SELECT
    customer_id,
    SUM(purchase_amount)
FROM purchases
GROUP BY customer_id;
```

## Window Function

```text
Multiple rows
      ↓
Window Function
      ↓
Multiple rows remain
      ↓
Calculation is attached to each row
```

Example:

```sql
SELECT
    customer_id,
    purchase_date,
    purchase_amount,

    SUM(purchase_amount) OVER
    (
        PARTITION BY customer_id
    ) AS customer_total

FROM purchases;
```

---

# How to Recognize the Correct Window Function

Don't ask:

> **"Which SQL function should I use?"**

Instead ask:

> **"What relationship between rows does the business question require?"**

| Business Requirement | Function |
|---|---|
| Rank rows uniquely | `ROW_NUMBER()` |
| Rank with gaps | `RANK()` |
| Rank without gaps | `DENSE_RANK()` |
| Divide rows into groups | `NTILE()` |
| Previous row | `LAG()` |
| Next row | `LEAD()` |
| First value | `FIRST_VALUE()` |
| Last value | `LAST_VALUE()` |
| Nth value | `NTH_VALUE()` |
| Running total | `SUM() OVER()` |
| Running average | `AVG() OVER()` |
| Row count within partition | `COUNT() OVER()` |
| Relative percentage position | `PERCENT_RANK()` |
| Cumulative distribution | `CUME_DIST()` |

---

# Recommended Learning Progression

```text
                    WINDOW FUNCTIONS
                           |
          +----------------+----------------+
          |                |                |
       RANKING        NAVIGATION        AGGREGATES
          |                |                |
          v                v                v
     Problem 1         Problem 2         Problem 3
          |                |                |
 ROW_NUMBER()           LAG()             SUM()
 RANK()                 LEAD()            AVG()
 DENSE_RANK()                              COUNT()
 NTILE()
          |
          v
    VALUE FUNCTIONS
          |
          v
      Problem 4
          |
 FIRST_VALUE()
 LAST_VALUE()
 NTH_VALUE()
          |
          v
   DISTRIBUTION
          |
          v
      Problem 5
          |
 PERCENT_RANK()
 CUME_DIST()
```

## Final Mental Model

```text
Question
   ↓
What relationship between rows is required?
   ↓
+-------------------------------+
| Ranking?       → Ranking      |
| Previous?      → LAG          |
| Next?          → LEAD         |
| First/Last?    → VALUE        |
| Running?       → Aggregate    |
| Relative rank? → Distribution |
| Groups?        → NTILE        |
+-------------------------------+
   ↓
Choose PARTITION BY
   ↓
Choose ORDER BY
   ↓
Choose window frame if required
   ↓
Write the window function
```

This framework helps trainees **solve window-function problems rather than memorize syntax**.
