# ---

# **Pandas — Full Cheat Sheet**

---

## **1\. Import Pandas**

import pandas as pd  
import numpy as np  
---

# **2\. Create a DataFrame**

### **From Dictionary**

data \= {  
    "name": \["Alice", "Bob", "Charlie"\],  
    "age": \[25, 30, 35\],  
    "salary": \[50000, 60000, 70000\]  
}

df \= pd.DataFrame(data)

### **From List**

data \= \[  
    \["Alice", 25, 50000\],  
    \["Bob", 30, 60000\],  
    \["Charlie", 35, 70000\]  
\]

df \= pd.DataFrame(  
    data,  
    columns=\["name", "age", "salary"\]  
)  
---

# **3\. Read Data**

| Requirement | Pandas |
| ----- | ----- |
| CSV | `pd.read_csv()` |
| Excel | `pd.read_excel()` |
| JSON | `pd.read_json()` |
| SQL | `pd.read_sql()` |
| Parquet | `pd.read_parquet()` |

df \= pd.read\_csv("employees.csv")  
df \= pd.read\_excel("employees.xlsx")  
df \= pd.read\_json("employees.json")  
---

# **4\. Write Data**

df.to\_csv("output.csv", index=False)  
df.to\_excel("output.xlsx", index=False)  
df.to\_json("output.json")  
---

# **5\. Understand the Data**

## **First rows**

df.head()  
df.head(10)

## **Last rows**

df.tail()

## **Number of rows and columns**

df.shape

Example:

(1000, 8\)

Means:

1000 rows  
8 columns

## **Column names**

df.columns

## **Data types**

df.dtypes

## **Complete summary**

df.info()

## **Statistical summary**

df.describe()  
---

# **6\. Selecting Columns**

## **One column**

df\["salary"\]

## **Multiple columns**

df\[\["name", "salary"\]\]

### **SQL equivalent**

SELECT name, salary  
FROM employees;  
---

# **7\. Selecting Rows**

## **By position — `iloc`**

df.iloc\[0\]  
df.iloc\[0:5\]  
df.iloc\[0:5, 0:3\]

Think:

iloc \= integer location  
---

## **By label — `loc`**

df.loc\[0\]  
df.loc\[0:5, \["name", "salary"\]\]  
---

# **8\. Filtering Rows**

## **One condition**

df\[df\["salary"\] \> 60000\]

### **SQL**

SELECT \*  
FROM employees  
WHERE salary \> 60000;  
---

## **Multiple conditions**

df\[  
    (df\["salary"\] \> 60000\) &  
    (df\["age"\] \> 30\)  
\]

### **SQL**

WHERE salary \> 60000  
AND age \> 30  
---

## **OR**

df\[  
    (df\["department"\] \== "IT") |  
    (df\["department"\] \== "HR")  
\]  
---

## **NOT**

df\[df\["department"\] \!= "IT"\]  
---

# **9\. `isin()`**

df\[df\["department"\].isin(\["IT", "HR", "Finance"\])\]

### **SQL**

WHERE department IN ('IT', 'HR', 'Finance')  
---

# **10\. `between()`**

df\[df\["salary"\].between(50000, 80000)\]

### **SQL**

WHERE salary BETWEEN 50000 AND 80000  
---

# **11\. String Filtering**

## **Contains**

df\[df\["name"\].str.contains("an")\]

## **Starts with**

df\[df\["name"\].str.startswith("A")\]

## **Ends with**

df\[df\["name"\].str.endswith("n")\]  
---

# **12\. Sorting**

## **Ascending**

df.sort\_values("salary")

## **Descending**

df.sort\_values("salary", ascending=False)

## **Multiple columns**

df.sort\_values(  
    \["department", "salary"\],  
    ascending=\[True, False\]  
)

### **SQL**

ORDER BY department ASC, salary DESC;  
---

# **13\. Rename Columns**

df.rename(  
    columns={  
        "salary": "annual\_salary"  
    }  
)

Rename permanently:

df.rename(  
    columns={"salary": "annual\_salary"},  
    inplace=True  
)  
---

# **14\. Create New Columns**

df\["bonus"\] \= df\["salary"\] \* 0.10  
df\["total\_salary"\] \= (  
    df\["salary"\] \+ df\["bonus"\]  
)

### **SQL**

SELECT  
    salary,  
    salary \* 0.10 AS bonus,  
    salary \+ salary \* 0.10 AS total\_salary  
FROM employees;  
---

# **15\. Conditional Column — `np.where`**

df\["status"\] \= np.where(  
    df\["salary"\] \>= 70000,  
    "High",  
    "Low"  
)

### **SQL equivalent**

CASE  
    WHEN salary \>= 70000 THEN 'High'  
    ELSE 'Low'  
END  
---

# **16\. Multiple Conditions — `np.select`**

conditions \= \[  
    df\["salary"\] \>= 90000,  
    df\["salary"\] \>= 60000,  
    df\["salary"\] \< 60000  
\]

choices \= \[  
    "High",  
    "Medium",  
    "Low"  
\]

df\["salary\_band"\] \= np.select(  
    conditions,  
    choices,  
    default="Unknown"  
)  
---

# **17\. Missing Values**

## **Check missing values**

df.isna()

## **Count missing values**

df.isna().sum()

## **Percentage missing**

df.isna().mean() \* 100  
---

# **18\. Drop Missing Values**

df.dropna()

Specific column:

df.dropna(subset=\["salary"\])  
---

# **19\. Fill Missing Values**

df\["salary"\] \= df\["salary"\].fillna(0)

With mean:

df\["salary"\] \= df\["salary"\].fillna(  
    df\["salary"\].mean()  
)

With median:

df\["salary"\] \= df\["salary"\].fillna(  
    df\["salary"\].median()  
)  
---

# **20\. Remove Duplicates**

df.drop\_duplicates()

Specific columns:

df.drop\_duplicates(  
    subset=\["customer\_id"\]  
)

Keep latest:

df.drop\_duplicates(  
    subset=\["customer\_id"\],  
    keep="last"  
)  
---

# **21\. Unique Values**

df\["department"\].unique()

Count unique values:

df\["department"\].nunique()

Frequency:

df\["department"\].value\_counts()

### **SQL**

SELECT department, COUNT(\*)  
FROM employees  
GROUP BY department;  
---

# **22\. Aggregation**

df\["salary"\].sum()  
df\["salary"\].mean()  
df\["salary"\].min()  
df\["salary"\].max()  
df\["salary"\].count()  
df\["salary"\].median()  
---

# **23\. `groupby()` ⭐**

This is one of the **most important Pandas concepts**.

df.groupby("department")\["salary"\].sum()

### **SQL**

SELECT  
    department,  
    SUM(salary)  
FROM employees  
GROUP BY department;  
---

## **Multiple aggregations**

df.groupby("department")\["salary"\].agg(  
    \["count", "sum", "mean", "min", "max"\]  
)  
---

## **Multiple columns**

df.groupby("department").agg(  
    total\_salary=("salary", "sum"),  
    avg\_salary=("salary", "mean"),  
    employee\_count=("employee\_id", "count")  
)

This is equivalent to:

SELECT  
    department,  
    SUM(salary) AS total\_salary,  
    AVG(salary) AS avg\_salary,  
    COUNT(employee\_id) AS employee\_count  
FROM employees  
GROUP BY department;  
---

# **24\. Group By Multiple Columns**

df.groupby(  
    \["department", "location"\]  
)\["salary"\].sum()

### **SQL**

GROUP BY department, location  
---

# **25\. HAVING Equivalent**

SQL:

SELECT  
    department,  
    SUM(salary) AS total\_salary  
FROM employees  
GROUP BY department  
HAVING SUM(salary) \> 500000;

Pandas:

result \= (  
    df.groupby("department")\["salary"\]  
      .sum()  
      .reset\_index()  
)

result\[  
    result\["salary"\] \> 500000  
\]  
---

# **26\. `reset_index()`**

After:

df.groupby("department")\["salary"\].sum()

you get a Series with department as index.

Convert it back:

df.groupby(  
    "department"  
)\["salary"\].sum().reset\_index()

Very important for Data Engineering workflows.

---

# **27\. `merge()` — Pandas JOIN ⭐⭐⭐**

Suppose:

### **Customers**

customer\_id | name

### **Orders**

order\_id | customer\_id | amount

Join:

result \= pd.merge(  
    customers,  
    orders,  
    on="customer\_id",  
    how="inner"  
)

### **SQL**

SELECT \*  
FROM customers c  
JOIN orders o  
    ON c.customer\_id \= o.customer\_id;  
---

# **28\. Types of JOIN**

## **INNER JOIN**

pd.merge(  
    customers,  
    orders,  
    on="customer\_id",  
    how="inner"  
)

## **LEFT JOIN**

pd.merge(  
    customers,  
    orders,  
    on="customer\_id",  
    how="left"  
)

## **RIGHT JOIN**

pd.merge(  
    customers,  
    orders,  
    on="customer\_id",  
    how="right"  
)

## **FULL OUTER JOIN**

pd.merge(  
    customers,  
    orders,  
    on="customer\_id",  
    how="outer"  
)  
---

# **29\. Join Using Different Column Names**

pd.merge(  
    customers,  
    orders,  
    left\_on="customer\_id",  
    right\_on="cust\_id",  
    how="inner"  
)  
---

# **30\. UNION — `concat()`**

SQL:

SELECT \* FROM table1  
UNION ALL  
SELECT \* FROM table2;

Pandas:

pd.concat(  
    \[df1, df2\],  
    ignore\_index=True  
)  
---

# **31\. `apply()`**

df\["salary\_after\_tax"\] \= df\["salary"\].apply(  
    lambda x: x \* 0.8  
)

Example:

df\["name\_upper"\] \= df\["name"\].apply(  
    lambda x: x.upper()  
)  
---

# **32\. String Operations**

df\["name"\].str.upper()  
df\["name"\].str.lower()  
df\["name"\].str.strip()  
df\["name"\].str.len()  
df\["name"\].str.replace("A", "B")  
df\["name"\].str.contains("John")  
---

# **33\. Date Operations**

Convert to datetime:

df\["order\_date"\] \= pd.to\_datetime(  
    df\["order\_date"\]  
)

Extract year:

df\["year"\] \= df\["order\_date"\].dt.year

Month:

df\["month"\] \= df\["order\_date"\].dt.month

Month name:

df\["month\_name"\] \= df\["order\_date"\].dt.month\_name()

Day:

df\["day"\] \= df\["order\_date"\].dt.day

Day of week:

df\["day\_name"\] \= df\["order\_date"\].dt.day\_name()  
---

# **34\. Date Filtering**

df\[  
    df\["order\_date"\] \>= "2026-01-01"  
\]

Between dates:

df\[  
    df\["order\_date"\].between(  
        "2026-01-01",  
        "2026-03-31"  
    )  
\]  
---

# **35\. Pivot Table**

pd.pivot\_table(  
    df,  
    values="sales",  
    index="region",  
    columns="year",  
    aggfunc="sum"  
)

Think:

GROUP BY \+ columns → Pivot  
---

# **36\. Ranking**

df\["rank"\] \= df\["salary"\].rank(  
    ascending=False  
)

Dense ranking:

df\["rank"\] \= df\["salary"\].rank(  
    method="dense",  
    ascending=False  
)  
---

# **37\. Top N**

Top 5 salaries:

df.nlargest(  
    5,  
    "salary"  
)

Bottom 5:

df.nsmallest(  
    5,  
    "salary"  
)  
---

# **38\. Window Functions ⭐⭐⭐**

SQL:

SUM(sales) OVER (  
    PARTITION BY region  
)

Pandas:

df\["region\_total"\] \= (  
    df.groupby("region")\["sales"\]  
      .transform("sum")  
)  
---

# **39\. Group Average Without Collapsing Rows**

df\["avg\_salary"\] \= (  
    df.groupby("department")\["salary"\]  
      .transform("mean")  
)

This is extremely important.

### **Difference**

groupby().agg()

reduces rows.

groupby().transform()

keeps the original number of rows.

---

# **40\. Running Total**

df\["running\_sales"\] \= (  
    df.groupby("customer\_id")\["sales"\]  
      .cumsum()  
)

SQL:

SUM(sales) OVER (  
    PARTITION BY customer\_id  
    ORDER BY order\_date  
)  
---

# **41\. Previous Row — `shift()`**

df\["previous\_sales"\] \= (  
    df\["sales"\].shift(1)  
)

Within customer:

df\["previous\_sales"\] \= (  
    df.groupby("customer\_id")\["sales"\]  
      .shift(1)  
)

SQL equivalent:

LAG(sales) OVER (  
    PARTITION BY customer\_id  
    ORDER BY order\_date  
)  
---

# **42\. Next Row — `shift(-1)`**

df\["next\_sales"\] \= df\["sales"\].shift(-1)

Equivalent to SQL:

LEAD(sales)  
---

# **43\. Difference From Previous Row**

df\["sales\_change"\] \= (  
    df\["sales"\] \-  
    df\["sales"\].shift(1)  
)

Or:

df\["sales"\].diff()  
---

# **44\. Percentage Change**

df\["growth"\] \= (  
    df\["sales"\].pct\_change() \* 100  
)  
---

# **45\. Cumulative Sum**

df\["cumulative\_sales"\] \= (  
    df\["sales"\].cumsum()  
)  
---

# **46\. Cumulative Maximum**

df\["running\_max"\] \= (  
    df\["sales"\].cummax()  
)  
---

# **47\. Replace Values**

df\["status"\] \= df\["status"\].replace(  
    {  
        "Y": "Yes",  
        "N": "No"  
    }  
)  
---

# **48\. Change Data Type**

df\["age"\] \= df\["age"\].astype(int)  
df\["salary"\] \= df\["salary"\].astype(float)  
---

# **49\. Rename Index**

df.index.name \= "row\_id"  
---

# **50\. Reset Index**

df.reset\_index(drop=True)  
---

# **51\. Delete Column**

df.drop(  
    columns=\["bonus"\],  
    inplace=True  
)  
---

# **52\. Delete Rows**

df.drop(index=\[0, 1\])  
---

# **53\. Select Based on Index**

df.loc\[5\]  
df.iloc\[5\]

Remember:

loc  → label  
iloc → position  
---

# **54\. Copy DataFrame**

df2 \= df.copy()

Good practice when creating a working DataFrame.

---

# **55\. Sample Rows**

df.sample(10)

Random 10 rows.

---

# **56\. Count Rows**

len(df)

or:

df.shape\[0\]  
---

# **57\. Count Columns**

df.shape\[1\]  
---

# **58\. Memory Usage**

df.memory\_usage(  
    deep=True  
)  
---

# **59\. Find Duplicate Records**

df\[df.duplicated()\]

Duplicate based on specific columns:

df\[  
    df.duplicated(  
        subset=\["customer\_id"\],  
        keep=False  
    )  
\]  
---

# **60\. Common Pandas Problem-Solving Framework ⭐⭐⭐**

When you receive a Pandas problem, **don't immediately start coding**.

Use this framework:

                BUSINESS QUESTION  
                         ↓  
                 WHAT DATA DO I NEED?  
                         ↓  
                 WHICH COLUMNS?  
                         ↓  
                 DO I NEED TO FILTER?  
                         ↓  
                 DO I NEED TO JOIN?  
                         ↓  
                 DO I NEED TO GROUP?  
                         ↓  
                 WHAT CALCULATION?  
                         ↓  
                 DO I NEED A WINDOW?  
                         ↓  
                 DO I NEED TO SORT?  
                         ↓  
                 WHAT OUTPUT?  
---

# **61\. Pandas ↔ SQL Cheat Sheet**

| SQL | Pandas |
| ----- | ----- |
| `SELECT` | `df[]` |
| `WHERE` | Boolean filtering |
| `AND` | `&` |
| `OR` | \` |
| `NOT` | `!=`, `~` |
| `IN` | `.isin()` |
| `BETWEEN` | `.between()` |
| `ORDER BY` | `.sort_values()` |
| `GROUP BY` | `.groupby()` |
| `HAVING` | Filter after aggregation |
| `JOIN` | `pd.merge()` |
| `UNION ALL` | `pd.concat()` |
| `DISTINCT` | `.drop_duplicates()` |
| `COUNT` | `.count()` |
| `COUNT DISTINCT` | `.nunique()` |
| `SUM` | `.sum()` |
| `AVG` | `.mean()` |
| `MIN` | `.min()` |
| `MAX` | `.max()` |
| `CASE WHEN` | `np.where()` / `np.select()` |
| `LAG` | `.shift()` |
| `LEAD` | `.shift(-1)` |
| `ROW_NUMBER` | `.cumcount()` |
| `RANK` | `.rank()` |
| Window `SUM` | `.transform("sum")` |
| Running total | `.cumsum()` |
| `NULL` | `NaN` / `None` |
| `COALESCE` | `.fillna()` |

---

# **62\. Most Important Pandas Functions to Master**

If you're learning Pandas for **Data Engineering**, prioritize these:

### **Level 1 — Fundamentals**

read\_csv()  
head()  
tail()  
info()  
describe()  
shape  
columns  
dtypes

### **Level 2 — Selection**

\[\]  
loc  
iloc  
isin()  
between()

### **Level 3 — Transformation**

assign  
rename  
astype  
replace  
apply  
map  
np.where  
np.select

### **Level 4 — Cleaning**

isna()  
notna()  
fillna()  
dropna()  
drop\_duplicates()

### **Level 5 — Analytics**

groupby()  
agg()  
transform()  
sort\_values()  
value\_counts()  
rank()

### **Level 6 — Combining Data**

merge()  
concat()  
join()

### **Level 7 — Advanced Analytics**

shift()  
diff()  
pct\_change()  
cumsum()  
cummax()  
rolling()  
rank()

### **Level 8 — Dates**

pd.to\_datetime()  
.dt.year  
.dt.month  
.dt.day  
.dt.day\_name()  
---

# **63\. ⭐ 10 Must-Know Pandas Problems**

### **Problem 1 — Filter**

> Find employees whose salary is greater than ₹80,000.

df\[df\["salary"\] \> 80000\]  
---

### **Problem 2 — Grouping**

> Find total sales by region.

df.groupby("region")\["sales"\].sum()  
---

### **Problem 3 — Aggregation**

> Find average salary by department.

df.groupby("department")\["salary"\].mean()  
---

### **Problem 4 — HAVING**

> Find departments where average salary is greater than ₹70,000.

result \= (  
    df.groupby("department")\["salary"\]  
      .mean()  
      .reset\_index()  
)

result\[result\["salary"\] \> 70000\]  
---

### **Problem 5 — JOIN**

> Find customer names and their orders.

pd.merge(  
    customers,  
    orders,  
    on="customer\_id",  
    how="inner"  
)  
---

### **Problem 6 — Top N**

> Find the top 5 customers by sales.

result \= (  
    df.groupby("customer\_id")\["sales"\]  
      .sum()  
      .reset\_index()  
)

result.nlargest(5, "sales")  
---

### **Problem 7 — Ranking**

> Rank employees by salary within each department.

df\["salary\_rank"\] \= (  
    df.groupby("department")\["salary"\]  
      .rank(  
          method="dense",  
          ascending=False  
      )  
)  
---

### **Problem 8 — Previous Value**

> Find each customer's previous order amount.

df \= df.sort\_values(  
    \["customer\_id", "order\_date"\]  
)

df\["previous\_order"\] \= (  
    df.groupby("customer\_id")\["amount"\]  
      .shift(1)  
)  
---

### **Problem 9 — Running Total**

> Calculate cumulative sales for each customer.

df \= df.sort\_values(  
    \["customer\_id", "order\_date"\]  
)

df\["running\_sales"\] \= (  
    df.groupby("customer\_id")\["sales"\]  
      .cumsum()  
)  
---

### **Problem 10 — Deduplication**

> Keep the latest record for every customer.

df \= df.sort\_values("updated\_at")

result \= df.drop\_duplicates(  
    subset=\["customer\_id"\],  
    keep="last"  
)  
---

# **🧠 The Pandas Mental Model**

Remember this sequence:

READ  
 ↓  
INSPECT  
 ↓  
SELECT  
 ↓  
FILTER  
 ↓  
CLEAN  
 ↓  
JOIN  
 ↓  
TRANSFORM  
 ↓  
GROUP  
 ↓  
AGGREGATE  
 ↓  
WINDOW  
 ↓  
SORT  
 ↓  
OUTPUT

And the **SQL → Pandas translation** you should internalize is:

SELECT       → df\[\]  
WHERE        → df\[condition\]  
JOIN         → merge()  
GROUP BY     → groupby()  
HAVING       → filter after groupby  
ORDER BY     → sort\_values()  
DISTINCT     → drop\_duplicates()  
CASE         → np.where / np.select  
LAG          → shift()  
SUM OVER     → transform / cumsum  
ROW\_NUMBER   → cumcount  
