# NumPy vs SQL — Compare & Contrast Training Material

## 1. The Big Picture

Think about them this way:

| SQL | NumPy |
|---|---|
| Works primarily with tables | Works primarily with arrays |
| Data organized in rows & columns | Data organized in dimensions |
| `SELECT` | Array indexing/slicing |
| `WHERE` | Boolean masking |
| `GROUP BY` | Aggregation functions / grouping tools |
| `ORDER BY` | `np.sort()` |
| `JOIN` | Usually handled with Pandas, not NumPy |
| `SUM()` | `np.sum()` |
| `AVG()` | `np.mean()` |
| `MIN()` | `np.min()` |
| `MAX()` | `np.max()` |
| `COUNT()` | `np.count_nonzero()` / `.size` |
| `DISTINCT` | `np.unique()` |
| `CASE WHEN` | `np.where()` |
| `NULL` | `np.nan` |
| `UPDATE` | Array assignment |
| `INSERT` | Array construction / append |
| Table schema | Array `shape`, `dtype`, `ndim` |
| Column | Array slice / axis |
| Row | Array slice |
| Database table | NumPy `ndarray` |

### Fundamental Difference

**SQL asks:**

> What data do I want from the database?

**NumPy asks:**

> How do I efficiently manipulate numerical data stored in memory?

---

# 2. Start With the Same Dataset

Imagine this SQL table:

### `sales`

| sale_id | product | quantity | price | region |
|---:|---|---:|---:|---|
| 1 | Laptop | 2 | 80000 | South |
| 2 | Mouse | 5 | 1000 | South |
| 3 | Keyboard | 3 | 2000 | North |
| 4 | Laptop | 1 | 80000 | North |
| 5 | Mouse | 10 | 1000 | South |

SQL:

```sql
SELECT *
FROM sales;
```

In NumPy:

```python
import numpy as np

sales = np.array([
    [1, 80000, 2],
    [2, 1000, 5],
    [3, 2000, 3],
    [4, 80000, 1],
    [5, 1000, 10]
])
```

Here:

```text
Rows    → sales transactions
Columns → numerical attributes
```

> **Note:** The example NumPy array contains only numerical columns. Text columns such as `product` and `region` are better represented with structured arrays or, more commonly, Pandas DataFrames.

---

# 3. SQL Table vs NumPy Array

### SQL

```sql
SELECT *
FROM sales;
```

### NumPy

```python
sales
```

Check the dimensions:

```python
sales.shape
```

Output:

```text
(5, 3)
```

Meaning:

```text
5 rows
3 columns
```

SQL thinking:

```text
5 records × 3 numerical attributes
```

NumPy thinking:

```text
shape = (5, 3)
```

---

# 4. Understanding `shape`

One of the most important NumPy concepts is `shape`.

```python
sales.shape
```

Result:

```text
(5, 3)
```

Think:

```text
        columns
       ┌───────────┐
rows   │   DATA    │
       │           │
       └───────────┘
```

SQL:

```text
5 rows × 3 columns
```

NumPy:

```text
shape = (5, 3)
```

---

# 5. `SELECT` vs NumPy Indexing

SQL:

```sql
SELECT product, quantity
FROM sales;
```

NumPy:

```python
sales[:, [1, 2]]
```

General NumPy syntax:

```python
sales[rows, columns]
```

### All rows

```python
:
```

### Selected columns

```python
[1, 2]
```

So:

```python
sales[:, [1, 2]]
```

means:

> Give me all rows and columns 1 and 2.

### Important

NumPy uses **zero-based indexing**:

```text
Column 0 → first column
Column 1 → second column
Column 2 → third column
```

---

# 6. SQL `WHERE` vs NumPy Boolean Mask

This is one of the most important SQL → NumPy connections.

SQL:

```sql
SELECT *
FROM sales
WHERE quantity > 3;
```

NumPy:

```python
sales[sales[:, 2] > 3]
```

First:

```python
sales[:, 2]
```

gets the quantity column.

Then:

```python
sales[:, 2] > 3
```

creates a Boolean mask:

```text
False
True
False
False
True
```

NumPy then uses that mask to filter rows.

### Mental Model

```text
SQL

WHERE condition
       ↓
filter rows
```

```text
NumPy

array[condition]
       ↓
filter rows
```

---

# 7. Multiple Conditions

SQL:

```sql
SELECT *
FROM sales
WHERE quantity > 3
AND price < 5000;
```

NumPy:

```python
sales[
    (sales[:, 2] > 3) &
    (sales[:, 1] < 5000)
]
```

### SQL vs NumPy Boolean Operators

| SQL | NumPy |
|---|---|
| `AND` | `&` |
| `OR` | `|` |
| `NOT` | `~` |

In NumPy, put each condition inside parentheses:

```python
(condition1) & (condition2)
```

---

# 8. SQL `DISTINCT` vs `np.unique()`

SQL:

```sql
SELECT DISTINCT price
FROM sales;
```

NumPy:

```python
np.unique(sales[:, 1])
```

Result:

```text
[1000, 2000, 80000]
```

Therefore:

```text
DISTINCT → np.unique()
```

---

# 9. SQL `ORDER BY` vs `np.sort()`

SQL:

```sql
SELECT *
FROM sales
ORDER BY quantity;
```

NumPy:

```python
np.sort(sales[:, 2])
```

Descending:

SQL:

```sql
ORDER BY quantity DESC;
```

NumPy:

```python
np.sort(sales[:, 2])[::-1]
```

The `[::-1]` reverses the array.

### Important Difference

`np.sort()` sorts values. If you need to reorder **entire rows based on one column**, use:

```python
sales[np.argsort(sales[:, 2])]
```

Descending:

```python
sales[np.argsort(sales[:, 2])[::-1]]
```

---

# 10. SQL Aggregate Functions vs NumPy

### `SUM()`

SQL:

```sql
SELECT SUM(quantity)
FROM sales;
```

NumPy:

```python
np.sum(sales[:, 2])
```

### `AVG()`

SQL:

```sql
SELECT AVG(quantity)
FROM sales;
```

NumPy:

```python
np.mean(sales[:, 2])
```

### `MIN()`

SQL:

```sql
SELECT MIN(quantity)
FROM sales;
```

NumPy:

```python
np.min(sales[:, 2])
```

### `MAX()`

SQL:

```sql
SELECT MAX(quantity)
FROM sales;
```

NumPy:

```python
np.max(sales[:, 2])
```

### `COUNT()`

SQL:

```sql
SELECT COUNT(*)
FROM sales;
```

NumPy:

```python
sales.shape[0]
```

or:

```python
len(sales)
```

---

# 11. Aggregate Comparison Cheat Sheet

| SQL | NumPy |
|---|---|
| `SUM()` | `np.sum()` |
| `AVG()` | `np.mean()` |
| `MIN()` | `np.min()` |
| `MAX()` | `np.max()` |
| `COUNT()` | `len()` / `.shape[0]` / `.size` |
| `STDDEV()` | `np.std()` |
| `VARIANCE()` | `np.var()` |

---

# 12. SQL `CASE WHEN` vs `np.where()`

This is another excellent connection.

SQL:

```sql
SELECT
    quantity,
    CASE
        WHEN quantity >= 5 THEN 'High'
        ELSE 'Low'
    END AS category
FROM sales;
```

NumPy:

```python
np.where(
    sales[:, 2] >= 5,
    "High",
    "Low"
)
```

Result:

```text
['Low', 'High', 'Low', 'Low', 'High']
```

### Mental Model

```text
CASE WHEN condition
THEN value
ELSE value
```

becomes:

```text
np.where(condition, value_if_true, value_if_false)
```

---

# 13. SQL Calculated Column vs NumPy Vectorization

SQL:

```sql
SELECT
    quantity,
    price,
    quantity * price AS revenue
FROM sales;
```

NumPy:

```python
quantity = sales[:, 2]
price = sales[:, 1]

revenue = quantity * price
```

NumPy performs the operation on the entire array without explicitly writing a loop.

This is called:

# Vectorization

Instead of:

```python
for row in sales:
    ...
```

NumPy performs operations over arrays efficiently.

### Key Connection

```text
SQL set-based processing
          ≈
NumPy vectorized processing
```

They are not identical internally, but the mental model is useful.

---

# 14. SQL `UPDATE` vs NumPy Assignment

SQL:

```sql
UPDATE sales
SET quantity = quantity * 2;
```

NumPy:

```python
sales[:, 2] = sales[:, 2] * 2
```

Or:

```python
sales[:, 2] *= 2
```

This changes the values in the NumPy array.

---

# 15. SQL `NULL` vs NumPy `NaN`

SQL:

```sql
SELECT *
FROM sales
WHERE price IS NULL;
```

NumPy commonly represents missing floating-point values using:

```python
np.nan
```

Check for NaN:

```python
np.isnan(data)
```

### Conceptual Mapping

| SQL | NumPy |
|---|---|
| `NULL` | `np.nan` |
| `IS NULL` | `np.isnan()` |
| `IS NOT NULL` | `~np.isnan()` |

### Important Difference

`NULL` and `NaN` are **not exactly the same concept**.

SQL uses three-valued logic:

```text
TRUE
FALSE
UNKNOWN
```

`NaN` is a special floating-point value with different comparison behavior.

---

# 16. SQL `GROUP BY` vs NumPy

Suppose we have:

```text
Region     Sales
South      100
North      200
South      300
North      400
```

SQL:

```sql
SELECT
    region,
    SUM(sales)
FROM sales
GROUP BY region;
```

NumPy does not provide SQL-style `GROUP BY` functionality as naturally as Pandas.

This is an important teaching point:

> **NumPy is not a replacement for SQL or Pandas.**

For:

```text
GROUP BY
JOIN
pivot
merge
complex tabular manipulation
```

Pandas is usually the better Python equivalent.

---

# 17. SQL vs NumPy vs Pandas

This is one of the most useful comparisons for trainees.

| Requirement | SQL | NumPy | Pandas |
|---|---:|---:|---:|
| Tabular data | ⭐⭐⭐ | ⭐ | ⭐⭐⭐ |
| Numerical computation | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| Filtering | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| Aggregation | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| `GROUP BY` | ⭐⭐⭐ | ⭐ | ⭐⭐⭐ |
| JOIN | ⭐⭐⭐ | ⭐ | ⭐⭐⭐ |
| Missing values | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| Data cleaning | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| Matrix operations | ⭐ | ⭐⭐⭐ | ⭐⭐ |
| Machine learning preparation | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| Database querying | ⭐⭐⭐ | ❌ | ⭐ |
| Large database tables | ⭐⭐⭐ | ❌ | ⭐⭐ |

---

# 18. SQL JOIN vs NumPy

This is where trainees often make the wrong assumption.

SQL:

```sql
SELECT *
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id;
```

NumPy does **not** have a direct SQL-style relational JOIN abstraction.

Functions such as:

```python
np.concatenate()
np.column_stack()
np.vstack()
```

combine arrays, but they are **not relational JOINs**.

For relational operations, use Pandas:

```python
pd.merge(
    customers,
    orders,
    on="customer_id"
)
```

### Teaching Rule

> **SQL JOIN → Pandas `merge()`, NOT NumPy.**

---

# 19. SQL Table Schema vs NumPy `dtype`

SQL:

```sql
CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);
```

The database defines data types for individual columns.

NumPy:

```python
arr.dtype
```

Example:

```text
int64
```

Traditional NumPy arrays are designed primarily around homogeneous data.

### Important Difference

A SQL table can naturally contain:

```text
INT
VARCHAR
DATE
DECIMAL
BOOLEAN
```

in different columns.

A standard NumPy `ndarray` generally works best when values share a common data type.

For mixed tabular data, Pandas is usually more appropriate.

---

# 20. SQL Column vs NumPy Axis

Given:

```python
data.shape
```

and:

```text
(5, 3)
```

we have:

```text
axis 0 → rows
axis 1 → columns
```

For:

```python
np.sum(data, axis=0)
```

you are saying:

> Aggregate down the rows and give me one result per column.

Example:

```text
         Col1 Col2 Col3
Row 1     10   20   30
Row 2     40   50   60
Row 3     70   80   90
```

```python
np.sum(data, axis=0)
```

gives:

```text
[120, 150, 180]
```

---

# 21. `axis=0` vs `axis=1`

A useful trainee mnemonic:

```text
axis=0 → collapse rows
axis=1 → collapse columns
```

Example:

```python
np.sum(data, axis=0)
```

produces:

```text
column totals
```

while:

```python
np.sum(data, axis=1)
```

produces:

```text
row totals
```

### SQL Analogy

`axis=0` is somewhat like calculating an aggregate for each selected column.

`axis=1` is more like calculating a derived value across columns **within each row**.

It is not a direct SQL equivalent, but it is a useful bridge for learning.

---

# 22. SQL `WHERE` vs NumPy Mask — Deep Dive

SQL:

```sql
SELECT *
FROM employees
WHERE salary > 50000;
```

NumPy:

```python
employees[employees[:, 2] > 50000]
```

Break it down:

```python
employees[:, 2]
```

↓

```text
salary column
```

Then:

```python
employees[:, 2] > 50000
```

↓

```text
[False, True, True, False, True]
```

Then:

```python
employees[mask]
```

↓

```text
filtered rows
```

### Framework

```text
SELECT
   ↓
WHAT COLUMNS?
   ↓
WHERE
   ↓
WHAT CONDITION?
   ↓
BOOLEAN MASK
   ↓
FILTER ARRAY
```

---

# 23. SQL Problem → NumPy Problem

Use this framework with trainees:

```text
BUSINESS QUESTION
       ↓
WHAT DATA DO I NEED?
       ↓
WHAT ARRAY?
       ↓
WHAT SHAPE?
       ↓
WHAT COLUMN / AXIS?
       ↓
WHAT CONDITION?
       ↓
WHAT TRANSFORMATION?
       ↓
WHAT AGGREGATION?
       ↓
WHAT OUTPUT?
```

For SQL:

```text
BUSINESS QUESTION
       ↓
WHAT DATA DO I NEED?
       ↓
WHAT TABLE?
       ↓
WHAT COLUMNS?
       ↓
WHAT FILTER?
       ↓
WHAT GROUPING?
       ↓
WHAT CALCULATION?
       ↓
WHAT OUTPUT?
```

---

# 24. Practical Comparison Exercise

## Problem

> Find the total revenue generated by transactions where quantity is greater than 3.

### SQL Thinking

```text
FROM sales
      ↓
WHERE quantity > 3
      ↓
quantity × price
      ↓
SUM
```

SQL:

```sql
SELECT SUM(quantity * price)
FROM sales
WHERE quantity > 3;
```

NumPy:

```python
filtered = sales[sales[:, 2] > 3]

revenue = filtered[:, 2] * filtered[:, 1]

total_revenue = np.sum(revenue)
```

Or as one expression:

```python
np.sum(
    sales[sales[:, 2] > 3, 2] *
    sales[sales[:, 2] > 3, 1]
)
```

The first version is easier for trainees to understand.

---

# 25. SQL → NumPy Translation Cheat Sheet

| SQL | NumPy |
|---|---|
| `SELECT *` | Array |
| `SELECT column` | `array[:, column]` |
| `WHERE` | Boolean mask |
| `AND` | `&` |
| `OR` | `|` |
| `NOT` | `~` |
| `DISTINCT` | `np.unique()` |
| `SUM()` | `np.sum()` |
| `AVG()` | `np.mean()` |
| `MIN()` | `np.min()` |
| `MAX()` | `np.max()` |
| `COUNT()` | `len()` / `.shape[0]` |
| `CASE WHEN` | `np.where()` |
| `ORDER BY` | `np.sort()` / `np.argsort()` |
| `DESC` | `[::-1]` |
| `UPDATE` | Array assignment |
| `NULL` | `np.nan` |
| `IS NULL` | `np.isnan()` |
| Arithmetic expression | Vectorized operation |
| `GROUP BY` | Usually Pandas |
| `JOIN` | Usually Pandas |

---

# 26. The Most Important Conceptual Difference

Do **not** teach NumPy as:

> "SQL but in Python."

Instead teach:

## SQL

**Relational / set-based language**

```text
Tables
Rows
Columns
Relationships
Joins
Filters
Aggregations
```

## NumPy

**Numerical array computing library**

```text
Arrays
Dimensions
Shape
Axes
Indexing
Slicing
Masking
Vectorization
Broadcasting
Mathematical operations
```

## Pandas

**Tabular data manipulation library**

```text
DataFrames
Columns
Rows
Filtering
Grouping
Joining
Missing values
Data cleaning
```

---

# 27. Recommended NumPy Learning Sequence

## Module 1 — NumPy Foundations

```text
What is NumPy?
Why NumPy?
ndarray
dtype
shape
ndim
size
```

## Module 2 — Creating Arrays

```python
np.array()
np.zeros()
np.ones()
np.arange()
np.linspace()
```

## Module 3 — Indexing & Slicing

```python
arr[0]
arr[1:5]
arr[:, 0]
arr[:, 1:3]
```

## Module 4 — Filtering

```python
arr[arr > 50]
```

Connect directly to:

```sql
WHERE
```

## Module 5 — Vectorization

```python
arr * 2
arr + 10
arr ** 2
```

Connect to:

```sql
SELECT quantity * 2
```

## Module 6 — Aggregation

```python
np.sum()
np.mean()
np.min()
np.max()
np.std()
```

Connect to:

```sql
SUM()
AVG()
MIN()
MAX()
STDDEV()
```

## Module 7 — Conditional Logic

```python
np.where()
```

Connect to:

```sql
CASE WHEN
```

## Module 8 — Boolean Logic

```python
&
|
~
```

Connect to:

```sql
AND
OR
NOT
```

## Module 9 — Axis

```python
axis=0
axis=1
```

This is where NumPy starts becoming substantially different from SQL.

## Module 10 — Broadcasting

```python
array + scalar
array * scalar
matrix + vector
```

Broadcasting has no clean direct SQL equivalent, so teach it as a new NumPy concept.

## Module 11 — Reshaping

```python
reshape()
flatten()
ravel()
transpose()
```

These are fundamentally array-oriented operations.

## Module 12 — Advanced NumPy

```text
Random
Statistics
Linear algebra
Matrix operations
Stacking
Splitting
Sorting
Searching
Performance
```

---

# 28. One-Screen Mental Model

```text
                    DATA
                     │
        ┌────────────┼────────────┐
        ↓            ↓            ↓
       SQL         Pandas       NumPy
        │            │            │
     TABLE        DATAFRAME      ARRAY
        │            │            │
     ROW/COLUMN   ROW/COLUMN   AXIS/DIMENSION
        │            │            │
     WHERE        FILTER       MASK
        │            │            │
     GROUP BY     GROUPBY      AGGREGATION
        │            │            │
      JOIN         MERGE       ─────
        │            │            │
   RELATIONAL    TABULAR       NUMERICAL
   PROCESSING    PROCESSING    COMPUTING
```

---

# 29. Golden Rules

> **SQL is for querying relational data.**

> **Pandas is for manipulating tabular data in Python.**

> **NumPy is for fast numerical array computation.**

The most useful bridges are:

```text
SQL WHERE
    ↓
NumPy Boolean Mask
    ↓
Pandas Boolean Filtering
```

```text
SQL SUM / AVG / MIN / MAX
    ↓
NumPy np.sum / np.mean / np.min / np.max
    ↓
Pandas .sum / .mean / .min / .max
```

```text
SQL CASE WHEN
    ↓
NumPy np.where()
    ↓
Pandas np.where() / .loc / other conditional techniques
```

## Final Teaching Principle



```text
SQL
 ↓
"What am I trying to retrieve or calculate?"
 ↓
Translate the requirement into operations
 ↓
NumPy
 ↓
"Which array, axis, index, mask, transformation, or aggregation?"
```

This creates a smooth transition from **SQL → NumPy → Pandas → Python Data Engineering**.
