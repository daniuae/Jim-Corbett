# Pandas Problem-Solving Framework

## How to Identify Which Pandas Function or Technique to Use

> **Core Rule:**
>
> **WHAT → DATA → GRAIN → COLUMNS → FILTER → TRANSFORM → GROUP/MERGE → OUTPUT → VALIDATE**

The goal is **not to memorize Pandas functions**.

The goal is to read a problem statement and translate it into a sequence of Pandas operations.

---

# 1. WHAT — What exactly is the problem asking?

First identify the action words.

| Problem Statement                | Think About                         |
| -------------------------------- | ----------------------------------- |
| load data                        | `pd.read_csv()` / `pd.read_excel()` |
| display data                     | `head()` / `tail()`                 |
| inspect data                     | `info()` / `describe()`             |
| select column                    | `df['column']`                      |
| select multiple columns          | `df[['A', 'B']]`                    |
| select rows                      | `.loc[]` / `.iloc[]`                |
| filter rows                      | Boolean indexing                    |
| filter using multiple conditions | `&` / `\|`                          |
| sort                             | `sort_values()`                     |
| remove duplicates                | `drop_duplicates()`                 |
| rename column                    | `rename()`                          |
| create column                    | `df['new'] = ...`                   |
| replace values                   | `replace()` / `where()` / `mask()`  |
| handle missing values            | `isna()` / `fillna()` / `dropna()`  |
| count                            | `count()` / `value_counts()`        |
| total                            | `sum()`                             |
| average                          | `mean()`                            |
| highest                          | `max()`                             |
| lowest                           | `min()`                             |
| unique values                    | `unique()`                          |
| number of unique values          | `nunique()`                         |
| frequency of each value          | `value_counts()`                    |
| group data                       | `groupby()`                         |
| aggregate groups                 | `agg()`                             |
| transform each group             | `transform()`                       |
| combine DataFrames               | `merge()`                           |
| append rows                      | `concat()`                          |
| pivot data                       | `pivot()` / `pivot_table()`         |
| reshape                          | `melt()`                            |
| ranking                          | `rank()`                            |
| cumulative total                 | `cumsum()`                          |
| previous row                     | `shift()`                           |
| rolling average                  | `rolling()`                         |
| date extraction                  | `.dt`                               |
| string manipulation              | `.str`                              |
| apply custom function            | `apply()`                           |
| reset index                      | `reset_index()`                     |
| set index                        | `set_index()`                       |

---

# 2. DATA — What type of Pandas object are you working with?

Before selecting a function, identify whether you are working with:

```text
Series
   or
DataFrame
```

## Series

One column:

```python
df['salary']
```

Think:

```text
1-dimensional
```

---

## DataFrame

Multiple columns:

```python
df
```

Think:

```text
2-dimensional
Rows × Columns
```

### Golden Rule

> **Series = One column**

> **DataFrame = Multiple columns**

---

# 3. INSPECT — Understand the Data First

Before solving the problem, inspect the DataFrame.

## First rows

```python
df.head()
```

## Last rows

```python
df.tail()
```

## Structure

```python
df.info()
```

## Statistical summary

```python
df.describe()
```

## Shape

```python
df.shape
```

## Column names

```python
df.columns
```

## Data types

```python
df.dtypes
```

### Mental Model

```text
head()      → What does the data look like?
info()      → What is the structure?
describe()  → What are the statistics?
shape       → How big is it?
columns     → What fields exist?
dtypes      → What type is each field?
```

---

# 4. GRAIN — What does ONE row represent?

This is extremely important.

Ask:

> **"What does one row in this DataFrame represent?"**

Examples:

| DataFrame       | One Row Represents |
| --------------- | ------------------ |
| Employee Data   | Employee           |
| Customer Data   | Customer           |
| Orders          | Order              |
| Sales           | Transaction        |
| Product Data    | Product            |
| Daily Sales     | Day                |
| Monthly Revenue | Month              |

Suppose:

```text
Orders
```

contains:

```text
order_id
customer_id
product_id
quantity
amount
```

Then:

> One row = One Order

This understanding helps determine whether you need:

```text
filter
groupby
merge
drop_duplicates
```

---

# 5. COLUMN — Which columns do I need?

Separate columns into three categories.

## A. Output Columns

What should appear in the final answer?

Example:

```text
customer_id
total_sales
```

---

## B. Filter Columns

What determines which rows should be included?

Example:

```text
country
status
order_date
```

---

## C. Calculation Columns

Which columns are used for calculations?

Example:

```text
quantity
price
sales_amount
```

This simple classification makes complex Pandas problems easier.

---

# 6. SELECT ONE COLUMN

Problem:

> Select the salary column.

Think:

```python
df['salary']
```

Result:

```text
Series
```

---

# 7. SELECT MULTIPLE COLUMNS

Problem:

> Select employee name and salary.

Think:

```python
df[['name', 'salary']]
```

### Golden Rule

```text
One column
→ df['column']

Multiple columns
→ df[['column1', 'column2']]
```

This is one of the most important Pandas syntax rules.

---

# 8. ROW SELECTION — LOC vs ILOC

## `.loc[]`

Use when selecting using:

* column names
* labels
* conditions

Example:

```python
df.loc[df['salary'] > 50000]
```

---

## `.iloc[]`

Use when selecting using:

* integer positions
* row/column positions

Example:

```python
df.iloc[0:5, 0:3]
```

### Golden Rule

```text
loc  → LABEL / CONDITION

iloc → INTEGER POSITION
```

---

# 9. FILTER — Do I need specific rows?

Look for:

* employees with salary > 50,000
* customers from India
* products with price < 100
* active customers
* sales in 2026

Think:

> **Boolean filtering**

Example:

```python
df[df['salary'] > 50000]
```

---

# 10. MULTIPLE CONDITIONS

Problem:

> Find employees whose salary is greater than 50,000 and department is IT.

Think:

```python
df[
    (df['salary'] > 50000) &
    (df['department'] == 'IT')
]
```

### Important Pandas Rule

Use:

```text
& → AND
| → OR
~ → NOT
```

Not:

```text
and
or
not
```

For Pandas Series.

---

# 11. FILTER WITH `.isin()`

Problem:

> Find employees from IT, HR or Finance.

Think:

```python
df[df['department'].isin(['IT', 'HR', 'Finance'])]
```

### Mental Translation

```text
value belongs to a list
        ↓
isin()
```

---

# 12. FILTER WITH STRING CONDITIONS

Problem:

> Find customers whose name starts with "A".

Think:

```python
df[df['name'].str.startswith('A')]
```

Problem:

> Find names containing "raj".

Think:

```python
df[df['name'].str.contains('raj', case=False, na=False)]
```

### Mental Rule

```text
Text operation
→ .str
```

---

# 13. FILTER WITH DATES

Problem:

> Find orders from January 2026.

First make sure the column is datetime:

```python
df['order_date'] = pd.to_datetime(df['order_date'])
```

Then filter:

```python
df[
    (df['order_date'] >= '2026-01-01') &
    (df['order_date'] < '2026-02-01')
]
```

For extracting date components:

```python
df['order_date'].dt.year
df['order_date'].dt.month
df['order_date'].dt.day
```

### Mental Rule

```text
Date operation
→ .dt
```

---

# 14. SORTING

Problem:

> Sort employees by salary from highest to lowest.

Think:

```python
df.sort_values(
    'salary',
    ascending=False
)
```

Multiple columns:

```python
df.sort_values(
    ['department', 'salary'],
    ascending=[True, False]
)
```

### Mental Rule

```text
Sort rows
→ sort_values()
```

---

# 15. CREATE A NEW COLUMN

Problem:

> Calculate total amount using quantity × price.

Think:

```python
df['total_amount'] = (
    df['quantity'] * df['price']
)
```

### Mental Rule

```text
"Calculate/create a field"
        ↓
df['new_column'] = expression
```

---

# 16. CONDITIONAL COLUMN

Problem:

> Mark employees as High if salary > 100000, otherwise Low.

Think:

```python
import numpy as np

df['salary_level'] = np.where(
    df['salary'] > 100000,
    'High',
    'Low'
)
```

Or with Pandas:

```python
df['salary_level'] = 'Low'

df.loc[
    df['salary'] > 100000,
    'salary_level'
] = 'High'
```

### Mental Rule

```text
Simple condition
→ np.where()

Pandas row/column assignment
→ .loc[]
```

---

# 17. MISSING VALUES

Look for:

* missing
* null
* NaN
* empty values
* replace missing values
* remove missing rows

## Find missing values

```python
df.isna()
```

---

## Count missing values

```python
df.isna().sum()
```

---

## Remove missing rows

```python
df.dropna()
```

---

## Replace missing values

```python
df.fillna(0)
```

### Golden Rule

```text
Find missing
→ isna()

Remove missing
→ dropna()

Replace missing
→ fillna()
```

---

# 18. DUPLICATES

Problem:

> Remove duplicate customers.

Think:

```python
df.drop_duplicates()
```

Based on specific columns:

```python
df.drop_duplicates(
    subset=['customer_id']
)
```

Find duplicates:

```python
df.duplicated()
```

### Mental Rule

```text
Find duplicates
→ duplicated()

Remove duplicates
→ drop_duplicates()
```

---

# 19. UNIQUE VALUES

Problem:

> Find all unique departments.

Think:

```python
df['department'].unique()
```

---

# 20. NUMBER OF UNIQUE VALUES

Problem:

> Find how many departments exist.

Think:

```python
df['department'].nunique()
```

### Golden Rule

```text
unique values
→ unique()

number of unique values
→ nunique()
```

---

# 21. FREQUENCY / COUNT OF VALUES

Problem:

> Find how many employees are in each department.

Think:

```python
df['department'].value_counts()
```

Result:

```text
IT        100
HR         40
Finance    35
```

### Mental Translation

```text
Frequency of each category
→ value_counts()
```

---

# 22. AGGREGATION

Look for:

* total
* average
* maximum
* minimum
* count

Think:

```python
sum()
mean()
max()
min()
count()
```

Examples:

```python
df['salary'].sum()
```

```python
df['salary'].mean()
```

```python
df['salary'].max()
```

```python
df['salary'].min()
```

```python
df['salary'].count()
```

---

# 23. GROUPBY — "For Each"

This is one of the most important Pandas concepts.

Problem:

> Find total salary for each department.

Look for:

```text
"for each department"
```

Think:

```python
groupby()
```

Solution:

```python
df.groupby('department')['salary'].sum()
```

---

# 24. GROUPBY + MULTIPLE AGGREGATIONS

Problem:

> Find total, average, maximum and minimum salary for each department.

Think:

```python
df.groupby('department')['salary'].agg(
    ['sum', 'mean', 'max', 'min']
)
```

Or:

```python
df.groupby('department').agg(
    total_salary=('salary', 'sum'),
    avg_salary=('salary', 'mean'),
    max_salary=('salary', 'max'),
    min_salary=('salary', 'min')
)
```

### Mental Rule

```text
One calculation
→ groupby() + function

Multiple calculations
→ groupby() + agg()
```

---

# 25. GROUPBY + COUNT

Problem:

> Find number of employees in each department.

Think:

```python
df.groupby('department').size()
```

Or:

```python
df.groupby('department')['employee_id'].count()
```

### Important Difference

```text
size()
→ counts rows

count()
→ counts non-null values
```

This distinction matters.

---

# 26. `as_index=False`

Problem:

> Group by department but keep department as a normal column.

Use:

```python
df.groupby(
    'department',
    as_index=False
)['salary'].sum()
```

Without `as_index=False`, the grouping column normally becomes the index.

### Mental Rule

```text
Need grouping column as normal column?
→ as_index=False
```

---

# 27. RESET_INDEX

If grouping has already created an index:

```python
result = (
    df.groupby('department')['salary']
      .sum()
      .reset_index()
)
```

### Mental Rule

```text
Index became unwanted?
→ reset_index()
```

If you don't want the old index retained:

```python
df.reset_index(drop=True)
```

---

# 28. GROUPBY vs TRANSFORM

This is a critical Pandas concept.

## GROUPBY

Used when you want to **reduce rows**.

```python
df.groupby('department')['salary'].mean()
```

Result:

```text
IT        70000
HR        60000
Finance   65000
```

One row per department.

---

## TRANSFORM

Used when you want the group calculation but **keep every original row**.

```python
df['dept_avg_salary'] = (
    df.groupby('department')['salary']
      .transform('mean')
)
```

Result:

```text
Employee   Department   Salary   Dept_Avg
A          IT           80000    70000
B          IT           60000    70000
C          HR           65000    60000
```

### Golden Rule

> **GROUPBY = Reduce rows**

> **TRANSFORM = Keep rows**

This is very similar to the SQL:

```text
GROUP BY vs WINDOW FUNCTION
```

---

# 29. APPLY — Do I need a custom function?

Problem:

> Apply a custom calculation to every value/row/group.

Think:

```python
apply()
```

Example:

```python
df['salary'] = df['salary'].apply(
    lambda x: x * 1.10
)
```

### Important

Don't automatically use `apply()`.

If Pandas/NumPy already provides a vectorized operation, prefer that.

For example:

```python
df['salary'] * 1.10
```

is usually preferable to:

```python
df['salary'].apply(lambda x: x * 1.10)
```

### Mental Rule

> **Custom logic that cannot be expressed easily with vectorized operations → `apply()`**

---

# 30. MERGE — Do I need another DataFrame?

Problem:

> Combine employee information with department information.

Think:

```python
pd.merge()
```

Example:

```python
result = pd.merge(
    employees,
    departments,
    on='department_id',
    how='inner'
)
```

### JOIN Translation

```text
SQL INNER JOIN
→ merge(..., how='inner')

SQL LEFT JOIN
→ merge(..., how='left')

SQL RIGHT JOIN
→ merge(..., how='right')

SQL FULL JOIN
→ merge(..., how='outer')
```

---

# 31. CONCAT — Stack DataFrames

Problem:

> Combine January and February DataFrames row-wise.

Think:

```python
pd.concat()
```

Example:

```python
result = pd.concat(
    [jan_df, feb_df],
    ignore_index=True
)
```

### Mental Rule

```text
JOIN based on a key
→ merge()

Stack DataFrames
→ concat()
```

---

# 32. MERGE vs CONCAT

Remember this simple rule:

```text
MERGE
 ↓
"Match using a key"
 ↓
customer_id
department_id
product_id
```

Whereas:

```text
CONCAT
 ↓
"Put DataFrames together"
 ↓
rows or columns
```

---

# 33. PIVOT TABLE

Problem:

> Find total sales by region and product.

Think:

```python
pd.pivot_table()
```

Example:

```python
pd.pivot_table(
    df,
    values='sales',
    index='region',
    columns='product',
    aggfunc='sum'
)
```

Mental translation:

```text
Rows    → region
Columns → product
Values  → sales
Calculation → sum
```

---

# 34. MELT

Problem:

> Convert columns into rows.

Think:

```python
pd.melt()
```

Example:

```python
pd.melt(
    df,
    id_vars=['employee'],
    var_name='month',
    value_name='sales'
)
```

### Mental Rule

```text
Wide → Long
→ melt()

Long → Wide
→ pivot() / pivot_table()
```

---

# 35. RANKING

Problem:

> Rank employees by salary.

Think:

```python
df['rank'] = df['salary'].rank(
    ascending=False
)
```

For ranking within each department:

```python
df['dept_rank'] = (
    df.groupby('department')['salary']
      .rank(ascending=False)
)
```

### Mental Translation

```text
Rank
→ rank()

Rank within group
→ groupby() + rank()
```

---

# 36. TOP N

Problem:

> Find the top 5 highest-paid employees.

Think:

```python
df.nlargest(5, 'salary')
```

Alternatively:

```python
df.sort_values(
    'salary',
    ascending=False
).head(5)
```

### Mental Rule

```text
Top N
→ nlargest()

Bottom N
→ nsmallest()
```

---

# 37. PREVIOUS / NEXT ROW

Problem:

> Compare current sales with previous day's sales.

Think:

```python
shift()
```

Example:

```python
df['previous_sales'] = (
    df['sales'].shift(1)
)
```

Difference:

```python
df['difference'] = (
    df['sales'] -
    df['sales'].shift(1)
)
```

### Mental Rule

```text
Previous row
→ shift(1)

Next row
→ shift(-1)
```

---

# 38. CUMULATIVE TOTAL

Problem:

> Calculate running sales total.

Think:

```python
cumsum()
```

Example:

```python
df['running_sales'] = (
    df['sales'].cumsum()
)
```

### Mental Rule

```text
Running total
→ cumsum()
```

Other cumulative functions:

```python
cummax()
cummin()
cumprod()
```

---

# 39. ROLLING CALCULATION

Problem:

> Calculate a 7-day moving average.

Think:

```python
rolling()
```

Example:

```python
df['moving_avg'] = (
    df['sales']
      .rolling(7)
      .mean()
)
```

### Mental Rule

```text
Moving / rolling calculation
→ rolling()
```

---

# 40. STRING OPERATIONS

Look for:

* uppercase
* lowercase
* contains
* starts with
* ends with
* replace text
* split text
* length

Think:

```python
.str
```

Examples:

```python
df['name'].str.upper()
```

```python
df['name'].str.lower()
```

```python
df['name'].str.contains('raj')
```

```python
df['name'].str.startswith('A')
```

```python
df['name'].str.len()
```

### Golden Rule

> **Text problem → `.str`**

---

# 41. DATE OPERATIONS

Look for:

* year
* month
* day
* weekday
* date difference
* month extraction
* year extraction

Think:

```python
.dt
```

Examples:

```python
df['date'].dt.year
```

```python
df['date'].dt.month
```

```python
df['date'].dt.day
```

```python
df['date'].dt.day_name()
```

### Golden Rule

> **Date problem → `.dt`**

---

# 42. COPY — Avoid Unwanted Changes

When creating a DataFrame subset that you intend to modify:

```python
new_df = df[
    df['salary'] > 50000
].copy()
```

### Mental Rule

> **I am creating a separate DataFrame that I will modify → `.copy()`**

This helps avoid confusing view/copy behavior and related warnings.

---

# 43. PANDAS DECISION TREE

```text
                         PANDAS PROBLEM
                              |
                              v
                       WHAT IS ASKED?
                              |
        +---------------------+----------------------+
        |                     |                      |
      INSPECT               SELECT                 FILTER
        |                     |                      |
   head/info              column/loc/iloc       Boolean
   describe              one/multiple            isin
   shape                 columns                 str
                                                date
                                                
                                                
        +--------------------------------------------+
        |
        v
                    CALCULATE?
                         |
             +-----------+-----------+
             |                       |
          SINGLE                   GROUP
             |                       |
       sum/mean/max/min        groupby()
                                  |
                                agg()
                                  |
                              transform()
                              
                              
        +--------------------------------------------+
        |
        v
                   COMBINE DATA?
                         |
                 +-------+-------+
                 |               |
               KEY            STACK
                 |               |
              merge()         concat()
              
              
        +--------------------------------------------+
        |
        v
                   CHANGE SHAPE?
                         |
                 +-------+-------+
                 |               |
              pivot()         melt()
              pivot_table()
              
              
        +--------------------------------------------+
        |
        v
                  POSITIONAL?
                         |
              +----------+----------+
              |          |          |
             TOP        PREV       RANK
              |          |          |
          nlargest()   shift()    rank()
          
          
        +--------------------------------------------+
        |
        v
                TIME / TEXT?
                    |
            +-------+-------+
            |               |
          DATE             TEXT
            |               |
           .dt             .str
           
           
        +--------------------------------------------+
        |
        v
                 MISSING DATA?
                       |
              +--------+--------+
              |        |        |
            CHECK    REMOVE   REPLACE
            isna()   dropna() fillna()
```

---

# 44. THE 10 GOLDEN PANDAS RULES

## Rule 1

> Select one column → `df['column']`

```python
df['salary']
```

---

## Rule 2

> Select multiple columns → `df[['A', 'B']]`

```python
df[['name', 'salary']]
```

---

## Rule 3

> Filter rows → Boolean indexing

```python
df[df['salary'] > 50000]
```

---

## Rule 4

> Label/condition based selection → `.loc[]`

```python
df.loc[df['salary'] > 50000]
```

---

## Rule 5

> Position based selection → `.iloc[]`

```python
df.iloc[0:5, 0:3]
```

---

## Rule 6

> "For each..." → `groupby()`

```python
df.groupby('department')['salary'].mean()
```

---

## Rule 7

> Group calculation while keeping every row → `transform()`

```python
df['dept_avg'] = (
    df.groupby('department')['salary']
      .transform('mean')
)
```

---

## Rule 8

> Combine DataFrames using a key → `merge()`

```python
pd.merge(df1, df2, on='id')
```

---

## Rule 9

> Stack DataFrames → `concat()`

```python
pd.concat([df1, df2])
```

---

## Rule 10

> Missing values → `isna()` / `dropna()` / `fillna()`

---

# 45. THE 30-SECOND PANDAS PROBLEM SOLVER

Before writing Pandas code, ask:

```text
1. WHAT?
   What exactly is the problem asking?

2. DATA?
   DataFrame or Series?

3. GRAIN?
   What does one row represent?

4. COLUMNS?
   Which columns are needed?

5. FILTER?
   Which rows should remain?

6. CALCULATION?
   Sum / Mean / Count / Max / Min?

7. GROUP?
   Does the problem say "for each"?

8. REDUCE OR KEEP?
   groupby() or transform()?

9. COMBINE?
   Do I need merge() or concat()?

10. SHAPE?
    Do I need pivot() / melt()?

11. POSITION?
    Top / bottom / previous / rank?

12. SPECIAL?
    Date → .dt
    Text → .str
    Missing → isna/dropna/fillna

13. VALIDATE?
    Is the shape correct?
    Are the expected columns present?
    Did I accidentally create duplicates?
```

---

# 46. COMPLETE EXAMPLE

## Problem

> Find the top 2 highest-paid employees in each department.

Don't immediately write code.

---

## Step 1 — WHAT?

"Top 2"

→ Ranking required.

---

## Step 2 — GRAIN?

One row represents:

```text
Employee within Department
```

---

## Step 3 — COLUMNS?

Need:

```text
employee
department
salary
```

---

## Step 4 — GROUP?

"Each department"

→ `groupby()`

---

## Step 5 — RANK?

Need ranking within department:

```python
df['rank'] = (
    df.groupby('department')['salary']
      .rank(
          ascending=False,
          method='first'
      )
)
```

---

## Step 6 — FILTER?

Keep ranks ≤ 2:

```python
result = df[df['rank'] <= 2]
```

---

## Function Chain

```text
Problem
   ↓
TOP 2
   ↓
RANKING
   ↓
GROUP BY DEPARTMENT
   ↓
rank()
   ↓
FILTER rank <= 2
```

---

# 47. ANOTHER EXAMPLE

## Problem

> Find the average salary of each department and add that average salary to every employee's row.

Identify:

```text
Average
   ↓
Each department
   ↓
groupby()
   ↓
Keep every employee row
   ↓
transform()
```

Solution:

```python
df['department_avg_salary'] = (
    df.groupby('department')['salary']
      .transform('mean')
)
```

### Key Insight

If the question says:

> **"Calculate something per group and put it back against every original row."**

Think:

> **`transform()`**

---

# 48. ANOTHER EXAMPLE

## Problem

> Find customers who have placed more than 5 orders.

Identify:

```text
More than 5
   ↓
Count
   ↓
Per customer
   ↓
groupby()
   ↓
Filter groups
```

Solution:

```python
result = (
    df.groupby('customer_id')
      .size()
      .reset_index(name='order_count')
)

result = result[
    result['order_count'] > 5
]
```

Function chain:

```text
GROUPBY
   ↓
SIZE
   ↓
RESET_INDEX
   ↓
FILTER
```

---

# 49. ANOTHER EXAMPLE

## Problem

> Find the previous transaction amount for each customer.

Identify:

```text
Previous
   ↓
shift()
```

But the phrase:

> "for each customer"

means we need a group.

Therefore:

```python
df['previous_amount'] = (
    df.sort_values(
        ['customer_id', 'transaction_date']
    )
    .groupby('customer_id')['amount']
    .shift(1)
)
```

Function chain:

```text
SORT
 ↓
GROUPBY CUSTOMER
 ↓
SHIFT
 ↓
PREVIOUS VALUE
```

---

# 50. PANDAS FUNCTION IDENTIFICATION MATRIX

| Problem Pattern               | Pandas Function / Technique |
| ----------------------------- | --------------------------- |
| Load CSV                      | `pd.read_csv()`             |
| Load Excel                    | `pd.read_excel()`           |
| Inspect first rows            | `head()`                    |
| Inspect last rows             | `tail()`                    |
| Inspect structure             | `info()`                    |
| Statistical summary           | `describe()`                |
| Check dimensions              | `shape`                     |
| Select one column             | `df['col']`                 |
| Select multiple columns       | `df[['A','B']]`             |
| Select by label/condition     | `.loc[]`                    |
| Select by position            | `.iloc[]`                   |
| Filter rows                   | Boolean indexing            |
| Multiple conditions           | `&`, `\|`, `~`              |
| Filter from list              | `isin()`                    |
| Text operations               | `.str`                      |
| Date operations               | `.dt`                       |
| Sort                          | `sort_values()`             |
| Top N                         | `nlargest()`                |
| Bottom N                      | `nsmallest()`               |
| Total                         | `sum()`                     |
| Average                       | `mean()`                    |
| Count                         | `count()` / `size()`        |
| Maximum                       | `max()`                     |
| Minimum                       | `min()`                     |
| Unique values                 | `unique()`                  |
| Unique count                  | `nunique()`                 |
| Frequency                     | `value_counts()`            |
| Group data                    | `groupby()`                 |
| Multiple aggregations         | `agg()`                     |
| Group calculation + keep rows | `transform()`               |
| Custom function               | `apply()`                   |
| Create column                 | `df['new'] = ...`           |
| Conditional assignment        | `.loc[]` / `np.where()`     |
| Missing values check          | `isna()`                    |
| Remove missing                | `dropna()`                  |
| Replace missing               | `fillna()`                  |
| Find duplicates               | `duplicated()`              |
| Remove duplicates             | `drop_duplicates()`         |
| Combine by key                | `merge()`                   |
| Stack DataFrames              | `concat()`                  |
| Wide → Long                   | `melt()`                    |
| Long → Wide                   | `pivot()`                   |
| Aggregated pivot              | `pivot_table()`             |
| Ranking                       | `rank()`                    |
| Previous row                  | `shift()`                   |
| Running total                 | `cumsum()`                  |
| Moving calculation            | `rolling()`                 |
| Reset index                   | `reset_index()`             |
| Set index                     | `set_index()`               |
| Create independent copy       | `copy()`                    |

---

# 51. PANDAS MINDSET

Don't think:

> "Which Pandas function do I remember?"

Instead think:

> **"What operation does the problem require?"**

Then translate:

```text
Problem
   ↓
Operation
   ↓
Pandas Function
```

Example:

```text
"Find total sales for each customer"
        ↓
Aggregation
        ↓
Group
        ↓
groupby()
        ↓
SUM
        ↓
sum()
```

Another:

```text
"Find employees earning more than 100000"
        ↓
Filter
        ↓
Boolean condition
        ↓
df[df['salary'] > 100000]
```

Another:

```text
"Add department average salary to every employee"
        ↓
Group calculation
        ↓
Keep original rows
        ↓
transform()
```

Another:

```text
"Combine customer and order information"
        ↓
Two DataFrames
        ↓
Common key
        ↓
merge()
```

---

# 52. SQL → NUMPY → PANDAS MENTAL MODEL

Now we can connect all three.

| Requirement                       | SQL               | NumPy                  | Pandas                  |
| --------------------------------- | ----------------- | ---------------------- | ----------------------- |
| Filter                            | `WHERE`           | Boolean indexing       | Boolean indexing        |
| Select                            | `SELECT`          | Indexing               | `[]` / `.loc` / `.iloc` |
| Aggregate                         | `SUM()`           | `np.sum()`             | `.sum()`                |
| Average                           | `AVG()`           | `np.mean()`            | `.mean()`               |
| Maximum                           | `MAX()`           | `np.max()`             | `.max()`                |
| Minimum                           | `MIN()`           | `np.min()`             | `.min()`                |
| Group                             | `GROUP BY`        | Axis-based aggregation | `groupby()`             |
| Keep rows after group calculation | Window            | Axis operation         | `transform()`           |
| Join                              | `JOIN`            | Combine arrays         | `merge()`               |
| Stack                             | `UNION`           | `concatenate()`        | `concat()`              |
| Sort                              | `ORDER BY`        | `np.sort()`            | `sort_values()`         |
| Rank                              | Window functions  | Sorting/index logic    | `rank()`                |
| Previous row                      | `LAG()`           | Array slicing          | `shift()`               |
| Running total                     | Window `SUM()`    | `np.cumsum()`          | `cumsum()`              |
| Unique                            | `DISTINCT`        | `np.unique()`          | `unique()`              |
| Count unique                      | `COUNT(DISTINCT)` | `unique + counts`      | `nunique()`             |
| Missing                           | `IS NULL`         | `np.isnan()`           | `isna()`                |
| Conditional                       | `CASE`            | `np.where()`           | `.loc` / `np.where()`   |
| Wide/Long                         | Pivot concepts    | Reshape                | `pivot()` / `melt()`    |

---

# 53. THE THREE-LANGUAGE TRANSLATION ENGINE

This is particularly useful for Data Engineering trainees.

## Example

> "Find the average salary for each department."

### SQL

```text
GROUP BY
   +
AVG()
```

### NumPy

```text
Aggregation
   +
axis
```

### Pandas

```text
groupby()
   +
mean()
```

---

## Example

> "Find values greater than 100."

### SQL

```text
WHERE value > 100
```

### NumPy

```python
arr[arr > 100]
```

### Pandas

```python
df[df['value'] > 100]
```

---

## Example

> "Find the previous value."

### SQL

```text
LAG()
```

### NumPy

```text
Slicing
```

### Pandas

```python
shift()
```

---

# 54. FINAL MASTER FORMULA

Whenever you receive a Pandas problem:

```text
                 READ THE PROBLEM
                        ↓
                    WHAT?
                        ↓
                     DATA
                        ↓
                     GRAIN
                        ↓
                    COLUMNS
                        ↓
                     FILTER
                        ↓
                  CALCULATION
                        ↓
                GROUP OR KEEP?
                        ↓
               MERGE / CONCAT?
                        ↓
                 PIVOT / MELT?
                        ↓
                 RANK / SHIFT?
                        ↓
                  .dt / .str?
                        ↓
                MISSING VALUES?
                        ↓
                  WRITE CODE
                        ↓
                   VALIDATE
```

## 🏆 One-Line Formula

> **WHAT → DATA → GRAIN → COLUMNS → FILTER → CALCULATE → GROUP/TRANSFORM → COMBINE → OUTPUT → VALIDATE**

---

# 55. THE ULTIMATE LEARNING PRINCIPLE

Do not memorize:

```text
100 Pandas functions
```

Instead memorize:

```text
PROBLEM
   ↓
WHAT OPERATION?
   ↓
WHICH PANDAS CONCEPT?
   ↓
WHICH FUNCTION?
```

### Example

```text
"For each department"
        ↓
GROUP
        ↓
groupby()
```

```text
"For each department, but keep every employee"
        ↓
GROUP + KEEP ROWS
        ↓
transform()
```

```text
"Combine using customer_id"
        ↓
JOIN
        ↓
merge()
```

```text
"Put DataFrames one below another"
        ↓
STACK
        ↓
concat()
```

```text
"Previous value"
        ↓
SHIFT
        ↓
shift()
```

```text
"Running total"
        ↓
CUMULATIVE
        ↓
cumsum()
```

```text
"Text contains..."
        ↓
STRING OPERATION
        ↓
.str.contains()
```

```text
"Extract year/month/day"
        ↓
DATE OPERATION
        ↓
.dt.year / .dt.month / .dt.day
```

---

# 🧠 FINAL FRAMEWORK FOR YOUR TRAINEES

## SQL

> **WHAT → GRAIN → TABLE → JOIN → FILTER → CALCULATE → GROUP/WINDOW → VALIDATE**

## NumPy

> **WHAT → DATA → SHAPE → OPERATION → CONDITION → AXIS → FUNCTION → VALIDATE**

## Pandas

> **WHAT → DATA → GRAIN → COLUMNS → FILTER → CALCULATE → GROUP/TRANSFORM → COMBINE → OUTPUT → VALIDATE**

### The common principle

> **Don't memorize the solution. Identify the operation.**

Once the operation is identified, the appropriate function becomes much easier to choose.
