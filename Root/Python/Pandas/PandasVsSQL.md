# **🏆 Pandas vs SQL — Data Engineering Competition Course**

### **Course Mission**

> **"One Business Problem. Two Technologies. One Winner."**

Learners are given a business requirement.

They must:

1. Understand the business question  
2. Identify required data  
3. Break the problem down  
4. Solve it in **SQL**  
5. Solve the same problem in **Pandas**  
6. Compare both solutions  
7. Debug incorrect solutions  
8. Optimize the solution  
9. Explain which technology they would use in production

---

# **1\. Course Structure**

I recommend **10 working days / 60 hours**, matching the Data Engineering training structure you've been building.

| Day | Theme | SQL | Pandas | Competition |
| ----- | ----- | ----- | ----- | ----- |
| 1 | Think Like a Data Engineer | SELECT | DataFrame | SQL vs Pandas basics |
| 2 | Filtering | WHERE | Boolean filtering | Filter Battle |
| 3 | Transformation | CASE / expressions | `assign()` / vectorization | Transformation Battle |
| 4 | Aggregation | GROUP BY | `groupby()` | Aggregation Battle |
| 5 | Joins | JOIN | `merge()` | Join Battle |
| 6 | Advanced Analytics | Window Functions | `transform()` / `rank()` | Analytics Battle |
| 7 | Dates & Time | Date functions | datetime | Time Battle |
| 8 | Data Cleaning | SQL cleansing | Pandas cleansing | Cleaning Battle |
| 9 | Performance & Debugging | Query optimization | Pandas optimization | Performance Battle |
| 10 | Capstone | Complete SQL pipeline | Complete Pandas pipeline | 🏆 Final Championship |

---

# **2\. The Core Problem-Solving Framework**

This should become the **central framework of your course**.

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

### **The golden rule**

> **Don't think "How do I write this in Pandas?"**

> First think:

> **"What is the business problem?"**

Then translate the logic into SQL and Pandas.

---

# **3\. The Master Translation Map**

This becomes the learner's main cheat sheet.

| Business Requirement | SQL | Pandas |
| ----- | ----- | ----- |
| Select columns | `SELECT` | `df[['col1','col2']]` |
| Rename | `AS` | `.rename()` |
| Filter rows | `WHERE` | Boolean filtering |
| Multiple filters | `AND / OR` | `& / |` |
| Sort | `ORDER BY` | `.sort_values()` |
| Top N | `LIMIT` | `.head()` |
| Remove duplicates | `DISTINCT` | `.drop_duplicates()` |
| Create column | expression / `CASE` | `.assign()` |
| Conditional logic | `CASE WHEN` | `np.where()` / `np.select()` |
| Aggregate | `SUM()` | `.sum()` |
| Average | `AVG()` | `.mean()` |
| Count | `COUNT()` | `.count()` / `.size()` |
| Group | `GROUP BY` | `.groupby()` |
| Having | `HAVING` | aggregate → filter |
| Inner Join | `INNER JOIN` | `merge(..., how='inner')` |
| Left Join | `LEFT JOIN` | `merge(..., how='left')` |
| Right Join | `RIGHT JOIN` | `merge(..., how='right')` |
| Full Join | `FULL OUTER JOIN` | `merge(..., how='outer')` |
| Union | `UNION` | `concat()` \+ dedupe |
| Window | `OVER()` | `groupby()` \+ `transform()` / `rank()` |
| Lag | `LAG()` | `.shift()` |
| Lead | `LEAD()` | `.shift(-1)` |
| Rank | `RANK()` | `.rank()` |
| Null check | `IS NULL` | `.isna()` |
| Fill null | `COALESCE()` | `.fillna()` |
| String manipulation | SQL string functions | `.str` |
| Date extraction | `YEAR()`, `MONTH()` | `.dt.year`, `.dt.month` |
| Pivot | `PIVOT` | `.pivot_table()` |

Pandas' documentation itself maintains a SQL comparison covering many of these operations. 

---

# **4\. DAY 1 — SELECT vs DataFrame**

## **Concept**

SQL:

SELECT customer\_id,  
       customer\_name,  
       city  
FROM customers;

Pandas:

df\[\['customer\_id', 'customer\_name', 'city'\]\]  
---

## **Exercise 1 — Basic Selection**

### **Business Question**

> Display customer ID, customer name and city for all customers.

### **Problem Breakdown**

| Question | Answer |
| ----- | ----- |
| Business Question | Display customer information |
| Data Needed | Customers |
| Columns | customer\_id, customer\_name, city |
| Transformation | Select columns |
| Filter | None |
| Grouping | None |
| Calculation | None |
| Output | Customer details |

### **Challenge**

Write:

* SQL solution  
* Pandas solution

---

# **5\. DAY 2 — WHERE vs Filtering**

### **Business Question**

> Find all customers from Mumbai.

SQL:

SELECT \*  
FROM customers  
WHERE city \= 'Mumbai';

Pandas:

df\[df\['city'\] \== 'Mumbai'\]  
---

## **Exercises**

### **Exercise 2**

Find customers:

city \= Mumbai

### **Exercise 3**

Find customers:

age \> 30

### **Exercise 4**

Find customers:

age \> 30 AND city \= Mumbai

### **Exercise 5**

Find customers:

city IN ('Mumbai', 'Pune', 'Bangalore')

### **Exercise 6 — Challenge**

Find customers who:

age between 25 and 40  
AND  
city is Mumbai or Pune  
---

# **6\. DAY 3 — CASE WHEN vs Conditional Transformation**

This is where the course becomes interesting.

### **Business Question**

> Categorize customers based on spending.

Rules:

\>= 100000 → Premium  
\>= 50000  → Gold  
\>= 25000  → Silver  
\< 25000   → Regular

### **SQL**

CASE  
    WHEN total\_spend \>= 100000 THEN 'Premium'  
    WHEN total\_spend \>= 50000 THEN 'Gold'  
    WHEN total\_spend \>= 25000 THEN 'Silver'  
    ELSE 'Regular'  
END

### **Pandas**

conditions \= \[  
    df\['total\_spend'\] \>= 100000,  
    df\['total\_spend'\] \>= 50000,  
    df\['total\_spend'\] \>= 25000  
\]

choices \= \[  
    'Premium',  
    'Gold',  
    'Silver'  
\]

df\['customer\_segment'\] \= np.select(  
    conditions,  
    choices,  
    default='Regular'  
)  
---

## **Competition**

Give learners an incorrect Pandas implementation.

They must:

1. Find the bug  
2. Explain why it is wrong  
3. Correct it  
4. Write the SQL equivalent

---

# **7\. DAY 4 — GROUP BY vs GROUPBY**

This should be one of the biggest modules.

Pandas officially describes `groupby()` as **split → apply → combine**, including aggregation, transformation and filtration. 

### **Business Question**

> Calculate total sales by city.

SQL:

SELECT city,  
       SUM(sales) AS total\_sales  
FROM sales  
GROUP BY city;

Pandas:

df.groupby('city')\['sales'\].sum()

Or:

df.groupby('city', as\_index=False).agg(  
    total\_sales=('sales', 'sum')  
)  
---

# **Exercises**

### **Exercise 7**

Total sales by:

city

### **Exercise 8**

Average order value by:

city

### **Exercise 9**

Number of orders by:

customer

### **Exercise 10**

Total revenue by:

city \+ product\_category

### **Exercise 11**

Find cities where:

total sales \> ₹10,00,000

SQL:

GROUP BY city  
HAVING SUM(sales) \> 1000000

Pandas:

result \= (  
    df.groupby('city', as\_index=False)  
      .agg(total\_sales=('sales', 'sum'))  
)

result\[result\['total\_sales'\] \> 1000000\]  
---

# **8\. DAY 5 — JOIN vs MERGE**

This is critical for Data Engineers.

Pandas `merge()` implements common SQL-style join operations, including one-to-one, many-to-one and many-to-many relationships. 

Dataset:

customers  
orders  
products  
---

## **Business Problem**

> Find customer name, product name and order amount for every order.

SQL:

SELECT  
    c.customer\_name,  
    p.product\_name,  
    o.order\_amount  
FROM orders o  
JOIN customers c  
    ON o.customer\_id \= c.customer\_id  
JOIN products p  
    ON o.product\_id \= p.product\_id;

Pandas:

result \= orders.merge(  
    customers,  
    on='customer\_id',  
    how='inner'  
)

result \= result.merge(  
    products,  
    on='product\_id',  
    how='inner'  
)  
---

# **Join Battle**

Give learners two datasets and ask:

### **Exercise 12**

INNER JOIN

### **Exercise 13**

LEFT JOIN

### **Exercise 14**

Find customers who never placed an order.

SQL:

SELECT c.customer\_id  
FROM customers c  
LEFT JOIN orders o  
    ON c.customer\_id \= o.customer\_id  
WHERE o.customer\_id IS NULL;

Pandas:

result \= customers.merge(  
    orders,  
    on='customer\_id',  
    how='left',  
    indicator=True  
)

result\[result\['\_merge'\] \== 'left\_only'\]

### **Exercise 15 — Many-to-Many Trap**

Give duplicate keys in both datasets.

Ask:

> Why did the number of rows suddenly increase?

This is an excellent Data Engineering interview problem because a many-to-many merge can produce a Cartesian product for matching duplicate keys. 

---

# **9\. DAY 6 — Window Functions vs Pandas Analytics**

This is the **Advanced Level**.

## **Business Question**

> Find the top 3 products by sales within every category.

### **SQL**

WITH ranked AS (  
    SELECT  
        category,  
        product,  
        sales,  
        RANK() OVER (  
            PARTITION BY category  
            ORDER BY sales DESC  
        ) AS rnk  
    FROM product\_sales  
)

SELECT \*  
FROM ranked  
WHERE rnk \<= 3;

### **Pandas**

df\['rank'\] \= (  
    df.groupby('category')\['sales'\]  
      .rank(method='dense', ascending=False)  
)

result \= df\[df\['rank'\] \<= 3\]  
---

## **Window Exercises**

### **Exercise 16**

Rank employees by salary within department.

### **Exercise 17**

Find top 3 products per category.

### **Exercise 18**

Calculate customer cumulative spend.

### **Exercise 19**

Find previous order for every customer.

SQL:

LAG(order\_amount)  
OVER (  
    PARTITION BY customer\_id  
    ORDER BY order\_date  
)

Pandas:

df\['previous\_order'\] \= (  
    df.sort\_values('order\_date')  
      .groupby('customer\_id')\['order\_amount'\]  
      .shift(1)  
)

### **Exercise 20**

Calculate:

current order \- previous order  
---

# **10\. DAY 7 — DATE & TIME BATTLE**

| Requirement | SQL | Pandas |
| ----- | ----- | ----- |
| Year | `YEAR(date)` | `df['date'].dt.year` |
| Month | `MONTH(date)` | `df['date'].dt.month` |
| Day | `DAY(date)` | `df['date'].dt.day` |
| Difference | `DATEDIFF()` | datetime subtraction |
| Current date | `CURRENT_DATE` | `pd.Timestamp.today()` |

---

## **Exercises**

### **Exercise 21**

Find monthly sales.

### **Exercise 22**

Find yearly sales.

### **Exercise 23**

Find customers whose last order was more than 90 days ago.

### **Exercise 24**

Find month-over-month revenue growth.

### **Exercise 25 — Advanced**

Find the longest gap between two orders for every customer.

---

# **11\. DAY 8 — DATA CLEANING BATTLE**

Dataset intentionally contains:

NULL values  
duplicates  
incorrect dates  
spaces  
mixed case  
invalid categories  
negative amounts  
---

## **SQL vs Pandas**

| Problem | SQL | Pandas |
| ----- | ----- | ----- |
| Null detection | `IS NULL` | `.isna()` |
| Fill null | `COALESCE()` | `.fillna()` |
| Remove duplicates | `DISTINCT` | `.drop_duplicates()` |
| Trim | `TRIM()` | `.str.strip()` |
| Uppercase | `UPPER()` | `.str.upper()` |
| Lowercase | `LOWER()` | `.str.lower()` |
| Replace | `REPLACE()` | `.str.replace()` |
| Convert date | `CAST()` | `pd.to_datetime()` |

---

## **Exercises**

### **Exercise 26**

Remove duplicate customers.

### **Exercise 27**

Standardize city names.

mumbai  
Mumbai  
MUMBAI  
 Mumbai

Expected:

Mumbai

### **Exercise 28**

Handle missing sales.

### **Exercise 29**

Identify invalid transactions.

### **Exercise 30**

Build a complete cleansing pipeline.

---

# **12\. DAY 9 — PERFORMANCE BATTLE**

This is where you teach learners that **Pandas and SQL are not simply interchangeable**.

### **Scenario**

You have:

500 million transactions

Ask:

> Should we load everything into Pandas?

Usually, no.

The question becomes:

WHERE IS THE DATA?  
        ↓  
HOW MUCH DATA?  
        ↓  
WHERE SHOULD COMPUTATION HAPPEN?  
        ↓  
DATABASE?  
PANDAS?  
BOTH?

Pandas is primarily an in-memory tabular data manipulation tool, while it can also retrieve SQL query results into DataFrames. 

---

## **Optimization Competition**

### **Problem**

Bad solution:

df \= pd.read\_csv('transactions.csv')

df \= df\[df\['country'\] \== 'India'\]

df \= df\[\['customer\_id', 'amount'\]\]

Ask learners:

> Can we reduce memory usage?

Possible improvement:

df \= pd.read\_csv(  
    'transactions.csv',  
    usecols=\['customer\_id', 'country', 'amount'\]  
)

df \= df\[df\['country'\] \== 'India'\]

Then introduce:

SQL → Filter/Aggregate at source  
             ↓  
        Smaller dataset  
             ↓  
          Pandas  
             ↓  
        Analysis / ML  
---

# **13\. DAY 10 — 🏆 FINAL CHAMPIONSHIP**

## **Retail Data Engineering Mission**

Use these datasets:

customers.csv

customer\_id  
customer\_name  
city  
state  
signup\_date  
customer\_segment  
products.csv

product\_id  
product\_name  
category  
subcategory  
price  
cost  
orders.csv

order\_id  
customer\_id  
order\_date  
payment\_method  
order\_status  
order\_items.csv

order\_id  
product\_id  
quantity  
discount  
---

# **Final Business Requirement**

> **"The management wants a Retail Sales Intelligence Report showing customer performance, product performance, regional performance and monthly trends."**

Learners must build:

### **1\. Revenue**

Total Revenue

### **2\. Profit**

Revenue \- Cost

### **3\. Customer Metrics**

Total Customers  
Active Customers  
Average Customer Spend  
Top 10 Customers

### **4\. Product Metrics**

Top 10 Products  
Top Products by Category  
Lowest Performing Products

### **5\. Geography**

Revenue by City  
Revenue by State  
Top Performing State

### **6\. Time**

Daily Revenue  
Monthly Revenue  
Yearly Revenue  
MoM Growth

### **7\. Customer Segmentation**

Premium  
Gold  
Silver  
Regular

### **8\. Ranking**

Top 3 Products per Category  
Top 5 Customers per City  
---

# **🥊 The Competition Format**

Each team gets the **same problem**.

### **Round 1 — SQL**

30 minutes.

### **Round 2 — Pandas**

30 minutes.

### **Round 3 — Debugging**

15 minutes.

### **Round 4 — Optimization**

15 minutes.

### **Round 5 — Explain**

10 minutes.

---

# **Scoring System**

| Category | Points |
| ----- | ----- |
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

# **14\. The "Which One Wins?" Framework**

Don't teach:

> **SQL vs Pandas — which is better?**

Teach:

> **"Which layer should perform this operation?"**

| Situation | Preferred |
| ----- | ----- |
| Database filtering | SQL |
| Large-scale aggregation | SQL |
| Joining huge tables | SQL |
| Data warehouse transformation | SQL |
| Interactive exploration | Pandas |
| Complex Python logic | Pandas |
| Statistical analysis | Pandas |
| ML preparation | Pandas |
| Visualization preparation | Pandas |
| Data quality investigation | Pandas |
| Small/medium local datasets | Pandas |
| Production warehouse pipeline | Usually SQL \+ orchestration |
| SQL result → analysis | SQL → Pandas |

---

# **15\. The Golden Data Engineering Pattern**

This should be the **final concept learners remember**:

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

And when data comes from a database, pandas supports reading SQL queries into DataFrames, making this SQL → Pandas workflow particularly practical. 

---

# **16\. Your Exercise Progression**

I would make every topic follow your preferred **Learn → Practice → Debug → Challenge → Production Scenario**model:

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

### **Example**

**GROUP BY**

Learn  
 ↓  
Basic GROUP BY  
 ↓  
Practice  
 ↓  
Multiple aggregations  
 ↓  
Debug  
 ↓  
Wrong GROUP BY  
 ↓  
Challenge  
 ↓  
HAVING  
 ↓  
Production  
 ↓  
Sales KPI pipeline  
 ↓  
Competition  
 ↓  
GROUP BY vs groupby()  
