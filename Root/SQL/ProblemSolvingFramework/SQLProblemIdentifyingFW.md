# SQL Problem-Solving Guide
## How to Identify Which SQL Functionality to Use

> **Core principle:** Don't start by writing SQL. First identify the **shape of the problem**.  
> Ask: **What is one output row? Am I collapsing rows or preserving them? Am I comparing rows? Do I need another table?**

---

# 1. The Golden Rule

Before writing SQL, ask these five questions:

| Question | What it tells you |
|---|---|
| What should one output row represent? | Output **grain** |
| Do I need to combine tables? | `JOIN` |
| Do I need to summarize multiple rows? | `GROUP BY` + aggregate |
| Do I need to compare a row with other rows? | Window function / subquery / self join |
| Do I need the result of one query to answer another? | Subquery / CTE |

---

# 2. First Identify the Grain

**Grain = what one row in the final result represents.**

Example:

> Find total sales for each customer.

One output row = **one customer**

Therefore:

```sql
SELECT customer_id, SUM(amount)
FROM orders
GROUP BY customer_id;
```

But:

> Show every order along with the customer's total sales.

One output row = **one order**.

Rows must be preserved:

```sql
SELECT
    order_id,
    customer_id,
    amount,
    SUM(amount) OVER (PARTITION BY customer_id) AS customer_total
FROM orders;
```

## Golden distinction

```text
GROUP BY
    ↓
collapses rows

WINDOW FUNCTION
    ↓
keeps rows
but calculates across related rows
```

> **GROUP BY = collapse**  
> **WINDOW = calculate without collapsing**

---

# 3. Master SQL Functionality Map

| Problem pattern | Primary functionality |
|---|---|
| Filter individual rows | `WHERE` |
| Filter groups | `HAVING` |
| Combine tables | `JOIN` |
| Match existence | `EXISTS` |
| Find absence | `NOT EXISTS` |
| Summarize data | `GROUP BY` + aggregate |
| Compare with an aggregate | Subquery / CTE / Window |
| Compare with previous row | `LAG()` |
| Compare with next row | `LEAD()` |
| Rank rows | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` |
| Running total | `SUM() OVER()` |
| Moving average | `AVG() OVER()` |
| Percentage of total | Window function |
| Top N per group | Window function |
| Find duplicate records | `GROUP BY` / Window |
| Find records without a match | `LEFT JOIN` / `NOT EXISTS` |
| Find customers who did something | `EXISTS` |
| Find customers who never did something | `NOT EXISTS` |
| Compare against average | Subquery / CTE / Window |
| Find first record | `MIN()` / `ROW_NUMBER()` |
| Find latest record | `MAX()` / `ROW_NUMBER()` |
| Consecutive records | `LAG()` + gaps/islands |
| Conditional calculation | `CASE WHEN` |
| Conditional counting | `CASE WHEN` + aggregate |
| Pivot-like output | Conditional aggregation |
| Multi-step logic | CTE |
| Reuse a calculated result | CTE / derived table |
| Row-specific lookup | Correlated subquery |
| Remove duplicates from result | `DISTINCT` |
| Combine result sets | `UNION` / `UNION ALL` |
| Hierarchical/recursive problem | Recursive CTE |

---

# 4. The SQL Decision Tree

```text
                         START
                           |
                           v
                 What is the question asking?
                           |
          +----------------+----------------+
          |                |                |
          v                v                v
       FILTER           COMBINE          CALCULATE
        ROWS             TABLES            VALUE
          |                |                |
       WHERE              JOIN       Aggregate / Window
                           |
                           v
                  Need multiple rows?
                     /          \
                   NO            YES
                   |              |
                Simple       What type?
              calculation         |
                          +-------+-------+
                          |       |       |
                          v       v       v
                        GROUP   WINDOW  SUBQUERY/
                         BY     FUNCTION   CTE
```

---

# 5. GROUP BY

Use `GROUP BY` when the question asks for:

- total per customer
- average per department
- count of orders per month
- maximum salary per department
- number of employees in each department
- sales by region
- revenue by product

### Example

> Find total sales for each customer.

```sql
SELECT
    customer_id,
    SUM(amount) AS total_sales
FROM orders
GROUP BY customer_id;
```

### Recognition rule

Words such as:

```text
for each
per
by
```

are often clues that `GROUP BY` may be required.

**But don't depend only on keywords. Always check the output grain.**

---

# 6. HAVING

Use `HAVING` to filter **groups after aggregation**.

> Find customers whose total spending exceeds 100,000.

```sql
SELECT
    customer_id,
    SUM(amount) AS total_sales
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 100000;
```

Remember:

```text
WHERE  → filters rows

HAVING → filters groups
```

---

# 7. JOIN

Use a `JOIN` when required information lives in another table.

Ask:

> **Do I need columns from another table?**

If yes, a `JOIN` is usually a candidate.

Example:

```sql
SELECT
    c.customer_name,
    o.amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;
```

Real-world problems frequently combine:

```text
JOIN
  +
GROUP BY
  +
WINDOW
```

Do not teach trainees that one question necessarily means one SQL functionality.

---

# 8. Aggregate vs Window Function

This is one of the most important distinctions.

| Requirement | Aggregate | Window |
|---|---:|---:|
| Total sales per customer | Yes | |
| Average salary per department | Yes | |
| Show employee + department average | | Yes |
| Rank employees | | Yes |
| Running total | | Yes |
| Top 3 per department | | Yes |
| Percentage of total | | Yes |
| Count rows per category | Yes | |
| Keep individual rows | | Yes |

### Mental model

```text
GROUP BY
    ↓
I want fewer rows.

WINDOW
    ↓
I want the same rows plus analytical information.
```

---

# 9. Subqueries

Use a subquery when:

> **The result of one query is needed by another query.**

Example:

> Find employees earning more than the company average.

First:

```sql
SELECT AVG(salary)
FROM employees;
```

Then compare:

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

### Mental pattern

```text
Calculate something
      ↓
Use that result
      ↓
Filter / compare
```

---

# 10. CTEs

A CTE is primarily a way to organize a multi-step query.

Example:

> Find departments whose average salary is greater than the company average.

```sql
WITH dept_avg AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
),
company_avg AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT *
FROM dept_avg
WHERE avg_salary > (
    SELECT avg_salary
    FROM company_avg
);
```

### Remember

```text
Subquery → technique for nesting logic

CTE → technique for organizing multi-step logic
```

The same logical problem can often be solved with either.

---

# 11. Window Functions

Look for concepts such as:

- rank
- top N
- previous
- next
- running
- cumulative
- percentage
- contribution
- highest within each group
- compare with previous
- compare with department
- difference from average
- moving average
- latest row
- first row

These are strong window-function signals.

---

# 12. ROW_NUMBER, RANK and DENSE_RANK

Suppose salaries are:

```text
100000
90000
90000
80000
```

### ROW_NUMBER

```text
1
2
3
4
```

Every row gets a unique position.

Use when:

> You need a unique row position, often to select exactly one row.

### RANK

```text
1
2
2
4
```

Ties share rank and the next rank skips.

### DENSE_RANK

```text
1
2
2
3
```

Ties share rank but there are no gaps.

### Decision

```text
Need unique position?
    → ROW_NUMBER

Ties should share rank?
    → RANK or DENSE_RANK

Ties + gaps?
    → RANK

Ties + no gaps?
    → DENSE_RANK
```

---

# 13. Top N Per Group

Question:

> Find the top 3 employees by salary in each department.

Signal:

```text
TOP N
+
EACH GROUP
```

Use a ranking window:

```sql
ROW_NUMBER() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
)
```

Then filter:

```sql
WHERE rn <= 3
```

This is one of the most important reusable SQL patterns.

---

# 14. LAG and LEAD

Question:

> Compare an order with the previous order.

Use:

```sql
LAG()
```

Example:

```sql
SELECT
    order_date,
    amount,
    amount - LAG(amount) OVER (
        ORDER BY order_date
    ) AS difference
FROM orders;
```

Question:

> Find the next order date for each customer.

Use:

```sql
LEAD(order_date) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)
```

### Rule

```text
Previous → LAG

Next → LEAD
```

---

# 15. Running Totals

Signals:

```text
running
cumulative
so far
to date
```

Use:

```sql
SUM(amount) OVER (
    ORDER BY order_date
)
```

Example result:

```text
Date       Sales    Running Total
Jan 1      100      100
Jan 2      200      300
Jan 3      150      450
```

---

# 16. Percentage of Total

Question:

> What percentage of total company sales does each product contribute?

This often requires:

```text
individual/group value
+
overall total
```

A window function is a natural solution.

```sql
SELECT
    product_id,
    SUM(amount) AS product_sales,
    SUM(amount) * 100.0 /
        SUM(SUM(amount)) OVER() AS percentage
FROM sales
GROUP BY product_id;
```

Mental model:

```text
Need individual value
+
Need total
+
Need both in the same result
        ↓
Window function
```

---

# 17. Correlated Subqueries

Use a correlated subquery when:

> **The inner query depends on the current row of the outer query.**

Example:

> Find employees whose salary is greater than the average salary of their own department.

```sql
SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
```

The correlation is:

```sql
e2.department_id = e.department_id
```

The inner query needs information from the current outer row.

### Mental model

```text
Outer row
    ↓
Ask a question specifically about THIS row
    ↓
Return result
    ↓
Compare
```

---

# 18. Correlated Subquery vs Window Function

Same problem:

> Employees earning more than their department average.

### Correlated subquery

```sql
SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
```

### Window function

```sql
SELECT *
FROM (
    SELECT
        e.*,
        AVG(salary) OVER (
            PARTITION BY department_id
        ) AS dept_avg
    FROM employees e
) x
WHERE salary > dept_avg;
```

Think:

```text
Correlated subquery:
"For THIS employee, calculate the department average."

Window:
"Put the department average alongside every employee."
```

Both are valid approaches.

---

# 19. EXISTS

Question:

> Find customers who have placed at least one order.

If you only need to know whether a related row exists:

```sql
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

### Rule

```text
Need columns from another table?
    → JOIN

Only need to know whether a matching record exists?
    → EXISTS
```

---

# 20. NOT EXISTS

Signals:

```text
never
without
doesn't have
no matching record
```

Example:

> Find customers who have never placed an order.

```sql
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

---

# 21. LEFT JOIN + IS NULL

The same "no match" requirement can often be solved with:

```sql
SELECT c.*
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;
```

Mental translation:

```text
Need records from A
that don't have B
    ↓
LEFT JOIN + IS NULL

Need to test whether B exists
    ↓
NOT EXISTS
```

---

# 22. CASE WHEN

Use `CASE` for conditional business logic.

Signals:

```text
if
when
otherwise
classify
categorize
bucket
flag
```

Example:

```sql
CASE
    WHEN total_sales >= 100000 THEN 'Premium'
    WHEN total_sales >= 50000 THEN 'Gold'
    ELSE 'Standard'
END
```

---

# 23. Conditional Aggregation

Question:

> Count male and female customers separately for each city.

Use `CASE` inside an aggregate:

```sql
SELECT
    city,
    SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM customers
GROUP BY city;
```

Signal:

```text
Count / sum something
based on different conditions
    ↓
Conditional aggregation
```

---

# 24. DISTINCT

Use `DISTINCT` when the requirement is genuinely:

> Give me unique values or unique combinations.

Example:

```sql
SELECT DISTINCT city
FROM customers;
```

### Important warning

Do not use `DISTINCT` to hide duplicates caused by an incorrect `JOIN`.

If a join unexpectedly creates duplicates, investigate the table relationship.

---

# 25. UNION vs UNION ALL

Use these when combining result sets.

```text
UNION
    ↓
Combine + remove duplicates

UNION ALL
    ↓
Combine everything
```

Usually use `UNION ALL` when duplicate removal is not required.

---

# 26. Date Problem Recognition

| Question wording | Likely functionality |
|---|---|
| by month | `GROUP BY` date expression |
| year-over-year | `LAG()` |
| previous month | `LAG()` |
| next month | `LEAD()` |
| monthly total | `GROUP BY` |
| running monthly sales | `SUM() OVER()` |
| last 7 days | Date filter / window frame |
| first purchase | `MIN()` / `ROW_NUMBER()` |
| latest purchase | `MAX()` / `ROW_NUMBER()` |
| days between purchases | `LAG()` + date difference |
| consecutive days | `LAG()` / gaps and islands |
| month with highest sales | Aggregate + ranking/subquery |

---

# 27. First / Last / Latest

Important distinction:

### Need only the date?

```sql
MIN(order_date)
```

or:

```sql
MAX(order_date)
```

### Need the complete record?

Use ranking:

```sql
ROW_NUMBER() OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)
```

Then:

```sql
WHERE rn = 1
```

### Rule

```text
Need a VALUE?
    → Aggregate

Need the ACTUAL ROW?
    → Ranking / ordering
```

---

# 28. Value vs Row Rule

This is one of the best diagnostic questions.

### Need a value

```text
highest salary
average salary
total sales
minimum price
```

Think:

```text
Aggregate
```

### Need the actual record

```text
employee earning highest salary
customer's latest order
product with highest sales
```

Think:

```text
Ranking / ordering
```

---

# 29. JOIN vs SUBQUERY

Example:

> Display customer name and total order amount.

You may use:

```text
JOIN
+
GROUP BY
```

But:

> Find customers whose total order amount exceeds 50,000.

The logical structure is:

```text
Calculate customer total
        ↓
Filter based on total
```

A CTE is often clear:

```sql
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(amount) AS total_amount
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    cs.total_amount
FROM customers c
JOIN customer_sales cs
    ON c.customer_id = cs.customer_id
WHERE cs.total_amount > 50000;
```

---

# 30. Ten Major SQL Problem Types

Teach trainees to classify questions into these categories.

## Type 1 — FILTER

> Which records satisfy a condition?

Use:

```sql
WHERE
```

---

## Type 2 — AGGREGATE

> What is the total/count/average/max/min per group?

Use:

```sql
GROUP BY
```

---

## Type 3 — JOIN

> I need information from another table.

Use:

```sql
JOIN
```

---

## Type 4 — EXISTENCE

> Does another record exist?

Use:

```sql
EXISTS
NOT EXISTS
```

---

## Type 5 — COMPARISON

> Compare something against another calculated value.

Use:

```text
Subquery
CTE
Window function
```

---

## Type 6 — RANKING

> Who is first/top/bottom/Nth?

Use:

```text
ROW_NUMBER
RANK
DENSE_RANK
```

---

## Type 7 — SEQUENCE

> What happened before/after?

Use:

```text
LAG
LEAD
```

---

## Type 8 — RUNNING / MOVING

> What is the cumulative or rolling value?

Use:

```text
SUM OVER
AVG OVER
window frame
```

---

## Type 9 — CLASSIFICATION

> Put records into categories.

Use:

```text
CASE WHEN
```

---

## Type 10 — MULTI-STAGE

> I need several logical transformations.

Use:

```text
CTE
```

---

# 31. Keyword → Functionality Cheat Sheet

| If the question says... | Think... |
|---|---|
| each | `GROUP BY` / `PARTITION BY` |
| per | `GROUP BY` |
| total | `SUM()` |
| average | `AVG()` |
| number/count | `COUNT()` |
| highest | `MAX()` / ranking |
| lowest | `MIN()` / ranking |
| top | ranking |
| bottom | ranking |
| first | `ROW_NUMBER()` / `MIN()` |
| latest | `ROW_NUMBER()` / `MAX()` |
| second | `ROW_NUMBER()` |
| previous | `LAG()` |
| next | `LEAD()` |
| running | window |
| cumulative | window |
| moving | window |
| percentage | window |
| contribution | window |
| compare | subquery / CTE / window |
| above average | subquery / window |
| below average | subquery / window |
| exists | `EXISTS` |
| never | `NOT EXISTS` |
| without | `NOT EXISTS` / `LEFT JOIN` |
| duplicate | `GROUP BY` / window |
| unique | `DISTINCT` |
| classify | `CASE` |
| conditionally count | `CASE` + aggregate |
| combine results | `UNION` |
| previous record | `LAG()` |
| consecutive | `LAG()` |
| hierarchy | recursive CTE |
| multiple stages | CTE |

> **Important:** Keywords are clues, not automatic answers.

---

# 32. Example: Top 2 Highest-Spending Customers in Each City

Question:

> Find the top 2 highest-spending customers in each city.

### Step 1 — Output grain

One row = one customer.

### Step 2 — Calculate spending

Need:

```text
SUM(amount)
```

### Step 3 — Spending per customer

Need:

```text
GROUP BY customer
```

### Step 4 — Top 2 within each city

Need ranking:

```text
ROW_NUMBER()
PARTITION BY city
ORDER BY total_sales DESC
```

### Solution

```sql
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        SUM(o.amount) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.city
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY total_sales DESC
        ) AS rn
    FROM customer_sales
)
SELECT *
FROM ranked
WHERE rn <= 2;
```

### Thinking chain

```text
Sales
 ↓
GROUP BY customer
 ↓
Need top 2
 ↓
Ranking
 ↓
Ranking within city
 ↓
PARTITION BY city
```

---

# 33. Example: Salary Above Department Average

Question:

> Find employees whose salary is higher than the average salary of their department.

Translate:

```text
Employee
   ↓
Department average
   ↓
Compare employee salary
```

A window solution:

```sql
SELECT *
FROM (
    SELECT
        e.*,
        AVG(salary) OVER (
            PARTITION BY department_id
        ) AS dept_avg
    FROM employees e
) x
WHERE salary > dept_avg;
```

Why?

Because we need:

```text
employee row
+
department average
```

at the same time.

---

# 34. Example: Customers Who Purchased in January but Not February

Translate:

```text
Customer exists in January
AND
customer does NOT exist in February
```

This suggests:

```text
EXISTS
+
NOT EXISTS
```

Example:

```sql
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND MONTH(o.order_date) = 1
)
AND NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND MONTH(o.order_date) = 2
);
```

---

# 35. Example: Second Order Within 30 Days

Question:

> Find customers whose second order occurred within 30 days of their first order.

Recognize:

```text
first order
+
second order
+
time difference
```

This is primarily an **ordered-event / sequence problem**, not a simple `GROUP BY`.

Possible tools:

```text
ROW_NUMBER()
LAG()
LEAD()
date difference
```

The important skill is recognizing the problem shape before choosing syntax.

---

# 36. Don't Teach "One Question = One Function"

Real SQL questions commonly require combinations.

Examples:

### Top 3 products in each category

```text
JOIN
+
GROUP BY
+
SUM
+
WINDOW RANKING
+
FILTER
```

### Customer count by region and customer type

```text
GROUP BY
+
CASE
+
COUNT
```

### Employee above department average

```text
WINDOW
+
FILTER
```

### Customers who never purchased

```text
NOT EXISTS
```

### Complex analytical report

```text
CTE
+
JOIN
+
GROUP BY
+
WINDOW
+
CASE
```

---

# 37. The SQL LEGO Model

Think of SQL functionalities as Lego blocks.

The business question determines which blocks need to be assembled.

### Example

> Top 3 customers by revenue in each region.

```text
JOIN
  ↓
GROUP BY
  ↓
SUM
  ↓
RANK
  ↓
PARTITION BY region
  ↓
FILTER
```

### Example

> Customers who never purchased.

```text
CUSTOMERS
   ↓
NOT EXISTS
   ↓
RESULT
```

### Example

> Employee earning above department average.

```text
EMPLOYEES
   ↓
WINDOW AVG
   ↓
COMPARE
   ↓
FILTER
```

---

# 38. The 30-Second SQL Diagnosis

Train trainees to answer these questions before writing SQL.

### 1. What does one row represent?

```text
Output grain = __________
```

### 2. Do I need another table?

```text
JOIN?
YES / NO
```

### 3. Am I collapsing rows?

```text
YES → GROUP BY
NO  → consider WINDOW
```

### 4. Am I comparing against a calculated result?

```text
SUBQUERY / CTE / WINDOW
```

### 5. Am I ranking?

```text
ROW_NUMBER / RANK / DENSE_RANK
```

### 6. Am I looking backward or forward?

```text
LAG / LEAD
```

### 7. Am I calculating cumulative/moving values?

```text
SUM OVER / AVG OVER
```

### 8. Am I checking existence?

```text
EXISTS / NOT EXISTS
```

### 9. Am I applying business categories?

```text
CASE WHEN
```

### 10. Is the problem multi-step?

```text
CTE
```

---

# 39. Trainee Question Analysis Worksheet

Before writing SQL, make trainees complete this:

```text
SQL QUESTION ANALYSIS
=====================

Question:
____________________________________________

1. What is the output grain?
   __________________________________________

2. Which tables are required?
   __________________________________________

3. Do I need JOIN?
   YES / NO

4. Do I need aggregation?
   YES / NO

5. If aggregation, what is the GROUP BY?
   __________________________________________

6. Do I need to preserve individual rows?
   YES / NO

7. Is there a comparison?
   YES / NO

8. Is there ranking?
   YES / NO

9. Is there previous/next logic?
   YES / NO

10. Is there existence logic?
    YES / NO

11. Is there conditional logic?
    YES / NO

12. Is this a multi-step problem?
    YES / NO

13. Primary SQL functionality:
    __________________________________________

14. Secondary SQL functionality:
    __________________________________________

15. Why did I choose it?
    __________________________________________
```

This forces **reasoning before syntax**.

---

# 40. Recommended Training Method

Do not give trainees only:

> "Practice 50 window-function questions."

That teaches syntax recognition rather than problem solving.

Instead, mix the questions:

```text
Question 1  → GROUP BY
Question 2  → JOIN
Question 3  → WINDOW
Question 4  → EXISTS
Question 5  → SUBQUERY
Question 6  → JOIN + GROUP BY
Question 7  → GROUP BY + WINDOW
Question 8  → CASE + GROUP BY
Question 9  → LAG
Question 10 → NOT EXISTS
```

**Do not tell them the topic.**

Ask them to identify the functionality first.

---

# 41. The Best Classroom Exercise

For every question, require trainees to submit:

```text
1. Output grain
2. Required tables
3. Required JOINs
4. Whether rows are collapsed
5. Whether rows are compared
6. Whether ranking is required
7. Whether previous/next logic is required
8. Whether existence is being tested
9. Whether conditional logic is required
10. Primary functionality
11. Secondary functionality
12. Only then: SQL query
```

This changes the learning process from:

> "I remember a query."

to:

> "I know how to derive the query."

---

# 42. The Most Important Comparison Matrix

| Question | Use |
|---|---|
| Which rows? | `WHERE` |
| Which groups? | `HAVING` |
| Information from another table? | `JOIN` |
| What is the total? | `SUM()` |
| What is the average? | `AVG()` |
| How many? | `COUNT()` |
| Maximum/minimum value? | `MAX()` / `MIN()` |
| One result per group? | `GROUP BY` |
| Group calculation while keeping rows? | Window |
| Who is #1/#2/#3? | Ranking |
| Previous row? | `LAG()` |
| Next row? | `LEAD()` |
| Running value? | Window |
| Moving value? | Window frame |
| Percentage of total? | Window |
| Compare against aggregate? | Subquery / CTE / Window |
| Does a related record exist? | `EXISTS` |
| Does no related record exist? | `NOT EXISTS` |
| Categorize data? | `CASE` |
| Count based on conditions? | Conditional aggregation |
| Combine query results? | `UNION` |
| Unique results? | `DISTINCT` |
| Complex multi-step logic? | CTE |
| Actual row associated with min/max? | Ranking |

---

# 43. SQL Problem-Solving Ladder

Teach trainees progressively.

```text
LEVEL 1
SELECT + WHERE
    ↓
Filtering

LEVEL 2
GROUP BY + HAVING
    ↓
Aggregation

LEVEL 3
JOIN
    ↓
Relationships

LEVEL 4
CASE
    ↓
Business logic

LEVEL 5
SUBQUERY
    ↓
Comparison / nested logic

LEVEL 6
CTE
    ↓
Multi-step logic

LEVEL 7
WINDOW FUNCTIONS
    ↓
Analytical calculations

LEVEL 8
LAG / LEAD / RANKING
    ↓
Advanced analytics

LEVEL 9
GAPS & ISLANDS / RECURSIVE CTE
    ↓
Complex analytical patterns
```

---

# 44. The Ultimate Mental Model

```text
                         SQL QUESTION
                              |
                              v
                     DEFINE OUTPUT GRAIN
                              |
                              v
                    DO I NEED OTHER TABLES?
                       /              \
                     YES               NO
                      |                 |
                    JOIN                |
                      |                 |
                      +--------+--------+
                               |
                               v
                      AM I COLLAPSING ROWS?
                         /            \
                       YES             NO
                        |               |
                    GROUP BY       KEEP ROWS?
                                        |
                                        v
                                    WINDOW?
                                        |
                       +----------------+----------------+
                       |                |                |
                       v                v                v
                     RANK           PREVIOUS          RUNNING
                  ROW_NUMBER        LAG/LEAD          SUM/AVG
                       |
                       v
                  COMPARISON?
                       |
              SUBQUERY / CTE / WINDOW
                       |
                       v
                  EXISTENCE?
                   /         \
                 YES          NO
                  |            |
          EXISTS / NOT EXISTS  |
                               v
                         CONDITIONAL?
                               |
                               v
                           CASE WHEN
                               |
                               v
                           WRITE SQL
                               |
                               v
                         TEST THE GRAIN
```

---

# 45. The One-Sentence Rules

Memorize these:

> **WHERE** → Which rows?

> **GROUP BY** → One result per group.

> **HAVING** → Which groups?

> **JOIN** → Bring related data together.

> **CASE** → If/then business logic.

> **SUBQUERY** → Use one query's result inside another.

> **CTE** → Break complex logic into logical steps.

> **EXISTS** → Does a related record exist?

> **NOT EXISTS** → Does a related record not exist?

> **WINDOW** → Calculate across related rows without losing them.

> **ROW_NUMBER** → Give every row a unique position.

> **RANK** → Rank with ties and gaps.

> **DENSE_RANK** → Rank with ties without gaps.

> **LAG** → Look backward.

> **LEAD** → Look forward.

> **SUM OVER** → Running/partitioned totals.

> **AVG OVER** → Compare rows with group averages.

---

# 46. The Real Skill to Develop

Trainees should not think:

> "This is a window-function question."

They should think:

> **What is the grain?**

Then:

> **Do I need to collapse rows or preserve them?**

Then:

> **Am I comparing rows, ranking them, or looking across time?**

Then:

> **Do I need another table?**

Then:

> **Is this one step or multiple steps?**

Once they develop this sequence, selecting SQL functionality becomes much more intuitive.

---

# 47. Final Cheat Sheet

```text
FILTER ROWS
    → WHERE

FILTER GROUPS
    → HAVING

COMBINE TABLES
    → JOIN

SUM / COUNT / AVG PER GROUP
    → GROUP BY

CONDITIONAL BUSINESS LOGIC
    → CASE

CONDITIONAL COUNT / SUM
    → CASE + GROUP BY

COMPARE WITH A CALCULATED VALUE
    → SUBQUERY / CTE / WINDOW

CURRENT ROW + GROUP CALCULATION
    → WINDOW FUNCTION

TOP N PER GROUP
    → ROW_NUMBER / RANK / DENSE_RANK

PREVIOUS ROW
    → LAG

NEXT ROW
    → LEAD

RUNNING TOTAL
    → SUM() OVER()

MOVING AVERAGE
    → AVG() OVER() + WINDOW FRAME

PERCENTAGE OF TOTAL
    → WINDOW FUNCTION

DOES RELATED RECORD EXIST?
    → EXISTS

DOES RELATED RECORD NOT EXIST?
    → NOT EXISTS

NO MATCHING RECORD
    → LEFT JOIN + IS NULL

UNIQUE VALUES
    → DISTINCT

COMBINE RESULT SETS
    → UNION / UNION ALL

COMPLEX MULTI-STEP QUERY
    → CTE

FIRST/LATEST ACTUAL ROW
    → ROW_NUMBER()

FIRST/LATEST VALUE ONLY
    → MIN() / MAX()

CONSECUTIVE EVENTS
    → LAG() + GAPS & ISLANDS

HIERARCHICAL DATA
    → RECURSIVE CTE
```

---

# Final Teaching Principle

The goal is **not** to make trainees memorize:

```text
Question type → Function
```

The goal is to make them ask:

```text
What is the business question?
        ↓
What should one row represent?
        ↓
Which tables contain the required information?
        ↓
Do I collapse rows or preserve them?
        ↓
Do I need comparison/ranking/sequence/existence logic?
        ↓
Is the problem one-step or multi-step?
        ↓
Choose the SQL building blocks
        ↓
Write the query
        ↓
Validate the output grain
```

> **SQL expertise is not knowing more functions.  
> SQL expertise is knowing which functionality to combine to transform the business question into the required result.**
