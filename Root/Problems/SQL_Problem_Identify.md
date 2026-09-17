# SQL Problem-Solving Framework

## How to Identify Which SQL Function or Technique to Use

> **Core Rule:**
>
> **WHAT → GRAIN → TABLE → JOIN → FILTER → CALCULATE → GROUP/WINDOW → VALIDATE**

The objective is **not to memorize hundreds of SQL functions**.

The objective is to learn how to read a problem statement and systematically identify the SQL functionality required.

---

# 1. WHAT — What exactly is being asked?

First, underline the important words in the problem statement.

| Problem Statement Keyword | Think About                                |
| ------------------------- | ------------------------------------------ |
| list / display / show     | `SELECT`                                   |
| only / where              | `WHERE`                                    |
| unique / distinct         | `DISTINCT`                                 |
| total                     | `SUM()`                                    |
| average                   | `AVG()`                                    |
| highest                   | `MAX()`                                    |
| lowest                    | `MIN()`                                    |
| number of / how many      | `COUNT()`                                  |
| for each                  | `GROUP BY`                                 |
| per customer              | `GROUP BY customer`                        |
| per department            | `GROUP BY department`                      |
| groups having             | `HAVING`                                   |
| matching records          | `JOIN`                                     |
| not matching              | `LEFT JOIN + IS NULL` / `NOT EXISTS`       |
| top N                     | `ORDER BY + LIMIT/TOP`                     |
| rank                      | `RANK()` / `DENSE_RANK()` / `ROW_NUMBER()` |
| previous                  | `LAG()`                                    |
| next                      | `LEAD()`                                   |
| running total             | `SUM() OVER()`                             |
| percentage                | Aggregate + arithmetic                     |
| above average             | Subquery / CTE                             |
| latest record             | `ROW_NUMBER()` / `MAX()`                   |
| first record              | `ROW_NUMBER()` / `MIN()`                   |
| duplicate                 | `GROUP BY + HAVING COUNT(*) > 1`           |
| consecutive               | Window functions                           |
| change from previous      | `LAG()`                                    |
| cumulative                | Window function                            |

---

# 2. GRAIN — What should ONE row represent?

This is one of the most important questions in SQL.

Ask:

> **"If my query is correct, what does one row in my final result represent?"**

Examples:

| Problem                              | Output Grain            |
| ------------------------------------ | ----------------------- |
| List employees                       | Employee                |
| Total sales by customer              | Customer                |
| Sales by department                  | Department              |
| Monthly revenue                      | Month                   |
| Customer's latest order              | Customer                |
| Highest-paid employee per department | Department              |
| Number of orders per customer        | Customer                |
| Order details                        | Order                   |
| Top 3 products per category          | Product within Category |

## Golden Rule

> **The required output grain determines your `GROUP BY`, `PARTITION BY`, or both.**

---

# 3. TABLE — Where is the required information?

Identify which tables contain the required columns.

Example:

### Problem

> Find customer names and their total order amount.

Required information:

```text
Customers
    └── Customer Name

Orders
    └── Order Amount
```

Therefore:

```text
Customers
    |
    JOIN
    |
Orders
```

You now know that a `JOIN` is required.

---

# 4. JOIN — Do I need another table?

Ask:

> **"Can I answer this question using one table?"**

If **yes**:

```sql
SELECT ...
FROM table;
```

If **no**:

```sql
SELECT ...
FROM table1
JOIN table2
    ON table1.key = table2.key;
```

## JOIN Decision

| Requirement                                | Technique             |
| ------------------------------------------ | --------------------- |
| Only matching records                      | `INNER JOIN`          |
| Keep everything from left table            | `LEFT JOIN`           |
| Keep everything from right table           | `RIGHT JOIN`          |
| Keep everything from both                  | `FULL OUTER JOIN`     |
| Compare rows within same table             | `SELF JOIN`           |
| Find records with no match                 | `LEFT JOIN + IS NULL` |
| Check whether matching records exist       | `EXISTS`              |
| Check whether matching records don't exist | `NOT EXISTS`          |

---

# 5. COLUMN — Which columns are required?

Separate columns into three categories.

## A. Output Columns

What should appear in the result?

```text
CustomerName
TotalSales
```

## B. Filter Columns

What determines which rows are included?

```text
OrderDate
Country
Status
```

## C. Calculation Columns

What needs to be calculated?

```text
Quantity
Price
Amount
```

This separation makes complex problems much easier.

---

# 6. FILTER — WHERE or HAVING?

This is a very common source of mistakes.

## WHERE

Use `WHERE` when filtering **individual rows**.

```sql
SELECT *
FROM employees
WHERE salary > 50000;
```

Think:

> **Filter BEFORE grouping**

---

## HAVING

Use `HAVING` when filtering **groups**.

```sql
SELECT customer_id,
       SUM(amount) AS total_sales
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 100000;
```

Think:

> **Filter AFTER grouping**

---

## Easy Rule

```text
WHERE  → Individual Rows
HAVING → Groups
```

### Example

> Find customers who have more than 10 orders.

The condition applies to:

```sql
COUNT(*)
```

Therefore:

```sql
HAVING COUNT(*) > 10
```

---

# 7. CALCULATE — What calculation is required?

Look for mathematical words.

| Requirement             | Function                 |
| ----------------------- | ------------------------ |
| Total                   | `SUM()`                  |
| Average                 | `AVG()`                  |
| Count                   | `COUNT()`                |
| Highest                 | `MAX()`                  |
| Lowest                  | `MIN()`                  |
| Number of unique values | `COUNT(DISTINCT column)` |

Examples:

```sql
SUM(amount)
```

```sql
AVG(salary)
```

```sql
COUNT(*)
```

```sql
COUNT(DISTINCT customer_id)
```

```sql
MAX(salary)
```

```sql
MIN(salary)
```

---

# 8. GROUP BY — Do I need to collapse rows?

Use `GROUP BY` when the question says:

* per customer
* by department
* per product
* by country
* monthly
* yearly
* for each category

Example:

> Find total sales for each customer.

```sql
SELECT customer_id,
       SUM(amount) AS total_sales
FROM orders
GROUP BY customer_id;
```

The rows are collapsed into:

```text
Customer
   ↓
SUM()
   ↓
One row per customer
```

---

# 9. GROUP BY vs WINDOW FUNCTION

This is one of the most important concepts.

## GROUP BY

> **Reduce rows**

```sql
SELECT customer_id,
       SUM(amount) AS total_sales
FROM orders
GROUP BY customer_id;
```

Result:

```text
customer_id | total_sales
------------+------------
101         | 5000
102         | 7000
103         | 3000
```

---

## Window Function

> **Keep rows + calculate across rows**

```sql
SELECT customer_id,
       order_id,
       amount,
       SUM(amount) OVER (
           PARTITION BY customer_id
       ) AS customer_total
FROM orders;
```

Result:

```text
customer | order | amount | customer_total
---------+-------+--------+---------------
101      | 1     | 2000   | 5000
101      | 2     | 3000   | 5000
102      | 3     | 7000   | 7000
```

## Golden Rule

> **GROUP BY = Collapse rows**

> **WINDOW = Keep rows**

---

# 10. RANKING — Does the problem ask for position?

Look for:

* rank
* top 3
* top 5
* highest 2
* lowest 3
* first
* second
* third

Think about:

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
```

---

# 11. ROW_NUMBER vs RANK vs DENSE_RANK

## ROW_NUMBER()

Always gives a unique sequence.

```sql
ROW_NUMBER() OVER (
    ORDER BY salary DESC
)
```

Example:

```text
Salary | Row_Number
-------+-----------
100000 | 1
100000 | 2
90000  | 3
80000  | 4
```

---

## RANK()

Same values receive the same rank, with gaps.

```text
Salary | Rank
-------+-----
100000 | 1
100000 | 1
90000  | 3
80000  | 4
```

---

## DENSE_RANK()

Same values receive the same rank, without gaps.

```text
Salary | Dense_Rank
-------+-----------
100000 | 1
100000 | 1
90000  | 2
80000  | 3
```

---

# 12. PARTITION BY — "For each group"

Whenever you see:

> highest salary **in each department**

Think:

```sql
PARTITION BY department
```

Example:

```sql
ROW_NUMBER() OVER (
    PARTITION BY department
    ORDER BY salary DESC
)
```

Mental translation:

```text
For EACH department
        ↓
Sort employees by salary
        ↓
Assign row numbers
```

---

# 13. LAG and LEAD

Look for:

* previous
* next
* previous month
* previous transaction
* compare with previous row
* compare current vs previous

Use:

```sql
LAG()
```

For next row:

```sql
LEAD()
```

Example:

```sql
SELECT employee_id,
       salary,
       LAG(salary) OVER (
           ORDER BY employee_id
       ) AS previous_salary
FROM employees;
```

---

# 14. Running Total

Look for:

* running total
* cumulative total
* accumulated sales
* year-to-date
* cumulative amount

Think:

```sql
SUM() OVER()
```

Example:

```sql
SELECT order_date,
       amount,
       SUM(amount) OVER (
           ORDER BY order_date
       ) AS running_total
FROM orders;
```

Mental translation:

```text
Current row
     +
All previous rows
     ↓
Running Total
```

---

# 15. FIRST / LATEST RECORD

Look for:

* latest order
* first transaction
* most recent purchase
* latest employee record
* first login
* last transaction

A common solution is:

```sql
ROW_NUMBER() OVER (
    PARTITION BY customer_id
    ORDER BY order_date DESC
)
```

Then select:

```sql
WHERE rn = 1
```

### Mental Translation

```text
For each customer
       ↓
Sort orders newest → oldest
       ↓
Assign row number
       ↓
Take row 1
```

---

# 16. DUPLICATES

Look for:

* duplicate customers
* repeated email
* duplicate records
* multiple records with same ID

Think:

```sql
GROUP BY
HAVING COUNT(*) > 1
```

Example:

```sql
SELECT email,
       COUNT(*) AS count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;
```

Mental translation:

```text
Group identical values
        ↓
Count them
        ↓
Keep groups > 1
```

---

# 17. ABOVE / BELOW AVERAGE

Look for:

* above average
* below average
* greater than company average
* less than department average

Think:

> **Subquery or CTE**

Example:

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

Mental translation:

```text
Calculate Average
       ↓
Compare each employee
       ↓
Keep salary > average
```

---

# 18. EXISTS / NOT EXISTS

Use `EXISTS` when the question is essentially:

> "Does a matching record exist?"

Example:

> Find customers who have placed at least one order.

```sql
SELECT c.*
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

For:

> Customers who have never placed an order.

```sql
SELECT c.*
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

---

# 19. SQL FUNCTION DECISION TREE

```text
                    PROBLEM
                       |
                       v
              What is being asked?
                       |
       +---------------+----------------+
       |               |                |
     FILTER          COMBINE         CALCULATE
       |               |                |
   WHERE/HAVING       JOIN          Aggregate/Window
                       |                |
               +-------+-------+    +---+---+
               |       |       |    |       |
             INNER   LEFT    SELF  GROUP   WINDOW
             JOIN    JOIN    JOIN   BY      OVER()
                                     
                                     
        +------------------------------------------+
        |
        v
   Does it ask for position?
        |
   +----+----+
   |         |
  YES       NO
   |
   v
RANK / ROW_NUMBER / DENSE_RANK


        +------------------------------------------+
        |
        v
   Previous / Next?
        |
   +----+----+
   |         |
 LAG()     LEAD()


        +------------------------------------------+
        |
        v
   First / Latest?
        |
        v
   ROW_NUMBER()


        +------------------------------------------+
        |
        v
   Compare with another result?
        |
        v
   SUBQUERY / CTE


        +------------------------------------------+
        |
        v
   Does matching record exist?
        |
        v
   EXISTS / NOT EXISTS
```

---

# 20. THE 10 GOLDEN RULES

Memorize these rules.

## Rule 1

> **Filter individual rows → `WHERE`**

```sql
WHERE salary > 50000
```

---

## Rule 2

> **Filter groups → `HAVING`**

```sql
HAVING SUM(sales) > 100000
```

---

## Rule 3

> **"For each..." → `GROUP BY`**

```sql
GROUP BY customer_id
```

---

## Rule 4

> **Need another table → `JOIN`**

```sql
JOIN orders
```

---

## Rule 5

> **Compare against another result → Subquery / CTE**

```sql
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
```

---

## Rule 6

> **Need ranking → Window Function**

```sql
RANK()
DENSE_RANK()
ROW_NUMBER()
```

---

## Rule 7

> **Need previous/next → `LAG()` / `LEAD()`**

---

## Rule 8

> **Need running/cumulative calculation → `SUM() OVER()`**

---

## Rule 9

> **Need first/latest record per group → `ROW_NUMBER()`**

---

## Rule 10

> **Need duplicates → `GROUP BY + HAVING COUNT(*) > 1`**

---

# 21. THE 30-SECOND SQL PROBLEM SOLVER

Before writing SQL, force yourself to answer these questions:

```text
1. WHAT?
   What exactly is being asked?

2. GRAIN?
   What does ONE output row represent?

3. TABLE?
   Which tables contain the required information?

4. JOIN?
   How are the tables connected?

5. COLUMNS?
   Which columns are required?

6. FILTER?
   Do I need WHERE or HAVING?

7. CALCULATION?
   Do I need SUM / AVG / COUNT / MIN / MAX?

8. GROUP OR WINDOW?
   Should I collapse rows or keep rows?

9. COMPARISON?
   Do I need a Subquery / CTE / EXISTS?

10. VALIDATE?
    Is the output grain correct?
    Are there duplicate rows?
    Does the result answer the actual question?
```

---

# 22. FULL EXAMPLE

## Problem

> Find the top 2 highest-selling products in each category.

### Step 1 — WHAT?

"Top 2"

→ Ranking required.

### Step 2 — GRAIN?

One row represents:

```text
Product + Category
```

### Step 3 — TABLE?

Suppose:

```text
Products
Sales
Categories
```

### Step 4 — JOIN?

Products and sales need to be connected.

```text
Products
   |
   JOIN
   |
Sales
```

### Step 5 — CALCULATION?

"Highest-selling"

→ `SUM(sales_amount)`

### Step 6 — GROUP?

We need sales per:

```text
Category + Product
```

Therefore:

```sql
GROUP BY category, product
```

### Step 7 — RANK?

"Top 2"

→ `ROW_NUMBER()` / `RANK()` / `DENSE_RANK()`

### Step 8 — Partition?

"Each category"

→

```sql
PARTITION BY category
```

### Function Chain

```text
JOIN
  ↓
GROUP BY
  ↓
SUM()
  ↓
WINDOW FUNCTION
  ↓
PARTITION BY
  ↓
ORDER BY
  ↓
TOP 2
```

---

# 23. FUNCTION IDENTIFICATION MATRIX

| Problem Pattern         | Primary SQL Functionality    |
| ----------------------- | ---------------------------- |
| Select records          | `SELECT`                     |
| Filter records          | `WHERE`                      |
| Remove duplicates       | `DISTINCT`                   |
| Combine tables          | `JOIN`                       |
| Aggregate records       | `GROUP BY`                   |
| Filter aggregate        | `HAVING`                     |
| Total                   | `SUM()`                      |
| Average                 | `AVG()`                      |
| Count                   | `COUNT()`                    |
| Highest                 | `MAX()`                      |
| Lowest                  | `MIN()`                      |
| Top N overall           | `ORDER BY + LIMIT/TOP`       |
| Top N per group         | `ROW_NUMBER/RANK/DENSE_RANK` |
| Ranking                 | Window functions             |
| Previous value          | `LAG()`                      |
| Next value              | `LEAD()`                     |
| Running total           | `SUM() OVER()`               |
| Percentage              | Aggregate + arithmetic       |
| First record            | `ROW_NUMBER()` / `MIN()`     |
| Latest record           | `ROW_NUMBER()` / `MAX()`     |
| Duplicate detection     | `GROUP BY + HAVING`          |
| Above average           | Subquery / CTE               |
| Matching existence      | `EXISTS`                     |
| Non-existence           | `NOT EXISTS`                 |
| Combine result sets     | `UNION` / `UNION ALL`        |
| Difference between sets | `EXCEPT`                     |
| Common records          | `INTERSECT`                  |
| Conditional logic       | `CASE`                       |
| Handle NULL             | `COALESCE()` / `IS NULL`     |
| Convert data type       | `CAST()` / `CONVERT()`       |
| Text manipulation       | String functions             |
| Date manipulation       | Date functions               |

---

# 24. THE MOST IMPORTANT SQL MINDSET

Do **not** think:

> "Which SQL function do I remember?"

Instead think:

> "What operation does the problem require?"

Then translate:

```text
Business Requirement
        ↓
SQL Operation
        ↓
SQL Function
```

For example:

```text
"Total sales per customer"
        ↓
Aggregation
        ↓
SUM()
        ↓
GROUP BY customer
```

Another:

```text
"Top 3 employees in each department"
        ↓
Ranking within groups
        ↓
Window Function
        ↓
ROW_NUMBER/RANK/DENSE_RANK
        ↓
PARTITION BY department
```

Another:

```text
"Customers who never ordered"
        ↓
Find non-matching records
        ↓
NOT EXISTS
        ↓
Correlated subquery
```

---

# 25. FINAL MASTER FORMULA

When solving **any SQL problem**, use this:

```text
                 READ THE QUESTION
                        ↓
                  IDENTIFY WHAT
                        ↓
                  IDENTIFY GRAIN
                        ↓
                  IDENTIFY TABLES
                        ↓
                  IDENTIFY JOINS
                        ↓
                  IDENTIFY FILTERS
                        ↓
                IDENTIFY CALCULATION
                        ↓
              GROUP BY or WINDOW?
                        ↓
              RANK / COMPARE / EXISTS?
                        ↓
                  WRITE SQL
                        ↓
                    VALIDATE
```

## 🏆 One-Line Formula

> **WHAT → GRAIN → TABLE → JOIN → FILTER → CALCULATE → GROUP/WINDOW → VALIDATE**

### If trainees master this sequence, they don't need to guess the SQL functionality.

They simply **translate the English problem statement into SQL operations**.
