# SQL + Pandas + NumPy

## One Problem → Three Technologies

### A Unified Data Analysis Tutorial

---

# 1. The Big Picture

SQL, Pandas and NumPy solve many of the same data problems, but at different levels.

| Concept                   | SQL               | Pandas                           | NumPy                      |
| ------------------------- | ----------------- | -------------------------------- | -------------------------- |
| Primary object            | Table             | DataFrame                        | ndarray                    |
| Best for                  | Database data     | Tabular analysis                 | Numerical computation      |
| Filtering                 | `WHERE`           | Boolean filtering                | Boolean masking            |
| Selecting columns         | `SELECT`          | `df[]`                           | Array slicing              |
| Sorting                   | `ORDER BY`        | `sort_values()`                  | `sort()` / `argsort()`     |
| Aggregation               | `GROUP BY`        | `groupby()`                      | `sum()`, `mean()`, etc.    |
| Joining                   | `JOIN`            | `merge()`                        | Usually manual/index-based |
| Conditional logic         | `CASE WHEN`       | `np.where()` / `loc`             | `np.where()`               |
| Null handling             | `IS NULL`         | `isna()`                         | `np.isnan()`               |
| Unique values             | `DISTINCT`        | `unique()` / `drop_duplicates()` | `np.unique()`              |
| Ranking                   | Window functions  | `rank()`                         | `argsort()`                |
| Running total             | Window `SUM()`    | `cumsum()`                       | `np.cumsum()`              |
| Reshaping                 | Pivot / SQL logic | `pivot()`                        | `reshape()`                |
| Mathematical operations   | SQL functions     | Pandas/NumPy                     | Excellent                  |
| Large database processing | Excellent         | Limited by memory                | Limited by memory          |

---

# 2. The Learning Framework

For every problem, ask:

```text
1. What is the INPUT?
2. What is the OUTPUT?
3. What is the OUTPUT GRAIN?
4. Which columns are required?
5. Do I need FILTERING?
6. Do I need TRANSFORMATION?
7. Do I need AGGREGATION?
8. Do I need JOINING?
9. Do I need SORTING?
10. Do I need RANKING?
11. Do I need WINDOW logic?
12. Do I need reshaping?
```

Then translate the requirement:

```text
Business Question
       ↓
Identify operation
       ↓
SQL equivalent
       ↓
Pandas equivalent
       ↓
NumPy equivalent
```

---

# 3. Our Common Dataset

We will use an imaginary sales dataset.

## Sales

| OrderID | CustomerID | Product  | Category    | Region | Quantity | Price | SalesDate  |
| ------- | ---------- | -------- | ----------- | ------ | -------: | ----: | ---------- |
| 1001    | C01        | Laptop   | Electronics | South  |        2 | 60000 | 2026-01-10 |
| 1002    | C02        | Mouse    | Electronics | North  |        5 |  1000 | 2026-01-11 |
| 1003    | C01        | Keyboard | Electronics | South  |        3 |  2500 | 2026-01-12 |
| 1004    | C03        | Chair    | Furniture   | West   |        2 |  7000 | 2026-01-13 |
| 1005    | C02        | Laptop   | Electronics | North  |        1 | 60000 | 2026-01-15 |
| 1006    | C04        | Desk     | Furniture   | South  |        1 | 12000 | 2026-01-17 |

---

# 4. Loading the Data

## SQL

The data already exists as a database table:

```sql
SELECT *
FROM Sales;
```

## Pandas

```python
import pandas as pd

df = pd.read_csv("sales.csv")

print(df)
```

## NumPy

```python
import numpy as np

data = np.array([
    [1001, 2, 60000],
    [1002, 5, 1000],
    [1003, 3, 2500],
    [1004, 2, 7000],
    [1005, 1, 60000],
    [1006, 1, 12000]
])
```

NumPy is primarily numerical, so a complete business table is usually better represented using Pandas.

---

# 5. SELECT — Selecting Columns

Question:

> Show Product, Region and Quantity.

## SQL

```sql
SELECT Product, Region, Quantity
FROM Sales;
```

## Pandas

```python
df[["Product", "Region", "Quantity"]]
```

## NumPy

If columns are represented as:

```text
[OrderID, Quantity, Price]
```

then:

```python
data[:, [0, 1, 2]]
```

### Golden Rule

```text
SQL       → SELECT
Pandas    → df[[columns]]
NumPy     → slicing/indexing
```

---

# 6. DISTINCT / UNIQUE

Question:

> Find all unique regions.

## SQL

```sql
SELECT DISTINCT Region
FROM Sales;
```

## Pandas

```python
df["Region"].unique()
```

or:

```python
df[["Region"]].drop_duplicates()
```

## NumPy

```python
np.unique(regions)
```

---

# 7. WHERE — Filtering Rows

Question:

> Find sales from the South region.

## SQL

```sql
SELECT *
FROM Sales
WHERE Region = 'South';
```

## Pandas

```python
df[df["Region"] == "South"]
```

## NumPy

```python
data[data[:, 0] == "South"]
```

For numerical arrays:

```python
data[data[:, 1] > 2]
```

### Pattern

```text
SQL:
WHERE condition

Pandas:
df[condition]

NumPy:
array[condition]
```

This is one of the most important similarities to understand.

---

# 8. Multiple Conditions

Question:

> Find South region sales where quantity is greater than 1.

## SQL

```sql
SELECT *
FROM Sales
WHERE Region = 'South'
  AND Quantity > 1;
```

## Pandas

```python
df[
    (df["Region"] == "South") &
    (df["Quantity"] > 1)
]
```

## NumPy

```python
data[
    (data[:, region_col] == "South") &
    (data[:, quantity_col] > 1)
]
```

### Operators

| Meaning   | SQL   | Pandas | NumPy |
| --------- | ----- | ------ | ----- |
| AND       | `AND` | `&`    | `&`   |
| OR        | `OR`  | `\|`   | `\|`  |
| NOT       | `NOT` | `~`    | `~`   |
| Equal     | `=`   | `==`   | `==`  |
| Not equal | `<>`  | `!=`   | `!=`  |
| Greater   | `>`   | `>`    | `>`   |
| Less      | `<`   | `<`    | `<`   |

---

# 9. IN

Question:

> Find sales from South or North.

## SQL

```sql
SELECT *
FROM Sales
WHERE Region IN ('South', 'North');
```

## Pandas

```python
df[df["Region"].isin(["South", "North"])]
```

## NumPy

```python
np.isin(regions, ["South", "North"])
```

---

# 10. BETWEEN

Question:

> Find quantities between 2 and 5.

## SQL

```sql
SELECT *
FROM Sales
WHERE Quantity BETWEEN 2 AND 5;
```

## Pandas

```python
df[df["Quantity"].between(2, 5)]
```

## NumPy

```python
data[(data[:, 1] >= 2) & (data[:, 1] <= 5)]
```

---

# 11. LIKE / String Filtering

Question:

> Find products beginning with "Lap".

## SQL

```sql
SELECT *
FROM Sales
WHERE Product LIKE 'Lap%';
```

## Pandas

```python
df[df["Product"].str.startswith("Lap")]
```

or:

```python
df[df["Product"].str.contains("Lap")]
```

---

# 12. Calculated Columns

Question:

> Calculate total sales.

Business formula:

```text
Sales = Quantity × Price
```

## SQL

```sql
SELECT
    Product,
    Quantity,
    Price,
    Quantity * Price AS Sales
FROM Sales;
```

## Pandas

```python
df["Sales"] = df["Quantity"] * df["Price"]
```

## NumPy

```python
sales = quantity * price
```

This is an important concept:

> **Vectorization means performing an operation on an entire column/array without explicitly writing a loop.**

---

# 13. CASE WHEN

Question:

> Classify orders as High or Low value.

Rule:

```text
Sales >= 50000 → High
otherwise      → Low
```

## SQL

```sql
SELECT
    OrderID,
    Quantity * Price AS Sales,
    CASE
        WHEN Quantity * Price >= 50000 THEN 'High'
        ELSE 'Low'
    END AS SalesCategory
FROM Sales;
```

## Pandas

```python
df["Sales"] = df["Quantity"] * df["Price"]

df["SalesCategory"] = np.where(
    df["Sales"] >= 50000,
    "High",
    "Low"
)
```

or:

```python
df.loc[df["Sales"] >= 50000, "SalesCategory"] = "High"
df.loc[df["Sales"] < 50000, "SalesCategory"] = "Low"
```

## NumPy

```python
category = np.where(
    sales >= 50000,
    "High",
    "Low"
)
```

### Translation

```text
CASE WHEN
     ↓
np.where()
     ↓
Boolean condition
```

---

# 14. NULL / Missing Values

Question:

> Find records where Region is missing.

## SQL

```sql
SELECT *
FROM Sales
WHERE Region IS NULL;
```

## Pandas

```python
df[df["Region"].isna()]
```

## NumPy

For numerical arrays:

```python
arr[np.isnan(arr)]
```

### Important

Never write:

```sql
WHERE Region = NULL
```

Use:

```sql
WHERE Region IS NULL
```

---

# 15. Sorting

Question:

> Sort sales from highest to lowest.

## SQL

```sql
SELECT *
FROM Sales
ORDER BY Quantity * Price DESC;
```

## Pandas

```python
df["Sales"] = df["Quantity"] * df["Price"]

df.sort_values(
    "Sales",
    ascending=False
)
```

## NumPy

```python
sorted_sales = np.sort(sales)[::-1]
```

To obtain indexes:

```python
idx = np.argsort(sales)[::-1]
```

---

# 16. LIMIT / TOP

Question:

> Find the top 3 orders by sales.

## SQL

PostgreSQL / MySQL:

```sql
SELECT *
FROM Sales
ORDER BY Quantity * Price DESC
LIMIT 3;
```

SQL Server:

```sql
SELECT TOP 3 *
FROM Sales
ORDER BY Quantity * Price DESC;
```

## Pandas

```python
df.nlargest(3, "Sales")
```

or:

```python
df.sort_values(
    "Sales",
    ascending=False
).head(3)
```

## NumPy

```python
idx = np.argsort(sales)[-3:][::-1]
top3 = sales[idx]
```

---

# 17. COUNT

Question:

> Count orders.

## SQL

```sql
SELECT COUNT(*)
FROM Sales;
```

## Pandas

```python
len(df)
```

or:

```python
df.shape[0]
```

## NumPy

```python
len(arr)
```

---

# 18. SUM

Question:

> Find total quantity sold.

## SQL

```sql
SELECT SUM(Quantity)
FROM Sales;
```

## Pandas

```python
df["Quantity"].sum()
```

## NumPy

```python
np.sum(quantity)
```

---

# 19. AVG / MEAN

Question:

> Find average price.

## SQL

```sql
SELECT AVG(Price)
FROM Sales;
```

## Pandas

```python
df["Price"].mean()
```

## NumPy

```python
np.mean(price)
```

---

# 20. MIN and MAX

## SQL

```sql
SELECT
    MIN(Price),
    MAX(Price)
FROM Sales;
```

## Pandas

```python
df["Price"].min()
df["Price"].max()
```

## NumPy

```python
np.min(price)
np.max(price)
```

---

# 21. GROUP BY

This is one of the most important SQL concepts.

Question:

> Find total sales by region.

## SQL

```sql
SELECT
    Region,
    SUM(Quantity * Price) AS TotalSales
FROM Sales
GROUP BY Region;
```

## Pandas

```python
df["Sales"] = df["Quantity"] * df["Price"]

df.groupby("Region")["Sales"].sum()
```

Better tabular output:

```python
df.groupby(
    "Region",
    as_index=False
)["Sales"].sum()
```

## NumPy

NumPy does not have a direct SQL-style `GROUP BY`.

You can use:

```python
for region in np.unique(regions):
    total = np.sum(
        sales[regions == region]
    )
```

This demonstrates an important principle:

> **Pandas is much closer to SQL than NumPy is for tabular analytics.**

---

# 22. GROUP BY Multiple Columns

Question:

> Find sales by Region and Category.

## SQL

```sql
SELECT
    Region,
    Category,
    SUM(Quantity * Price) AS TotalSales
FROM Sales
GROUP BY
    Region,
    Category;
```

## Pandas

```python
df.groupby(
    ["Region", "Category"],
    as_index=False
)["Sales"].sum()
```

---

# 23. Multiple Aggregations

Question:

> For each region calculate total sales, average price and order count.

## SQL

```sql
SELECT
    Region,
    SUM(Sales) AS TotalSales,
    AVG(Price) AS AvgPrice,
    COUNT(*) AS OrderCount
FROM Sales
GROUP BY Region;
```

## Pandas

```python
df.groupby("Region").agg(
    TotalSales=("Sales", "sum"),
    AvgPrice=("Price", "mean"),
    OrderCount=("OrderID", "count")
).reset_index()
```

---

# 24. HAVING

Question:

> Show regions where total sales exceed 50,000.

## SQL

```sql
SELECT
    Region,
    SUM(Sales) AS TotalSales
FROM Sales
GROUP BY Region
HAVING SUM(Sales) > 50000;
```

## Pandas

```python
result = (
    df.groupby("Region", as_index=False)
      ["Sales"]
      .sum()
)

result[result["Sales"] > 50000]
```

### Key Difference

```text
WHERE
↓
filters individual rows

HAVING
↓
filters aggregated groups
```

Pandas usually does this in two steps:

```text
groupby()
   ↓
aggregation
   ↓
filter
```

---

# 25. INNER JOIN

Assume we have:

## Customers

| CustomerID | CustomerName | City      |
| ---------- | ------------ | --------- |
| C01        | Arun         | Chennai   |
| C02        | Ravi         | Delhi     |
| C03        | Kumar        | Mumbai    |
| C04        | Priya        | Bangalore |

Question:

> Show order details with customer names.

## SQL

```sql
SELECT
    s.OrderID,
    s.Product,
    s.Quantity,
    c.CustomerName
FROM Sales s
INNER JOIN Customers c
    ON s.CustomerID = c.CustomerID;
```

## Pandas

```python
result = pd.merge(
    sales_df,
    customers_df,
    on="CustomerID",
    how="inner"
)
```

## NumPy

NumPy has no direct equivalent of:

```text
pd.merge()
```

You would generally need:

* indexing
* boolean matching
* structured arrays
* or convert the data into Pandas

For business data analysis:

> **Use Pandas for joins.**

---

# 26. JOIN Types

| SQL             | Pandas        |
| --------------- | ------------- |
| INNER JOIN      | `how="inner"` |
| LEFT JOIN       | `how="left"`  |
| RIGHT JOIN      | `how="right"` |
| FULL OUTER JOIN | `how="outer"` |

Example:

```python
pd.merge(
    sales_df,
    customers_df,
    on="CustomerID",
    how="left"
)
```

---

# 27. UNION

Question:

> Combine two datasets vertically.

## SQL

```sql
SELECT *
FROM Sales2025

UNION ALL

SELECT *
FROM Sales2026;
```

## Pandas

```python
pd.concat(
    [sales_2025, sales_2026],
    ignore_index=True
)
```

### Translation

```text
UNION ALL
    ↓
pd.concat()
```

---

# 28. UNION vs JOIN

This is critical.

### UNION

Adds rows:

```text
Table A
   ↓
Table B
   ↓
More rows
```

### JOIN

Adds columns:

```text
Table A + Table B
        ↓
More columns
```

Pandas:

```python
pd.concat()  # UNION-like
pd.merge()   # JOIN-like
```

---

# 29. String Functions

Question:

> Convert product names to uppercase.

## SQL

```sql
SELECT UPPER(Product)
FROM Sales;
```

## Pandas

```python
df["Product"].str.upper()
```

## NumPy

```python
np.char.upper(products)
```

---

# 30. Common String Operations

| Requirement | SQL            | Pandas              |
| ----------- | -------------- | ------------------- |
| Uppercase   | `UPPER()`      | `.str.upper()`      |
| Lowercase   | `LOWER()`      | `.str.lower()`      |
| Length      | `LENGTH()`     | `.str.len()`        |
| Starts with | `LIKE 'A%'`    | `.str.startswith()` |
| Contains    | `LIKE '%abc%'` | `.str.contains()`   |
| Replace     | `REPLACE()`    | `.str.replace()`    |
| Trim        | `TRIM()`       | `.str.strip()`      |

---

# 31. Date Functions

Question:

> Extract year from SalesDate.

## SQL

PostgreSQL:

```sql
SELECT
    EXTRACT(YEAR FROM SalesDate)
FROM Sales;
```

## Pandas

```python
df["SalesDate"] = pd.to_datetime(
    df["SalesDate"]
)

df["Year"] = df["SalesDate"].dt.year
```

## NumPy

```python
dates = np.array(
    ["2026-01-10", "2026-01-11"],
    dtype="datetime64[D]"
)
```

---

# 32. Date Components

| Requirement  | SQL                        | Pandas                 |
| ------------ | -------------------------- | ---------------------- |
| Year         | `YEAR()` / `EXTRACT()`     | `.dt.year`             |
| Month        | `MONTH()`                  | `.dt.month`            |
| Day          | `DAY()`                    | `.dt.day`              |
| Day name     | DB-specific                | `.dt.day_name()`       |
| Difference   | `DATEDIFF()` / DB-specific | subtraction            |
| Current date | `CURRENT_DATE`             | `pd.Timestamp.today()` |

---

# 33. Conditional Aggregation

Question:

> Calculate total sales for Electronics.

## SQL

```sql
SELECT
    SUM(
        CASE
            WHEN Category = 'Electronics'
            THEN Sales
            ELSE 0
        END
    ) AS ElectronicsSales
FROM Sales;
```

## Pandas

```python
df.loc[
    df["Category"] == "Electronics",
    "Sales"
].sum()
```

## NumPy

```python
np.sum(
    sales[category == "Electronics"]
)
```

---

# 34. Ranking

Question:

> Rank products based on sales.

## SQL

```sql
SELECT
    Product,
    Sales,
    RANK() OVER (
        ORDER BY Sales DESC
    ) AS SalesRank
FROM Sales;
```

## Pandas

```python
df["SalesRank"] = (
    df["Sales"]
      .rank(
          ascending=False,
          method="min"
      )
)
```

## NumPy

```python
order = np.argsort(sales)[::-1]

rank = np.empty_like(order)
rank[order] = np.arange(1, len(sales) + 1)
```

---

# 35. ROW_NUMBER

SQL:

```sql
SELECT
    Product,
    Sales,
    ROW_NUMBER() OVER (
        ORDER BY Sales DESC
    ) AS RowNum
FROM Sales;
```

Pandas:

```python
df = df.sort_values(
    "Sales",
    ascending=False
)

df["RowNum"] = range(1, len(df) + 1)
```

---

# 36. PARTITION BY

Question:

> Rank products within each region.

## SQL

```sql
SELECT
    Region,
    Product,
    Sales,
    RANK() OVER (
        PARTITION BY Region
        ORDER BY Sales DESC
    ) AS RegionRank
FROM Sales;
```

## Pandas

```python
df["RegionRank"] = (
    df.groupby("Region")["Sales"]
      .rank(
          ascending=False,
          method="min"
      )
)
```

This is an extremely useful translation:

```text
SQL

PARTITION BY Region
ORDER BY Sales DESC

        ↓

Pandas

groupby("Region")
rank(ascending=False)
```

---

# 37. Running Total

Question:

> Calculate cumulative sales.

## SQL

```sql
SELECT
    SalesDate,
    Sales,
    SUM(Sales) OVER (
        ORDER BY SalesDate
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS RunningSales
FROM Sales;
```

## Pandas

```python
df = df.sort_values("SalesDate")

df["RunningSales"] = df["Sales"].cumsum()
```

## NumPy

```python
running_sales = np.cumsum(sales)
```

---

# 38. LAG

Question:

> Compare today's sales with the previous day's sales.

## SQL

```sql
SELECT
    SalesDate,
    Sales,
    LAG(Sales) OVER (
        ORDER BY SalesDate
    ) AS PreviousSales
FROM Sales;
```

## Pandas

```python
df["PreviousSales"] = df["Sales"].shift(1)
```

### Important Translation

```text
LAG()
 ↓
shift()
```

---

# 39. LEAD

SQL:

```sql
LEAD(Sales) OVER (
    ORDER BY SalesDate
)
```

Pandas:

```python
df["NextSales"] = df["Sales"].shift(-1)
```

---

# 40. Difference From Previous Row

SQL:

```sql
SELECT
    Sales,
    Sales - LAG(Sales) OVER (
        ORDER BY SalesDate
    ) AS Difference
FROM Sales;
```

Pandas:

```python
df["Difference"] = (
    df["Sales"] -
    df["Sales"].shift(1)
)
```

NumPy:

```python
difference = np.diff(sales)
```

---

# 41. Percentage Change

Pandas:

```python
df["PctChange"] = df["Sales"].pct_change() * 100
```

NumPy:

```python
pct_change = (
    np.diff(sales) /
    sales[:-1]
) * 100
```

SQL:

```sql
SELECT
    Sales,
    (
        Sales -
        LAG(Sales) OVER (ORDER BY SalesDate)
    )
    /
    NULLIF(
        LAG(Sales) OVER (ORDER BY SalesDate),
        0
    ) * 100 AS PctChange
FROM Sales;
```

---

# 42. Subquery

Question:

> Find orders whose sales are greater than average sales.

## SQL

```sql
SELECT *
FROM Sales
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM Sales
);
```

## Pandas

```python
avg_sales = df["Sales"].mean()

df[df["Sales"] > avg_sales]
```

## NumPy

```python
avg_sales = np.mean(sales)

sales[sales > avg_sales]
```

### Pattern

```text
SQL subquery
     ↓
Calculate intermediate value
     ↓
Use it in outer query
```

In Pandas/NumPy, this is often explicit as a Python variable.

---

# 43. CTE

SQL:

```sql
WITH RegionSales AS
(
    SELECT
        Region,
        SUM(Sales) AS TotalSales
    FROM Sales
    GROUP BY Region
)
SELECT *
FROM RegionSales
WHERE TotalSales > 50000;
```

Pandas equivalent:

```python
region_sales = (
    df.groupby(
        "Region",
        as_index=False
    )["Sales"]
    .sum()
)

result = region_sales[
    region_sales["Sales"] > 50000
]
```

### Concept

```text
CTE
 ↓
Create intermediate result
 ↓
Use intermediate result
```

Pandas naturally supports this through variables.

---

# 44. Derived Tables

SQL:

```sql
SELECT *
FROM
(
    SELECT
        Region,
        SUM(Sales) AS TotalSales
    FROM Sales
    GROUP BY Region
) x
WHERE TotalSales > 50000;
```

Pandas:

```python
temp = (
    df.groupby("Region", as_index=False)
      ["Sales"]
      .sum()
)

result = temp[temp["Sales"] > 50000]
```

---

# 45. Pivot

Question:

> Show total sales by region and category.

## SQL

Database-specific pivot syntax varies, but conditional aggregation is portable:

```sql
SELECT
    Region,
    SUM(
        CASE WHEN Category = 'Electronics'
             THEN Sales ELSE 0 END
    ) AS Electronics,
    SUM(
        CASE WHEN Category = 'Furniture'
             THEN Sales ELSE 0 END
    ) AS Furniture
FROM Sales
GROUP BY Region;
```

## Pandas

```python
pd.pivot_table(
    df,
    values="Sales",
    index="Region",
    columns="Category",
    aggfunc="sum"
)
```

## NumPy

Reshaping can be done with:

```python
arr.reshape(...)
```

but NumPy does not provide the same high-level pivot-table functionality.

---

# 46. Reshape

NumPy is extremely strong here.

Suppose:

```python
arr = np.arange(12)
```

Result:

```text
[0 1 2 3 4 5 6 7 8 9 10 11]
```

Reshape:

```python
arr.reshape(3, 4)
```

Result:

```text
0   1   2   3
4   5   6   7
8   9  10  11
```

Pandas:

```python
df.pivot(...)
```

SQL:

```text
PIVOT / conditional aggregation
```

---

# 47. Axis

NumPy introduces an important concept:

```text
axis=0 → operate vertically / down rows
axis=1 → operate horizontally / across columns
```

Example:

```python
arr.sum(axis=0)
```

Column totals.

```python
arr.sum(axis=1)
```

Row totals.

Pandas:

```python
df.sum(axis=0)
df.sum(axis=1)
```

SQL does not normally expose an `axis` concept because aggregation is expressed through columns, rows and groups.

---

# 48. NumPy Broadcasting

Suppose:

```python
prices = np.array([100, 200, 300])
```

Add 10%:

```python
prices * 1.10
```

Result:

```text
[110, 220, 330]
```

No loop required.

Pandas:

```python
df["Price"] * 1.10
```

SQL:

```sql
SELECT Price * 1.10
FROM Sales;
```

Same business logic.

---

# 49. Mathematical Functions

| Operation          | SQL         | Pandas     | NumPy        |
| ------------------ | ----------- | ---------- | ------------ |
| Sum                | `SUM()`     | `.sum()`   | `np.sum()`   |
| Average            | `AVG()`     | `.mean()`  | `np.mean()`  |
| Minimum            | `MIN()`     | `.min()`   | `np.min()`   |
| Maximum            | `MAX()`     | `.max()`   | `np.max()`   |
| Standard deviation | DB-specific | `.std()`   | `np.std()`   |
| Variance           | DB-specific | `.var()`   | `np.var()`   |
| Absolute           | `ABS()`     | `.abs()`   | `np.abs()`   |
| Round              | `ROUND()`   | `.round()` | `np.round()` |
| Square root        | `SQRT()`    | NumPy      | `np.sqrt()`  |
| Power              | `POWER()`   | `**`       | `np.power()` |

---

# 50. Missing Value Replacement

Question:

> Replace missing price with zero.

SQL:

```sql
SELECT
    COALESCE(Price, 0)
FROM Sales;
```

Pandas:

```python
df["Price"].fillna(0)
```

NumPy:

```python
np.nan_to_num(arr, nan=0)
```

### Translation

```text
COALESCE()
   ↓
fillna()
   ↓
nan_to_num()
```

---

# 51. Duplicate Records

Question:

> Remove duplicate rows.

SQL:

```sql
SELECT DISTINCT *
FROM Sales;
```

Pandas:

```python
df.drop_duplicates()
```

NumPy:

```python
np.unique(arr, axis=0)
```

---

# 52. Conditional Filtering Framework

When you see:

> "Find records where..."

Think:

```text
SQL       → WHERE
Pandas    → df[condition]
NumPy     → arr[condition]
```

Examples:

```text
Greater than
Equal to
Contains
Starts with
Between
IN
NULL
Multiple conditions
```

---

# 53. Aggregation Framework

When you see:

> "Calculate total/average/count for each..."

Think:

```text
SQL       → GROUP BY
Pandas    → groupby()
NumPy     → unique + masking / aggregation
```

Examples:

```text
Total sales by region
Average salary by department
Count customers by city
Maximum price by category
```

---

# 54. Ranking Framework

When you see:

> "Top N"

Think:

```text
SQL       → ORDER BY + LIMIT/TOP
Pandas    → sort_values() + head()
NumPy     → argsort()
```

When you see:

> "Rank within each group"

Think:

```text
SQL       → RANK() OVER(PARTITION BY ...)
Pandas    → groupby().rank()
NumPy     → argsort + grouping logic
```

---

# 55. Previous / Next Row Framework

When you see:

> "Previous value"

Think:

```text
SQL       → LAG()
Pandas    → shift(1)
NumPy     → slicing
```

When you see:

> "Next value"

Think:

```text
SQL       → LEAD()
Pandas    → shift(-1)
NumPy     → slicing
```

---

# 56. Running Calculation Framework

When you see:

> "Cumulative / running..."

Think:

```text
SQL       → Window Function
Pandas    → cumsum()
NumPy     → np.cumsum()
```

Examples:

```text
Running sales
Running quantity
Cumulative customers
Cumulative revenue
```

---

# 57. Joining Framework

When you see:

> "Combine information from two tables"

Think:

```text
SQL       → JOIN
Pandas    → merge()
NumPy     → usually not the right tool
```

---

# 58. Vertical Combination Framework

When you see:

> "Append one dataset below another"

Think:

```text
SQL       → UNION ALL
Pandas    → concat()
NumPy     → concatenate()
```

NumPy:

```python
np.concatenate(
    [arr1, arr2],
    axis=0
)
```

---

# 59. SQL → Pandas → NumPy Cheat Sheet

| Business Requirement | SQL            | Pandas                  | NumPy             |
| -------------------- | -------------- | ----------------------- | ----------------- |
| Select columns       | `SELECT`       | `df[]`                  | indexing          |
| Filter               | `WHERE`        | `df[condition]`         | masking           |
| Unique               | `DISTINCT`     | `unique()`              | `np.unique()`     |
| Sort                 | `ORDER BY`     | `sort_values()`         | `sort()`          |
| Top N                | `LIMIT`        | `head()` / `nlargest()` | `argsort()`       |
| Count                | `COUNT()`      | `count()` / `len()`     | `len()`           |
| Sum                  | `SUM()`        | `sum()`                 | `np.sum()`        |
| Average              | `AVG()`        | `mean()`                | `np.mean()`       |
| Min                  | `MIN()`        | `min()`                 | `np.min()`        |
| Max                  | `MAX()`        | `max()`                 | `np.max()`        |
| Group                | `GROUP BY`     | `groupby()`             | manual            |
| Group filter         | `HAVING`       | filter after groupby    | manual            |
| Join                 | `JOIN`         | `merge()`               | manual            |
| Union                | `UNION ALL`    | `concat()`              | `concatenate()`   |
| Conditional          | `CASE`         | `loc` / `np.where()`    | `np.where()`      |
| Null check           | `IS NULL`      | `isna()`                | `isnan()`         |
| Fill null            | `COALESCE()`   | `fillna()`              | `nan_to_num()`    |
| Rank                 | `RANK()`       | `rank()`                | `argsort()`       |
| Previous             | `LAG()`        | `shift(1)`              | slicing           |
| Next                 | `LEAD()`       | `shift(-1)`             | slicing           |
| Running total        | Window `SUM()` | `cumsum()`              | `np.cumsum()`     |
| Pivot                | `PIVOT`        | `pivot_table()`         | reshape/manual    |
| String upper         | `UPPER()`      | `.str.upper()`          | `np.char.upper()` |
| String lower         | `LOWER()`      | `.str.lower()`          | `np.char.lower()` |

---

# 60. The Most Important Mental Model

Instead of memorizing hundreds of functions, memorize this:

```text
                    BUSINESS QUESTION
                           |
              +------------+------------+
              |            |            |
           FILTER       TRANSFORM     AGGREGATE
              |            |            |
            WHERE       CASE          GROUP BY
              |            |            |
           Boolean      np.where()     groupby()
           indexing     loc            aggregate
              |
              +-------------------------------+
                              |
                            SORT
                              |
                         ORDER BY
                              |
                        sort_values()
                              |
                            RANK
                              |
                         WINDOW
                              |
                    RANK / LAG / LEAD
                              |
                       rank / shift
```

---

# 61. The 7-Level Problem-Solving Framework

Use this framework when solving problems.

## Level 1 — Basic Filtering

Keywords:

```text
find
where
greater than
less than
equals
contains
```

Use:

```text
SQL    → WHERE
Pandas → Boolean filtering
NumPy  → Boolean masking
```

---

## Level 2 — Aggregation

Keywords:

```text
total
average
count
minimum
maximum
by each
per
```

Use:

```text
SQL    → GROUP BY
Pandas → groupby()
NumPy  → aggregation
```

---

## Level 3 — Multiple Tables

Keywords:

```text
customer information
product information
employee information
combine
match
```

Use:

```text
SQL    → JOIN
Pandas → merge()
```

---

## Level 4 — Subquery / Intermediate Calculation

Keywords:

```text
above average
below average
greater than total
compare with overall
```

Use:

```text
SQL    → Subquery / CTE
Pandas → intermediate DataFrame/variable
NumPy  → intermediate array/value
```

---

## Level 5 — Window Analysis

Keywords:

```text
previous
next
running
cumulative
rank
top within each
previous month
```

Use:

```text
SQL    → Window Functions
Pandas → shift(), rank(), cumsum()
NumPy  → cumulative functions / indexing
```

---

## Level 6 — Complex Combination

Example:

> Find the top-selling product in every region.

Break it down:

```text
1. Calculate Sales
2. Group by Region + Product
3. Calculate total sales
4. Rank products within Region
5. Select rank = 1
```

SQL:

```sql
WITH ProductSales AS
(
    SELECT
        Region,
        Product,
        SUM(Sales) AS TotalSales
    FROM Sales
    GROUP BY
        Region,
        Product
),
Ranked AS
(
    SELECT
        *,
        RANK() OVER (
            PARTITION BY Region
            ORDER BY TotalSales DESC
        ) AS rnk
    FROM ProductSales
)
SELECT *
FROM Ranked
WHERE rnk = 1;
```

Pandas:

```python
product_sales = (
    df.groupby(
        ["Region", "Product"],
        as_index=False
    )["Sales"]
    .sum()
)

product_sales["Rank"] = (
    product_sales
    .groupby("Region")["Sales"]
    .rank(
        ascending=False,
        method="min"
    )
)

result = product_sales[
    product_sales["Rank"] == 1
]
```

---

# 62. Level 7 — Real-World Data Problem

Question:

> For every region, find the top customer by total sales, show their sales, compare it with the regional average customer sales, and calculate the percentage difference.

Break the problem down:

```text
STEP 1
Calculate order-level sales

STEP 2
Group by Region + Customer

STEP 3
Calculate customer total sales

STEP 4
Calculate regional average

STEP 5
Rank customers within region

STEP 6
Keep rank = 1

STEP 7
Calculate percentage difference
```

This is the fundamental approach to complex analytics:

> **Never attack a complex problem as one giant query. Break it into logical layers.**

---

# 63. SQL Layering Pattern

A complex SQL solution often looks like:

```text
Raw Data
   ↓
CTE 1
   ↓
CTE 2
   ↓
CTE 3
   ↓
Window Function
   ↓
Final Filter
```

Example:

```sql
WITH OrderLevel AS
(
    SELECT
        *,
        Quantity * Price AS Sales
    FROM Sales
),
CustomerSales AS
(
    SELECT
        Region,
        CustomerID,
        SUM(Sales) AS TotalSales
    FROM OrderLevel
    GROUP BY
        Region,
        CustomerID
),
Ranked AS
(
    SELECT
        *,
        RANK() OVER (
            PARTITION BY Region
            ORDER BY TotalSales DESC
        ) AS rnk
    FROM CustomerSales
)
SELECT *
FROM Ranked
WHERE rnk = 1;
```

---

# 64. Pandas Layering Pattern

The equivalent Pandas approach:

```python
# Layer 1
df["Sales"] = (
    df["Quantity"] *
    df["Price"]
)

# Layer 2
customer_sales = (
    df.groupby(
        ["Region", "CustomerID"],
        as_index=False
    )["Sales"]
    .sum()
)

# Layer 3
customer_sales["Rank"] = (
    customer_sales
    .groupby("Region")["Sales"]
    .rank(
        ascending=False,
        method="min"
    )
)

# Layer 4
result = customer_sales[
    customer_sales["Rank"] == 1
]
```

---

# 65. NumPy Layering Pattern

```python
sales = quantity * price

regions_unique = np.unique(regions)

for region in regions_unique:

    mask = regions == region

    region_sales = sales[mask]

    total = np.sum(region_sales)

    average = np.mean(region_sales)

    print(
        region,
        total,
        average
    )
```

NumPy can perform this work, but the code becomes more manual.

---

# 66. When Should I Use SQL?

Use SQL when:

```text
Data is already in a database
        +
Data is large
        +
You need filtering
        +
You need joins
        +
You need aggregation
        +
You need data extraction
```

Example:

```text
10 billion rows
        ↓
Database
        ↓
SQL
        ↓
Return 100,000 relevant rows
        ↓
Pandas
```

This is often much better than loading 10 billion rows into Pandas.

---

# 67. When Should I Use Pandas?

Use Pandas when:

```text
Data is tabular
        +
You need analysis
        +
You need cleaning
        +
You need joins
        +
You need grouping
        +
You need exploratory analysis
        +
Data fits reasonably in memory
```

Typical workflow:

```text
SQL
 ↓
Extract
 ↓
Pandas
 ↓
Clean
 ↓
Transform
 ↓
Analyze
 ↓
Visualize
```

---

# 68. When Should I Use NumPy?

Use NumPy when:

```text
Numerical computation
        +
Arrays
        +
Matrix operations
        +
Vectorization
        +
Scientific calculations
        +
Machine learning preprocessing
```

Typical relationship:

```text
Pandas
   ↓
built heavily around array-based computation
   ↓
NumPy
```

---

# 69. Real Data Engineering Workflow

A Data Engineer might use all three:

```text
                 DATABASE
                    |
                  SQL
                    |
              Extract Data
                    |
                    ↓
                Pandas
                    |
          Clean / Transform
                    |
                    ↓
                 NumPy
                    |
          Numerical Computation
                    |
                    ↓
              ML / Analytics
```

In modern systems, there may also be:

```text
SQL
 ↓
Spark SQL
 ↓
PySpark
 ↓
Pandas
 ↓
NumPy
```

---

# 70. SQL vs Pandas vs NumPy — Strengths

| Area                           |   SQL | Pandas | NumPy |
| ------------------------------ | ----: | -----: | ----: |
| Database querying              | ⭐⭐⭐⭐⭐ |     ⭐⭐ |     ⭐ |
| Large datasets in DB           | ⭐⭐⭐⭐⭐ |     ⭐⭐ |     ⭐ |
| Tabular analysis               |  ⭐⭐⭐⭐ |  ⭐⭐⭐⭐⭐ |    ⭐⭐ |
| Data cleaning                  |   ⭐⭐⭐ |  ⭐⭐⭐⭐⭐ |    ⭐⭐ |
| Joins                          | ⭐⭐⭐⭐⭐ |  ⭐⭐⭐⭐⭐ |     ⭐ |
| Grouping                       | ⭐⭐⭐⭐⭐ |  ⭐⭐⭐⭐⭐ |   ⭐⭐⭐ |
| Numerical computation          |   ⭐⭐⭐ |   ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Matrix operations              |     ⭐ |    ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Exploratory analysis           |   ⭐⭐⭐ |  ⭐⭐⭐⭐⭐ |   ⭐⭐⭐ |
| Machine-learning preprocessing |   ⭐⭐⭐ |  ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

These are capability comparisons, not absolute rules; the right choice depends on data size, location, workflow and performance requirements.

---

# 71. The Translation Dictionary

Memorize these first.

```text
SELECT columns
        ↓
df[columns]

WHERE
        ↓
df[condition]

DISTINCT
        ↓
unique()

ORDER BY
        ↓
sort_values()

GROUP BY
        ↓
groupby()

HAVING
        ↓
filter after groupby

JOIN
        ↓
merge()

UNION ALL
        ↓
concat()

CASE WHEN
        ↓
np.where() / loc

COUNT
        ↓
count()

SUM
        ↓
sum()

AVG
        ↓
mean()

MIN
        ↓
min()

MAX
        ↓
max()

RANK
        ↓
rank()

LAG
        ↓
shift(1)

LEAD
        ↓
shift(-1)

Running SUM
        ↓
cumsum()

NULL
        ↓
NaN / None

IS NULL
        ↓
isna()

COALESCE
        ↓
fillna()

PIVOT
        ↓
pivot_table()
```

---

# 72. The "What Function Should I Use?" Rule

Whenever you receive a problem statement, underline the action words.

### Example

> Find the **total sales** **for each region**, **sort them descending**, and **show the top 3**.

Identify:

```text
total
 ↓
SUM

for each region
 ↓
GROUP BY Region

sort descending
 ↓
ORDER BY DESC

top 3
 ↓
LIMIT 3
```

Therefore:

```sql
GROUP BY
+
SUM
+
ORDER BY
+
LIMIT
```

Pandas:

```python
groupby()
+
sum()
+
sort_values()
+
head()
```

NumPy:

```python
mask/grouping
+
sum()
+
argsort()
+
slicing
```

---

# 73. Another Example

Question:

> Find customers whose total sales are greater than the average customer sales.

Underline:

```text
total sales
    ↓
GROUP BY Customer

average customer sales
    ↓
AVG()

greater than average
    ↓
Subquery / intermediate result
```

SQL:

```sql
WITH CustomerSales AS
(
    SELECT
        CustomerID,
        SUM(Sales) AS TotalSales
    FROM Sales
    GROUP BY CustomerID
)
SELECT *
FROM CustomerSales
WHERE TotalSales >
(
    SELECT AVG(TotalSales)
    FROM CustomerSales
);
```

Pandas:

```python
customer_sales = (
    df.groupby(
        "CustomerID",
        as_index=False
    )["Sales"]
    .sum()
)

avg_sales = customer_sales["Sales"].mean()

result = customer_sales[
    customer_sales["Sales"] > avg_sales
]
```

NumPy:

```python
customers = np.unique(customer_ids)

customer_totals = np.array([
    sales[customer_ids == c].sum()
    for c in customers
])

average = customer_totals.mean()

result = customer_totals[
    customer_totals > average
]
```

---

# 74. Common Mistakes

## Mistake 1 — Using the wrong tool

Trying to perform complex database joins in NumPy.

Better:

```text
Database → SQL
Tabular analysis → Pandas
Numerical calculations → NumPy
```

---

## Mistake 2 — Forgetting output grain

Before writing SQL/Pandas code ask:

> "One row in my final result represents what?"

Examples:

```text
One row = Order
One row = Customer
One row = Region
One row = Region + Product
One row = Customer + Month
```

This single question prevents many analytical mistakes.

---

# 75. The Grain Rule

Suppose the question says:

> Total sales per customer per month.

Output grain:

```text
Customer + Month
```

Therefore:

SQL:

```sql
GROUP BY CustomerID, Month
```

Pandas:

```python
groupby(
    ["CustomerID", "Month"]
)
```

NumPy:

```text
Need grouping by CustomerID + Month
```

Always identify grain before choosing functions.

---

# 76. The Golden SQL → Pandas → NumPy Flow

```text
              PROBLEM STATEMENT
                      |
                      ↓
              Identify OUTPUT GRAIN
                      |
                      ↓
             Identify required columns
                      |
                      ↓
            Identify required operation
                      |
          +-----------+-----------+
          |           |           |
       FILTER     AGGREGATE    TRANSFORM
          |           |           |
        WHERE      GROUP BY     CASE
          |           |           |
          ↓           ↓           ↓
       Pandas      groupby()   np.where()
       Boolean
          |
          +-------------------------------+
                                          |
                                      Multiple Tables?
                                          |
                                          ↓
                                      JOIN / merge
                                          |
                                          ↓
                                      Need ranking?
                                          |
                                          ↓
                                  Window / rank()
                                          |
                                          ↓
                                      Sort / Top N
                                          |
                                          ↓
                                    FINAL RESULT
```

---

# 77. Final Cheat Sheet

## FILTER

```sql
WHERE
```

```python
df[df["col"] > value]
```

```python
arr[arr > value]
```

---

## SELECT

```sql
SELECT A, B
```

```python
df[["A", "B"]]
```

```python
arr[:, [0, 1]]
```

---

## AGGREGATE

```sql
SUM()
AVG()
COUNT()
MIN()
MAX()
```

```python
sum()
mean()
count()
min()
max()
```

```python
np.sum()
np.mean()
np.size()
np.min()
np.max()
```

---

## GROUP

```sql
GROUP BY
```

```python
groupby()
```

```python
unique() + masking
```

---

## JOIN

```sql
JOIN
```

```python
merge()
```

```text
NumPy → generally avoid for relational joins
```

---

## CONDITIONAL

```sql
CASE WHEN
```

```python
np.where()
```

```python
np.where()
```

---

## SORT

```sql
ORDER BY
```

```python
sort_values()
```

```python
np.sort()
np.argsort()
```

---

## RANK

```sql
RANK() OVER()
```

```python
rank()
```

```python
argsort()
```

---

## PREVIOUS ROW

```sql
LAG()
```

```python
shift(1)
```

```python
arr[:-1]
```

---

## RUNNING TOTAL

```sql
SUM() OVER()
```

```python
cumsum()
```

```python
np.cumsum()
```

---

# 78. Final Learning Strategy

Do **not** learn SQL, Pandas and NumPy as three completely separate subjects.

Instead learn them as:

```text
                 ONE CONCEPT
                     |
        +------------+------------+
        |            |            |
       SQL         Pandas       NumPy
        |            |            |
      Syntax       Syntax       Syntax
```

For every concept ask:

```text
1. What does this operation mean?
2. How does SQL express it?
3. How does Pandas express it?
4. How does NumPy express it?
5. When is each tool appropriate?
```

---

# 79. Recommended Learning Order

## Phase 1 — Basic Operations

Learn:

```text
SELECT
Filtering
Columns
Sorting
Unique
Calculated columns
```

Then immediately practice:

```text
SQL
Pandas
NumPy
```

---

## Phase 2 — Aggregation

Learn:

```text
COUNT
SUM
AVG
MIN
MAX
GROUP BY
HAVING
```

---

## Phase 3 — Data Combination

Learn:

```text
JOIN
UNION
CONCAT
MERGE
```

---

## Phase 4 — Transformation

Learn:

```text
CASE
np.where()
loc
String operations
Date operations
NULL handling
```

---

## Phase 5 — Advanced Analytics

Learn:

```text
Subqueries
CTEs
Window Functions
RANK
ROW_NUMBER
LAG
LEAD
Running totals
Moving averages
```

---

## Phase 6 — NumPy Deep Dive

Learn:

```text
Arrays
Indexing
Slicing
Boolean masking
Vectorization
Broadcasting
Axis
Reshape
Transpose
Stacking
Sorting
Statistics
```

---

## Phase 7 — Pandas Deep Dive

Learn:

```text
DataFrame
Series
loc
iloc
groupby
merge
concat
pivot
melt
apply
map
transform
rolling
shift
rank
missing values
datetime
```

---

# 80. The One-Page Mental Model

Finally, remember this:

```text
SQL
│
├── SELECT       → choose columns
├── WHERE        → filter rows
├── GROUP BY     → group rows
├── HAVING       → filter groups
├── JOIN         → combine tables
├── ORDER BY     → sort
├── CASE         → conditional logic
├── WINDOW       → row-aware analytics
└── CTE          → intermediate result


PANDAS
│
├── df[]         → choose/filter
├── groupby()    → group
├── merge()      → join
├── concat()     → union/append
├── sort_values()→ sort
├── np.where()   → conditional logic
├── rank()       → ranking
├── shift()      → previous/next
├── cumsum()     → running total
└── pivot_table()→ pivot


NUMPY
│
├── indexing     → choose
├── masking      → filter
├── sum()        → aggregate
├── mean()       → average
├── where()      → conditional
├── sort()       → sort
├── argsort()    → ranking/order
├── cumsum()     → running calculation
├── reshape()    → reshape
├── transpose()  → transpose
└── broadcasting → vectorized calculations
```

# The Core Principle

> **Don't memorize functions. Recognize operations.**

If you understand:

```text
FILTER
TRANSFORM
AGGREGATE
JOIN
SORT
RANK
WINDOW
RESHAPE
```

then learning the syntax of SQL, Pandas and NumPy becomes dramatically easier.

The real skill is:

```text
PROBLEM
   ↓
OPERATION
   ↓
TECHNIQUE
   ↓
FUNCTION
   ↓
CODE
   ↓
VALIDATE
```

That is the common problem-solving framework behind **SQL + Pandas + NumPy**.
