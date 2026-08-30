# 🏆 Pandas vs SQL — Data Engineering Competition Course

## Course Mission

> **One Business Problem. Two Technologies. One Winner.**

In this course, you will solve the **same business problem twice**:

1. Understand the business question
2. Identify the required data
3. Break the problem into smaller steps
4. Solve it using **SQL**
5. Solve the same problem using **Pandas**
6. Compare both solutions
7. Debug incorrect solutions
8. Optimize the solution
9. Decide which technology is more suitable for the scenario

---

# 1. Course Structure

| Day | Theme | SQL | Pandas | Competition |
|---|---|---|---|---|
| 1 | Think Like a Data Engineer | SELECT | DataFrame | SQL vs Pandas Basics |
| 2 | Filtering | WHERE | Boolean Filtering | Filter Battle |
| 3 | Transformation | CASE / Expressions | `assign()` / Vectorization | Transformation Battle |
| 4 | Aggregation | GROUP BY | `groupby()` | Aggregation Battle |
| 5 | Joins | JOIN | `merge()` | Join Battle |
| 6 | Advanced Analytics | Window Functions | `transform()` / `rank()` | Analytics Battle |
| 7 | Dates & Time | Date Functions | datetime | Time Battle |
| 8 | Data Cleaning | SQL Cleansing | Pandas Cleansing | Cleaning Battle |
| 9 | Performance & Debugging | Query Optimization | Pandas Optimization | Performance Battle |
| 10 | Capstone | Complete SQL Pipeline | Complete Pandas Pipeline | 🏆 Final Championship |

---

# 2. The Data Engineering Problem-Solving Framework

Use this framework whenever you receive a data problem.

```text
                    BUSINESS QUESTION
                           ↓
                 WHAT DATA DO I NEED?
                           ↓
                WHAT TABLES / DATASETS?
                           ↓
                  WHAT COLUMNS?
                           ↓
                  WHAT TRANSFORMATION?
                           ↓
                     WHAT FILTER?
                           ↓
                    WHAT JOIN?
                           ↓
                   WHAT GROUPING?
                           ↓
                   WHAT CALCULATION?
                           ↓
                    WHAT SORTING?
                           ↓
                    WHAT OUTPUT?
                           ↓
              ┌────────────┴────────────┐
              ↓                         ↓
             SQL                     PANDAS
              ↓                         ↓
          VALIDATE ←──── RESULTS ────→ VALIDATE
              ↓                         ↓
              └────────────┬────────────┘
                           ↓
                    COMPARE SOLUTIONS
                           ↓
                   PRODUCTION DECISION
```

### Golden Rule

> **Don't start by thinking "How do I write this in Pandas?"**
>
> First ask:
>
> **"What is the business problem?"**

Then translate the business logic into SQL and Pandas.

---

# 3. SQL → Pandas Translation Map

| Business Requirement | SQL | Pandas |
|---|---|---|
| Select columns | `SELECT` | `df[['col1','col2']]` |
| Rename | `AS` | `.rename()` |
| Filter rows | `WHERE` | Boolean filtering |
| Multiple filters | `AND / OR` | `& / \|` |
| Sort | `ORDER BY` | `.sort_values()` |
| Top N | `LIMIT` | `.head()` |
| Remove duplicates | `DISTINCT` | `.drop_duplicates()` |
| Create column | Expression / `CASE` | `.assign()` |
| Conditional logic | `CASE WHEN` | `np.where()` / `np.select()` |
| Aggregate | `SUM()` | `.sum()` |
| Average | `AVG()` | `.mean()` |
| Count | `COUNT()` | `.count()` / `.size()` |
| Group | `GROUP BY` | `.groupby()` |
| Having | `HAVING` | Aggregate → filter |
| Inner Join | `INNER JOIN` | `merge(..., how='inner')` |
| Left Join | `LEFT JOIN` | `merge(..., how='left')` |
| Right Join | `RIGHT JOIN` | `merge(..., how='right')` |
| Full Join | `FULL OUTER JOIN` | `merge(..., how='outer')` |
| Union | `UNION` | `concat()` + dedupe |
| Window | `OVER()` | `groupby()` + `transform()` / `rank()` |
| Lag | `LAG()` | `.shift()` |
| Lead | `LEAD()` | `.shift(-1)` |
| Rank | `RANK()` | `.rank()` |
| Null check | `IS NULL` | `.isna()` |
| Fill null | `COALESCE()` | `.fillna()` |
| String manipulation | SQL string functions | `.str` |
| Date extraction | `YEAR()`, `MONTH()` | `.dt.year`, `.dt.month` |
| Pivot | `PIVOT` | `.pivot_table()` |

---

# 4. DAY 1 — SELECT vs DataFrame

## Concept

### SQL

```sql
SELECT customer_id,
       customer_name,
       city
FROM customers;
```

### Pandas

```python
df[['customer_id', 'customer_name', 'city']]
```

---

## Exercise 1 — Basic Selection

### Business Question

> Display customer ID, customer name and city for all customers.

### Problem Breakdown

| Question | Answer |
|---|---|
| Business Question | Display customer information |
| Data Needed | Customers |
| Columns | customer_id, customer_name, city |
| Transformation | Select columns |
| Filter | None |
| Grouping | None |
| Calculation | None |
| Output | Customer details |

### Challenge

Write:

- SQL solution
- Pandas solution

---

# 5. DAY 2 — WHERE vs Filtering

## Business Question

> Find all customers from Mumbai.

### SQL

```sql
SELECT *
FROM customers
WHERE city = 'Mumbai';
```

### Pandas

```python
df[df['city'] == 'Mumbai']
```

---

## Exercises

### Exercise 2

Find customers where:

```text
city = Mumbai
```

### Exercise 3

Find customers where:

```text
age > 30
```

### Exercise 4

Find customers where:

```text
age > 30
AND
city = Mumbai
```

### Exercise 5

Find customers where:

```text
city IN ('Mumbai', 'Pune', 'Bangalore')
```

### Exercise 6 — Challenge

Find customers who:

```text
age between 25 and 40
AND
city is Mumbai or Pune
```

---

# 6. DAY 3 — CASE WHEN vs Conditional Transformation

## Business Question

> Categorize customers based on spending.

### Rules

```text
>= 100000 → Premium
>= 50000  → Gold
>= 25000  → Silver
< 25000   → Regular
```

### SQL

```sql
CASE
    WHEN total_spend >= 100000 THEN 'Premium'
    WHEN total_spend >= 50000 THEN 'Gold'
    WHEN total_spend >= 25000 THEN 'Silver'
    ELSE 'Regular'
END
```

### Pandas

```python
conditions = [
    df['total_spend'] >= 100000,
    df['total_spend'] >= 50000,
    df['total_spend'] >= 25000
]

choices = [
    'Premium',
    'Gold',
    'Silver'
]

df['customer_segment'] = np.select(
    conditions,
    choices,
    default='Regular'
)
```

---

## Transformation Challenge

You are given an incorrect Pandas implementation.

Complete the following:

1. Find the bug.
2. Explain why it is wrong.
3. Correct it.
4. Write the SQL equivalent.
5. Test the output.

---

# 7. DAY 4 — GROUP BY vs GROUPBY

## Business Question

> Calculate total sales by city.

### SQL

```sql
SELECT city,
       SUM(sales) AS total_sales
FROM sales
GROUP BY city;
```

### Pandas

```python
df.groupby('city')['sales'].sum()
```

Or:

```python
df.groupby('city', as_index=False).agg(
    total_sales=('sales', 'sum')
)
```

---

## Exercises

### Exercise 7

Calculate total sales by:

```text
city
```

### Exercise 8

Calculate average order value by:

```text
city
```

### Exercise 9

Calculate number of orders by:

```text
customer
```

### Exercise 10

Calculate total revenue by:

```text
city + product_category
```

### Exercise 11 — HAVING Challenge

Find cities where:

```text
total sales > 1,000,000
```

### SQL

```sql
SELECT city,
       SUM(sales) AS total_sales
FROM sales
GROUP BY city
HAVING SUM(sales) > 1000000;
```

### Pandas

```python
result = (
    df.groupby('city', as_index=False)
      .agg(total_sales=('sales', 'sum'))
)

result[result['total_sales'] > 1000000]
```

---

# 8. DAY 5 — JOIN vs MERGE

## Business Question

> Find customer name, product name and order amount for every order.

### SQL

```sql
SELECT
    c.customer_name,
    p.product_name,
    o.order_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id;
```

### Pandas

```python
result = orders.merge(
    customers,
    on='customer_id',
    how='inner'
)

result = result.merge(
    products,
    on='product_id',
    how='inner'
)
```

---

# Join Battle

## Exercise 12

Perform an:

```text
INNER JOIN
```

between customers and orders.

---

## Exercise 13

Perform a:

```text
LEFT JOIN
```

between customers and orders.

---

## Exercise 14

Find customers who never placed an order.

### SQL

```sql
SELECT c.customer_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;
```

### Pandas

```python
result = customers.merge(
    orders,
    on='customer_id',
    how='left',
    indicator=True
)

result[result['_merge'] == 'left_only']
```

---

## Exercise 15 — Many-to-Many Trap

You are given duplicate keys in both datasets.

Answer:

1. Why did the number of rows suddenly increase?
2. What type of relationship exists?
3. How can you detect it?
4. How can you prevent an incorrect merge?
5. How would you solve it in SQL?
6. How would you solve it in Pandas?

---

# 9. DAY 6 — Window Functions vs Pandas Analytics

## Business Question

> Find the top 3 products by sales within every category.

### SQL

```sql
WITH ranked AS (
    SELECT
        category,
        product,
        sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY sales DESC
        ) AS rnk
    FROM product_sales
)

SELECT *
FROM ranked
WHERE rnk <= 3;
```

### Pandas

```python
df['rank'] = (
    df.groupby('category')['sales']
      .rank(method='dense', ascending=False)
)

result = df[df['rank'] <= 3]
```

---

## Window Exercises

### Exercise 16

Rank employees by salary within department.

### Exercise 17

Find the top 3 products per category.

### Exercise 18

Calculate cumulative customer spend.

### Exercise 19

Find the previous order for every customer.

### SQL

```sql
LAG(order_amount)
OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)
```

### Pandas

```python
df['previous_order'] = (
    df.sort_values('order_date')
      .groupby('customer_id')['order_amount']
      .shift(1)
)
```

### Exercise 20

Calculate:

```text
current order - previous order
```

---

# 10. DAY 7 — Date & Time Battle

| Requirement | SQL | Pandas |
|---|---|---|
| Year | `YEAR(date)` | `df['date'].dt.year` |
| Month | `MONTH(date)` | `df['date'].dt.month` |
| Day | `DAY(date)` | `df['date'].dt.day` |
| Difference | `DATEDIFF()` | datetime subtraction |
| Current date | `CURRENT_DATE` | `pd.Timestamp.today()` |

---

## Exercises

### Exercise 21

Calculate monthly sales.

### Exercise 22

Calculate yearly sales.

### Exercise 23

Find customers whose last order was more than 90 days ago.

### Exercise 24

Calculate month-over-month revenue growth.

### Exercise 25 — Advanced

Find the longest gap between two orders for every customer.

---

# 11. DAY 8 — Data Cleaning Battle

The dataset contains:

```text
NULL values
duplicates
incorrect dates
spaces
mixed case
invalid categories
negative amounts
```

---

## SQL vs Pandas

| Problem | SQL | Pandas |
|---|---|---|
| Null detection | `IS NULL` | `.isna()` |
| Fill null | `COALESCE()` | `.fillna()` |
| Remove duplicates | `DISTINCT` | `.drop_duplicates()` |
| Trim | `TRIM()` | `.str.strip()` |
| Uppercase | `UPPER()` | `.str.upper()` |
| Lowercase | `LOWER()` | `.str.lower()` |
| Replace | `REPLACE()` | `.str.replace()` |
| Convert date | `CAST()` | `pd.to_datetime()` |

---

## Exercises

### Exercise 26

Remove duplicate customers.

### Exercise 27

Standardize city names.

Input:

```text
mumbai
Mumbai
MUMBAI
 Mumbai
```

Expected:

```text
Mumbai
```

### Exercise 28

Handle missing sales.

### Exercise 29

Identify invalid transactions.

### Exercise 30

Build a complete data-cleansing pipeline.

---

# 12. DAY 9 — Performance Battle

## Scenario

You have:

```text
500 million transactions
```

### Question

> Should you load everything into Pandas?

Think about:

```text
WHERE IS THE DATA?
        ↓
HOW MUCH DATA?
        ↓
WHERE SHOULD COMPUTATION HAPPEN?
        ↓
DATABASE?
PANDAS?
BOTH?
```

---

## Optimization Challenge

### Initial Solution

```python
df = pd.read_csv('transactions.csv')

df = df[df['country'] == 'India']

df = df[['customer_id', 'amount']]
```

### Challenge

Can you reduce memory usage?

One possible improvement:

```python
df = pd.read_csv(
    'transactions.csv',
    usecols=['customer_id', 'country', 'amount']
)

df = df[df['country'] == 'India']
```

---

## Production Pattern

```text
SQL
 ↓
Filter / Aggregate at Source
 ↓
Smaller Dataset
 ↓
Pandas
 ↓
Analysis / ML / Validation
```

---

# 13. DAY 10 — 🏆 FINAL CHAMPIONSHIP

# Retail Data Engineering Mission

You will work with four datasets.

---

## Dataset 1 — customers.csv

```text
customer_id
customer_name
city
state
signup_date
customer_segment
```

---

## Dataset 2 — products.csv

```text
product_id
product_name
category
subcategory
price
cost
```

---

## Dataset 3 — orders.csv

```text
order_id
customer_id
order_date
payment_method
order_status
```

---

## Dataset 4 — order_items.csv

```text
order_id
product_id
quantity
discount
```

---

# Final Business Requirement

> **The management wants a Retail Sales Intelligence Report showing customer performance, product performance, regional performance and monthly trends.**

---

# Required Analysis

## 1. Revenue

Calculate:

```text
Total Revenue
```

---

## 2. Profit

Calculate:

```text
Revenue - Cost
```

---

## 3. Customer Metrics

Calculate:

```text
Total Customers
Active Customers
Average Customer Spend
Top 10 Customers
```

---

## 4. Product Metrics

Calculate:

```text
Top 10 Products
Top Products by Category
Lowest Performing Products
```

---

## 5. Geography

Calculate:

```text
Revenue by City
Revenue by State
Top Performing State
```

---

## 6. Time

Calculate:

```text
Daily Revenue
Monthly Revenue
Yearly Revenue
Month-over-Month Growth
```

---

## 7. Customer Segmentation

Create:

```text
Premium
Gold
Silver
Regular
```

---

## 8. Ranking

Calculate:

```text
Top 3 Products per Category
Top 5 Customers per City
```

---

# 14. Competition Format

Each team receives the same business problem.

## Round 1 — SQL

**Time: 30 minutes**

Solve the assigned problem using SQL.

---

## Round 2 — Pandas

**Time: 30 minutes**

Solve the same problem using Pandas.

---

## Round 3 — Debugging

**Time: 15 minutes**

Identify and fix errors in provided SQL and Pandas solutions.

---

## Round 4 — Optimization

**Time: 15 minutes**

Improve the performance and readability of your solution.

---

## Round 5 — Explain

**Time: 10 minutes**

Explain:

- Your approach
- Your assumptions
- Your SQL solution
- Your Pandas solution
- Your validation
- Your optimization
- Your technology choice

---

# 15. Competition Scoring

| Category | Points |
|---|---:|
| Business understanding | 10 |
| Problem decomposition | 10 |
| SQL correctness | 15 |
| Pandas correctness | 15 |
| Data validation | 10 |
| Edge cases | 10 |
| Performance | 10 |
| Code quality | 10 |
| Explanation | 5 |
| Production decision | 5 |
| **TOTAL** | **100** |

---

# 16. Which One Wins?

The goal is **not** to memorize:

> "SQL is better than Pandas."

or:

> "Pandas is better than SQL."

The goal is to understand:

> **Which layer should perform this operation?**

| Situation | Preferred Approach |
|---|---|
| Database filtering | SQL |
| Large-scale aggregation | SQL |
| Joining huge tables | SQL |
| Data warehouse transformation | SQL |
| Interactive exploration | Pandas |
| Complex Python logic | Pandas |
| Statistical analysis | Pandas |
| Machine learning preparation | Pandas |
| Visualization preparation | Pandas |
| Data quality investigation | Pandas |
| Small/medium local datasets | Pandas |
| Production warehouse transformation | Usually SQL + orchestration |
| SQL result → analysis | SQL → Pandas |

---

# 17. The Golden Data Engineering Pattern

```text
                    BUSINESS QUESTION
                           ↓
                     DATA SOURCE
                           ↓
                  ┌───────────────┐
                  │   SQL LAYER   │
                  │               │
                  │ Filter        │
                  │ Join          │
                  │ Aggregate     │
                  │ Transform     │
                  └───────┬───────┘
                          ↓
                   OPTIMIZED DATA
                          ↓
                  ┌───────────────┐
                  │ PANDAS LAYER  │
                  │               │
                  │ Explore       │
                  │ Analyze       │
                  │ Validate      │
                  │ Transform     │
                  │ Model         │
                  └───────┬───────┘
                          ↓
                     INSIGHT
                          ↓
                    BUSINESS DECISION
```

---

# 18. Exercise Progression

Every topic follows this learning path:

```text
LEVEL 1
LEARN
   ↓
LEVEL 2
PRACTICE
   ↓
LEVEL 3
DEBUG
   ↓
LEVEL 4
CHALLENGE
   ↓
LEVEL 5
PRODUCTION SCENARIO
   ↓
LEVEL 6
SQL vs PANDAS COMPETITION
```

## Example — GROUP BY

```text
Learn
 ↓
Basic GROUP BY
 ↓
Practice
 ↓
Multiple Aggregations
 ↓
Debug
 ↓
Incorrect GROUP BY
 ↓
Challenge
 ↓
HAVING
 ↓
Production Scenario
 ↓
Sales KPI Pipeline
 ↓
Competition
 ↓
GROUP BY vs groupby()
```

---

# 19. Final Challenge

For every business problem, answer these questions before writing code:

```text
1. What is the BUSINESS QUESTION?

2. What DATA do I need?

3. What TABLES / DATASETS do I need?

4. What COLUMNS do I need?

5. What TRANSFORMATION is required?

6. What FILTER is required?

7. What JOIN is required?

8. What GROUPING is required?

9. What CALCULATION is required?

10. What SORTING is required?

11. What OUTPUT is expected?

12. Should I solve it using SQL, Pandas, or both?

13. How will I VALIDATE my result?

14. How can I OPTIMIZE the solution?
```

---

# 🏁 Final Mission

> **Think like a Data Engineer, not a syntax writer.**

The technology is only the tool.

The real skill is:

```text
BUSINESS PROBLEM
       ↓
DATA
       ↓
LOGIC
       ↓
TRANSFORMATION
       ↓
VALIDATION
       ↓
OPTIMIZATION
       ↓
BUSINESS RESULT
```

## 🏆 One Problem. Two Technologies. One Decision.

**SQL vs Pandas — Let the Competition Begin!**
