# Data Warehousing & Snowflake --- Complete SQL Training Module

**Case Study:** SmartMart Retail Data Warehouse\
**Platform:** Snowflake\
**SQL:** Snowflake SQL\
**Level:** Intermediate → Advanced Data Engineering / Analytics

------------------------------------------------------------------------

## 1. Module Overview

This module covers:

1.  Performance Benchmarking
2.  Introduction to Data Warehousing
3.  What is a Data Warehouse?
4.  OLTP vs OLAP
5.  Benefits and Use Cases of DWH
6.  Key Components of a DWH
7.  Introduction to Snowflake
8.  Snowflake architecture
9.  Databases, schemas, tables and warehouses
10. Dimensional modelling
11. Fact and dimension tables
12. ETL / ELT
13. Data Warehouse lifecycle
14. Complete SmartMart Snowflake lab
15. Performance benchmarking lab
16. Query optimization exercises
17. Capstone exercises

> **Lab design:** One database, `SMARTMART_DWH`, with `STAGING`, `CORE`,
> and `ANALYTICS` schemas.

------------------------------------------------------------------------

## 2. Data Warehouse in One Picture

``` text
                   BUSINESS SYSTEMS
                         |
          +--------------+--------------+
          |              |              |
          v              v              v
       POS/ERP       E-Commerce      CRM/App
          |              |              |
          +--------------+--------------+
                         |
                         v
                +----------------+
                |   STAGING      |
                | Raw / Landing  |
                +-------+--------+
                        |
                        v
                +----------------+
                | ETL / ELT      |
                | Clean / Join   |
                | Transform      |
                +-------+--------+
                        |
                        v
             +-----------------------+
             |     DATA WAREHOUSE    |
             |  Dimensions + Facts  |
             +-----------+-----------+
                         |
             +-----------+-----------+
             |           |           |
             v           v           v
          BI/Reports   ML/AI      Analytics
```

------------------------------------------------------------------------

## 3. What Is a Data Warehouse?

A **Data Warehouse (DWH)** is a centralized analytical data store
designed to integrate historical data from multiple sources and support
reporting, business intelligence, analytics, and decision-making.

A useful definition:

> **A data warehouse converts operational data into reliable,
> historical, analysis-ready information.**

Typical characteristics:

-   Historical data
-   Integrated data
-   Consistent business definitions
-   Analytical queries
-   Aggregation
-   Dimensional modelling
-   Reporting and BI support

------------------------------------------------------------------------

## 4. OLTP vs OLAP

### OLTP --- Online Transaction Processing

OLTP systems support day-to-day transactions.

Examples:

-   Creating a customer
-   Placing an order
-   Processing payment
-   Updating inventory
-   Booking a hospital appointment

``` text
Many Users
    |
    v
Small Transactions
    |
    +--> INSERT
    +--> UPDATE
    +--> DELETE
    |
    v
Fast Transaction Response
```

### OLAP --- Online Analytical Processing

OLAP systems support analysis.

Examples:

-   Revenue by region
-   Monthly sales trend
-   Customer lifetime value
-   Product profitability
-   Hospital admissions by department
-   Inventory turnover

``` text
Analyst
   |
   v
Large SQL Query
   |
   +---- joins
   +---- aggregations
   +---- filters
   +---- windows
   |
   v
Business Insight
```

### Comparison

  Feature        OLTP                   OLAP / DWH
  -------------- ---------------------- --------------------------
  Purpose        Transactions           Analytics
  Data           Current operational    Historical + integrated
  Query type     Small/simple           Complex/analytical
  Writes         Frequent               Batch/stream/incremental
  Reads          Small result sets      Large scans/aggregations
  Modelling      Usually normalized     Often dimensional
  Users          Applications           Analysts/BI/data teams
  Typical SQL    INSERT/UPDATE/DELETE   SELECT/aggregate
  Time horizon   Current                Historical

------------------------------------------------------------------------

## 5. Why Do We Need a DWH?

Suppose management asks:

> What was monthly revenue by product category for the last five years,
> by region and customer segment?

Running this directly against operational systems can cause unnecessary
load.

``` text
OLTP
 |
 +-- Customer transactions
 +-- Inventory
 +-- Payments
 |
 +-- Complex analytical query
          |
          v
     Application slowdown
```

A warehouse separates analytical workloads:

``` text
OLTP
 |
 v
ETL / ELT
 |
 v
DWH
 |
 +---- BI
 +---- Dashboards
 +---- Analytics
 +---- ML
```

------------------------------------------------------------------------

## 6. Benefits and Use Cases

### Benefits

-   Historical analysis
-   Single version of truth
-   Cross-system integration
-   Better analytical performance
-   Consistent metrics
-   BI and dashboard support
-   Data science enablement
-   Auditability and governance

### Use Cases

**Retail**

-   Sales analytics
-   Customer segmentation
-   Product performance
-   Inventory analytics
-   Store performance

**Banking**

-   Fraud analytics
-   Risk reporting
-   Customer profitability

**Healthcare**

-   Patient analytics
-   Hospital utilization
-   Department performance

**Manufacturing**

-   Production analytics
-   Quality metrics
-   Supply-chain analytics

------------------------------------------------------------------------

## 7. Key Components of a Data Warehouse

``` text
             DATA SOURCES
                  |
                  v
          +---------------+
          | INGESTION     |
          +-------+-------+
                  |
                  v
          +---------------+
          | STAGING       |
          +-------+-------+
                  |
                  v
          +---------------+
          | TRANSFORM     |
          | ETL / ELT     |
          +-------+-------+
                  |
                  v
          +---------------+
          | DATA WAREHOUSE|
          +-------+-------+
                  |
        +---------+---------+
        |         |         |
        v         v         v
       BI       ML/AI    Analytics
```

Major components:

-   Source systems
-   Ingestion
-   Staging
-   Transformation
-   Warehouse
-   Semantic/analytics layer
-   BI
-   Governance
-   Monitoring
-   Data quality

------------------------------------------------------------------------

## 8. Dimensional Modelling

A common analytical model contains fact and dimension tables.

``` text
                  dim_customer
                       |
                       |
dim_date ---- fact_sales ---- dim_product
                       |
                       |
                  dim_store
```

### Fact

A fact represents a measurable business event.

``` text
fact_sales
------------------------
sales_key
date_key
customer_key
product_key
store_key
quantity
sales_amount
discount_amount
cost_amount
profit_amount
```

### Dimension

A dimension provides descriptive context.

``` text
dim_customer
------------------------
customer_key
customer_id
customer_name
city
state
region
customer_segment
```

------------------------------------------------------------------------

## 9. Star Schema

``` text
                  +-------------+
                  | dim_date    |
                  +------+------+
                         |
+-------------+     +---v--------+     +-------------+
| dim_customer|---->| fact_sales |<----| dim_product |
+-------------+     +---+--------+     +-------------+
                         |
                  +------v-------+
                  | dim_store    |
                  +--------------+
```

The fact table is the center and dimensions surround it, creating a
star-like structure.

------------------------------------------------------------------------

## 10. Snowflake Schema

A snowflake schema normalizes parts of dimensions.

``` text
             dim_category
                  |
                  v
             dim_product
                  |
                  v
dim_customer -> fact_sales <- dim_store
                  |
                  v
               dim_date
```

For introductory analytics, star schemas are often easier to query and
teach.

------------------------------------------------------------------------

# 11. Introduction to Snowflake

Snowflake is a cloud data platform designed for data warehousing,
analytics, engineering, sharing, and related workloads.

A useful mental model:

``` text
              SNOWFLAKE
                  |
       +----------+----------+
       |                     |
       v                     v
    STORAGE                COMPUTE
       |                     |
       |               Virtual Warehouse
       |
       v
 Micro-partitions
```

A Snowflake virtual warehouse provides compute resources for queries and
DML operations.

------------------------------------------------------------------------

## 12. Snowflake Object Hierarchy

``` text
Account
   |
   v
Database
   |
   v
Schema
   |
   +---- Tables
   +---- Views
   +---- Stages
   +---- Other Objects
```

A database logically groups schemas; a schema logically groups database
objects.

------------------------------------------------------------------------

## 13. One-Database SmartMart Architecture

This entire lab uses one database:

``` text
SMARTMART_DWH
|
+-- STAGING
|     |
|     +-- customers_raw
|     +-- products_raw
|     +-- purchases_raw
|
+-- CORE
|     |
|     +-- dim_customer
|     +-- dim_product
|     +-- dim_date
|     +-- fact_sales
|
+-- ANALYTICS
      |
      +-- customer_revenue
      +-- product_performance
      +-- monthly_sales
```

------------------------------------------------------------------------

# 14. Create Database and Schemas

``` sql
CREATE OR REPLACE DATABASE SMARTMART_DWH;

USE DATABASE SMARTMART_DWH;

CREATE OR REPLACE SCHEMA STAGING;
CREATE OR REPLACE SCHEMA CORE;
CREATE OR REPLACE SCHEMA ANALYTICS;
```

------------------------------------------------------------------------

# 15. Create Virtual Warehouse

``` sql
CREATE OR REPLACE WAREHOUSE SMARTMART_WH
WITH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE;

USE WAREHOUSE SMARTMART_WH;
```

For a small training dataset, `XSMALL` is enough. Larger benchmark
workloads should use controlled warehouse sizes when comparing
performance.

------------------------------------------------------------------------

# 16. Create Staging Tables

``` sql
USE DATABASE SMARTMART_DWH;
USE SCHEMA STAGING;

CREATE OR REPLACE TABLE customers_raw
(
    customer_id NUMBER,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    customer_type VARCHAR(50)
);

CREATE OR REPLACE TABLE products_raw
(
    product_id NUMBER,
    product_name VARCHAR(100),
    category VARCHAR(100),
    unit_price NUMBER(12,2)
);

CREATE OR REPLACE TABLE purchases_raw
(
    purchase_id NUMBER,
    customer_id NUMBER,
    product_id NUMBER,
    purchase_date DATE,
    quantity NUMBER,
    total_amount NUMBER(14,2)
);
```

------------------------------------------------------------------------

# 17. Insert Customer Data

``` sql
INSERT INTO customers_raw
VALUES
(1, 'Arun Kumar', 'Coimbatore', 'Tamil Nadu', 'Retail'),
(2, 'Priya Sharma', 'Bengaluru', 'Karnataka', 'Retail'),
(3, 'Rahul Verma', 'Chennai', 'Tamil Nadu', 'Corporate'),
(4, 'Sneha Iyer', 'Kochi', 'Kerala', 'Retail'),
(5, 'Vijay Rao', 'Hyderabad', 'Telangana', 'Corporate'),
(6, 'Meena Krishnan', 'Madurai', 'Tamil Nadu', 'Retail'),
(7, 'Karthik Raj', 'Salem', 'Tamil Nadu', 'Retail'),
(8, 'Anitha Das', 'Bengaluru', 'Karnataka', 'Corporate');
```

------------------------------------------------------------------------

# 18. Insert Product Data

``` sql
INSERT INTO products_raw
VALUES
(101, 'Laptop', 'Electronics', 65000),
(102, 'Mobile Phone', 'Electronics', 25000),
(103, 'Headphones', 'Electronics', 3000),
(104, 'Office Chair', 'Furniture', 8500),
(105, 'Desk', 'Furniture', 12000),
(106, 'Coffee Maker', 'Home Appliances', 5500),
(107, 'Backpack', 'Accessories', 2500),
(108, 'Monitor', 'Electronics', 18000);
```

------------------------------------------------------------------------

# 19. Insert Purchase Data

``` sql
INSERT INTO purchases_raw
VALUES
(1001, 1, 101, '2026-01-10', 1, 65000),
(1002, 1, 103, '2026-01-15', 2, 6000),
(1003, 2, 102, '2026-01-20', 1, 25000),
(1004, 3, 104, '2026-02-05', 2, 17000),
(1005, 4, 106, '2026-02-10', 1, 5500),
(1006, 5, 108, '2026-02-15', 2, 36000),
(1007, 6, 107, '2026-02-20', 3, 7500),
(1008, 7, 101, '2026-03-01', 1, 65000),
(1009, 8, 105, '2026-03-05', 1, 12000),
(1010, 1, 108, '2026-03-10', 1, 18000),
(1011, 2, 103, '2026-03-15', 3, 9000),
(1012, 3, 102, '2026-03-20', 2, 50000),
(1013, 4, 104, '2026-04-02', 1, 8500),
(1014, 5, 101, '2026-04-05', 1, 65000),
(1015, 6, 106, '2026-04-08', 2, 11000);
```

------------------------------------------------------------------------

# 20. Verify Staging Data

``` sql
SELECT COUNT(*) FROM STAGING.customers_raw;

SELECT COUNT(*) FROM STAGING.products_raw;

SELECT COUNT(*) FROM STAGING.purchases_raw;
```

Inspect:

``` sql
SELECT * FROM STAGING.customers_raw;
SELECT * FROM STAGING.products_raw;
SELECT * FROM STAGING.purchases_raw;
```

------------------------------------------------------------------------

# 21. Create Date Dimension

``` sql
USE SCHEMA CORE;

CREATE OR REPLACE TABLE dim_date
(
    date_key NUMBER,
    full_date DATE,
    day_number NUMBER,
    month_number NUMBER,
    month_name VARCHAR(20),
    quarter_number NUMBER,
    year_number NUMBER,
    day_name VARCHAR(20)
);
```

Populate 2026:

``` sql
INSERT INTO dim_date
SELECT
    TO_NUMBER(TO_CHAR(d, 'YYYYMMDD')),
    d,
    DAY(d),
    MONTH(d),
    MONTHNAME(d),
    QUARTER(d),
    YEAR(d),
    DAYNAME(d)
FROM
(
    SELECT DATEADD(
        DAY,
        SEQ4(),
        '2026-01-01'
    ) AS d
    FROM TABLE(GENERATOR(ROWCOUNT => 365))
);
```

------------------------------------------------------------------------

# 22. Create Customer Dimension

``` sql
CREATE OR REPLACE TABLE dim_customer
(
    customer_key NUMBER AUTOINCREMENT,
    customer_id NUMBER,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    customer_type VARCHAR(50),
    region VARCHAR(50)
);
```

Load:

``` sql
INSERT INTO dim_customer
(
    customer_id,
    customer_name,
    city,
    state,
    customer_type,
    region
)
SELECT
    customer_id,
    customer_name,
    city,
    state,
    customer_type,
    CASE
        WHEN state IN
            ('Tamil Nadu', 'Kerala',
             'Karnataka', 'Telangana')
            THEN 'South'
        ELSE 'Other'
    END
FROM STAGING.customers_raw;
```

------------------------------------------------------------------------

# 23. Create Product Dimension

``` sql
CREATE OR REPLACE TABLE dim_product
(
    product_key NUMBER AUTOINCREMENT,
    product_id NUMBER,
    product_name VARCHAR(100),
    category VARCHAR(100),
    unit_price NUMBER(12,2)
);
```

Load:

``` sql
INSERT INTO dim_product
(
    product_id,
    product_name,
    category,
    unit_price
)
SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM STAGING.products_raw;
```

------------------------------------------------------------------------

# 24. Create Sales Fact

``` sql
CREATE OR REPLACE TABLE fact_sales
(
    sales_key NUMBER AUTOINCREMENT,
    purchase_id NUMBER,
    date_key NUMBER,
    customer_key NUMBER,
    product_key NUMBER,
    quantity NUMBER,
    sales_amount NUMBER(14,2)
);
```

Load:

``` sql
INSERT INTO fact_sales
(
    purchase_id,
    date_key,
    customer_key,
    product_key,
    quantity,
    sales_amount
)
SELECT
    p.purchase_id,
    d.date_key,
    c.customer_key,
    pr.product_key,
    p.quantity,
    p.total_amount
FROM STAGING.purchases_raw p
JOIN CORE.dim_date d
    ON d.full_date = p.purchase_date
JOIN CORE.dim_customer c
    ON c.customer_id = p.customer_id
JOIN CORE.dim_product pr
    ON pr.product_id = p.product_id;
```

------------------------------------------------------------------------

# 25. Final Star Schema

``` text
                     CORE.DIM_DATE
                           |
                           |
CORE.DIM_CUSTOMER ---> CORE.FACT_SALES <--- CORE.DIM_PRODUCT
                           |
                           |
                      Sales Measures
```

------------------------------------------------------------------------

# 26. Basic Analytical Queries

## Revenue by Customer

``` sql
SELECT
    c.customer_name,
    SUM(f.sales_amount) AS total_revenue
FROM CORE.fact_sales f
JOIN CORE.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_name
ORDER BY total_revenue DESC;
```

## Revenue by Category

``` sql
SELECT
    p.category,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue DESC;
```

## Monthly Revenue

``` sql
SELECT
    d.year_number,
    d.month_number,
    d.month_name,
    SUM(f.sales_amount) AS monthly_revenue
FROM CORE.fact_sales f
JOIN CORE.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year_number,
    d.month_number,
    d.month_name
ORDER BY
    d.year_number,
    d.month_number;
```

## Revenue by Region

``` sql
SELECT
    c.region,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.region
ORDER BY revenue DESC;
```

## Top Products

``` sql
SELECT
    p.product_name,
    p.category,
    SUM(f.quantity) AS units_sold,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    p.product_name,
    p.category
ORDER BY revenue DESC;
```

------------------------------------------------------------------------

# 27. Analytics Layer

``` sql
USE SCHEMA ANALYTICS;

CREATE OR REPLACE TABLE customer_revenue AS
SELECT
    c.customer_key,
    c.customer_name,
    c.region,
    SUM(f.sales_amount) AS total_revenue,
    SUM(f.quantity) AS total_units
FROM CORE.fact_sales f
JOIN CORE.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.customer_name,
    c.region;
```

Query:

``` sql
SELECT *
FROM ANALYTICS.customer_revenue
ORDER BY total_revenue DESC;
```

------------------------------------------------------------------------

# 28. Data Warehouse Lifecycle

``` text
1. Business Requirements
          |
          v
2. Source Analysis
          |
          v
3. Data Modelling
          |
          v
4. Ingestion
          |
          v
5. Staging
          |
          v
6. Transformation
          |
          v
7. Warehouse Loading
          |
          v
8. Data Quality
          |
          v
9. BI / Analytics
          |
          v
10. Monitoring
          |
          v
11. Optimization
          |
          +------> Continuous Improvement
```

### Lifecycle details

**1. Requirements**

Identify business questions, KPIs, refresh frequency, history, and
consumers.

**2. Source analysis**

Identify databases, files, APIs, SaaS systems, and streams.

**3. Modelling**

Define facts, dimensions, grain, keys, relationships, and history
strategy.

**4. Ingestion**

Bring data into the warehouse environment.

**5. Staging**

Land raw/lightly processed data.

**6. Transformation**

Clean, standardize, validate, deduplicate, enrich, and join.

**7. Loading**

Populate dimensions and facts.

**8. Data quality**

Validate completeness, uniqueness, referential integrity, and business
rules.

**9. BI**

Expose trusted datasets to dashboards and reports.

**10. Monitoring**

Monitor freshness, failures, volume, costs, and performance.

**11. Optimization**

Improve queries, warehouse sizing, data organization, and workload
design.

------------------------------------------------------------------------

# 29. Data Quality Labs

### Duplicate customers

``` sql
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM STAGING.customers_raw
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

### Missing IDs

``` sql
SELECT *
FROM STAGING.customers_raw
WHERE customer_id IS NULL;
```

### Invalid sales

``` sql
SELECT *
FROM STAGING.purchases_raw
WHERE total_amount < 0;
```

### Orphan customers

``` sql
SELECT p.*
FROM STAGING.purchases_raw p
LEFT JOIN STAGING.customers_raw c
    ON p.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

------------------------------------------------------------------------

# 30. Performance Benchmarking

Performance benchmarking means measuring a workload under controlled
conditions.

Typical metrics:

``` text
Execution Time
Rows Produced
Bytes Scanned
Warehouse Size
Concurrency
Credits
Cache State
```

A good benchmark:

``` text
Same data
   |
Same query
   |
Same warehouse
   |
Controlled cache
   |
Multiple runs
   |
Collect metrics
   |
Compare
```

Do not compare two queries while simultaneously changing the warehouse
size, data volume, and cache state.

------------------------------------------------------------------------

# 31. Query History

A useful Snowflake metadata query is:

``` sql
SELECT
    QUERY_ID,
    QUERY_TEXT,
    EXECUTION_STATUS,
    TOTAL_ELAPSED_TIME,
    BYTES_SCANNED,
    ROWS_PRODUCED
FROM TABLE(
    INFORMATION_SCHEMA.QUERY_HISTORY(
        END_TIME_RANGE_START =>
            DATEADD('hour', -1, CURRENT_TIMESTAMP()),
        END_TIME_RANGE_END =>
            CURRENT_TIMESTAMP()
    )
)
ORDER BY START_TIME DESC;
```

Permissions and metadata availability depend on the Snowflake
environment.

------------------------------------------------------------------------

# 32. Benchmark Query 1

``` sql
SELECT
    p.category,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category;
```

Record:

``` text
Query ID:
Elapsed Time:
Bytes Scanned:
Rows Produced:
Warehouse:
```

------------------------------------------------------------------------

# 33. Benchmark Query 2

``` sql
SELECT
    c.region,
    d.year_number,
    d.month_number,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_customer c
    ON f.customer_key = c.customer_key
JOIN CORE.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    c.region,
    d.year_number,
    d.month_number
ORDER BY
    d.year_number,
    d.month_number;
```

------------------------------------------------------------------------

# 34. Warehouse-Sizing Benchmark

Run a controlled experiment.

``` sql
ALTER WAREHOUSE SMARTMART_WH
SET WAREHOUSE_SIZE = 'XSMALL';
```

Run the workload.

Then:

``` sql
ALTER WAREHOUSE SMARTMART_WH
SET WAREHOUSE_SIZE = 'SMALL';
```

Run again.

Then:

``` sql
ALTER WAREHOUSE SMARTMART_WH
SET WAREHOUSE_SIZE = 'MEDIUM';
```

Record:

  Warehouse     Runtime   Bytes Scanned   Credits Notes
  ----------- --------- --------------- --------- -------
  XSMALL                                          
  SMALL                                           
  MEDIUM                                          

The purpose is to measure the workload, not assume that a larger
warehouse always gives proportional speedup.

------------------------------------------------------------------------

# 35. Benchmarking Cache Effects

For repeatable benchmarking, understand that cached results can make
later executions substantially different.

Therefore record:

``` text
First run
Second run
Third run
```

and distinguish:

``` text
Cached result
vs
Fresh computation
```

Snowflake recommends controlling result caching when conducting
benchmark experiments intended to be comparable.

------------------------------------------------------------------------

# 36. Micro-Partitions

Conceptually:

``` text
FACT_SALES
|
+-- Micro-partition 1
|      Jan 1 - Jan 10
|
+-- Micro-partition 2
|      Jan 11 - Jan 20
|
+-- Micro-partition 3
|      Jan 21 - Jan 31
|
+-- Micro-partition 4
       Feb 1 - Feb 10
```

A selective predicate can allow irrelevant micro-partitions to be
skipped.

Example:

``` sql
SELECT
    SUM(sales_amount)
FROM CORE.fact_sales
WHERE date_key BETWEEN 20260101 AND 20260131;
```

Conceptually:

``` text
All partitions
      |
      v
Date filter
      |
      +---- Skip irrelevant partitions
      |
      v
Read relevant data
```

------------------------------------------------------------------------

# 37. Clustering in Snowflake

A clustering key can be defined when it is justified by the workload.

Example:

``` sql
CREATE OR REPLACE TABLE fact_sales_clustered
CLUSTER BY (date_key)
AS
SELECT *
FROM CORE.fact_sales;
```

Inspect clustering information:

``` sql
SELECT SYSTEM$CLUSTERING_INFORMATION(
    'SMARTMART_DWH.CORE.FACT_SALES_CLUSTERED'
);
```

Clustering is not something to add to every table. It is generally most
useful when large tables have recurring selective access patterns that
benefit from improved data organization.

------------------------------------------------------------------------

# 38. CTAS --- Create Table As Select

Snowflake supports CTAS.

``` sql
CREATE OR REPLACE TABLE ANALYTICS.monthly_sales AS
SELECT
    d.year_number,
    d.month_number,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year_number,
    d.month_number;
```

This is useful for creating derived analytical datasets.

------------------------------------------------------------------------

# 39. Raw vs Dimensional Performance Lab

Raw query:

``` sql
SELECT
    c.state,
    p.category,
    SUM(pr.total_amount) AS revenue
FROM STAGING.purchases_raw pr
JOIN STAGING.customers_raw c
    ON pr.customer_id = c.customer_id
JOIN STAGING.products_raw p
    ON pr.product_id = p.product_id
GROUP BY
    c.state,
    p.category;
```

Dimensional query:

``` sql
SELECT
    c.state,
    p.category,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_customer c
    ON f.customer_key = c.customer_key
JOIN CORE.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    c.state,
    p.category;
```

On this tiny training dataset, performance differences may be
insignificant. The purpose is to understand the architecture and how the
model changes analytical access patterns.

------------------------------------------------------------------------

# 40. TPC-DS Benchmark Extension

Snowflake provides TPC-H and TPC-DS sample datasets for evaluating
analytical SQL support.

TPC-DS is particularly useful for decision-support benchmarking and
contains many fact/dimension relationships and analytical queries.

If available in your account:

``` sql
SHOW DATABASES;
```

Then:

``` sql
SHOW SCHEMAS IN DATABASE SNOWFLAKE_SAMPLE_DATA;
```

Example:

``` sql
SELECT *
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
LIMIT 10;
```

TPC-DS contains 99 benchmark queries with varied analytical complexity.

Use TPC-DS as an **optional performance lab**; keep `SMARTMART_DWH` as
the main teaching database.

------------------------------------------------------------------------

# 41. SmartMart End-to-End Architecture

``` text
                  SMARTMART SOURCES
                         |
        +----------------+----------------+
        |                |                |
        v                v                v
      POS             CRM             E-COMMERCE
        |                |                |
        +----------------+----------------+
                         |
                         v
             SMARTMART_DWH.STAGING
                         |
             +-----------+-----------+
             |           |           |
             v           v           v
        customers_raw products_raw purchases_raw
                         |
                         v
              SMARTMART_DWH.CORE
                         |
       +-----------------+------------------+
       |                 |                  |
       v                 v                  v
 dim_customer       dim_product        dim_date
       \                 |                 /
        \                |                /
         +---------------+---------------+
                         |
                         v
                    fact_sales
                         |
                         v
             SMARTMART_DWH.ANALYTICS
                         |
            +------------+------------+
            |            |            |
            v            v            v
       monthly_sales customer_revenue product_performance
                         |
                         v
                    BI / Dashboard
```

------------------------------------------------------------------------

# 42. ETL vs ELT

### ETL

``` text
Extract
   |
   v
Transform
   |
   v
Load
```

### ELT

``` text
Extract
   |
   v
Load
   |
   v
Transform
```

A modern cloud warehouse such as Snowflake commonly supports ELT
patterns where raw data is loaded first and transformations execute
using warehouse compute.

------------------------------------------------------------------------

# 43. Slowly Changing Dimensions

Suppose:

``` text
Arun
City = Coimbatore
```

Later:

``` text
Arun
City = Chennai
```

### Type 1

Overwrite:

``` text
Arun -> Chennai
```

### Type 2

Preserve history:

``` text
Arun | Coimbatore | 2025-01-01 | 2026-03-01
Arun | Chennai    | 2026-03-01 | NULL
```

Typical Type 2 columns:

``` text
customer_key
customer_id
customer_name
city
effective_start_date
effective_end_date
is_current
```

------------------------------------------------------------------------

# 44. Capstone Lab

Build the complete SmartMart warehouse.

### Database

``` text
SMARTMART_DWH
```

### Schemas

``` text
STAGING
CORE
ANALYTICS
```

### Staging

``` text
customers_raw
products_raw
purchases_raw
```

### Core

``` text
dim_customer
dim_product
dim_date
fact_sales
```

### Analytics

``` text
customer_revenue
monthly_sales
product_performance
```

### Required reports

1.  Revenue by state
2.  Revenue by region
3.  Revenue by product category
4.  Monthly revenue
5.  Top 10 customers
6.  Top products
7.  Units sold by category
8.  Customer segment revenue
9.  Performance benchmark
10. Query-history analysis

------------------------------------------------------------------------

# 45. Capstone Queries

## Revenue by State

``` sql
SELECT
    c.state,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.state
ORDER BY revenue DESC;
```

## Revenue by Category

``` sql
SELECT
    p.category,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue DESC;
```

## Monthly Trend

``` sql
SELECT
    d.year_number,
    d.month_number,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year_number,
    d.month_number
ORDER BY
    d.year_number,
    d.month_number;
```

## Top Customer

``` sql
SELECT
    c.customer_name,
    SUM(f.sales_amount) AS revenue
FROM CORE.fact_sales f
JOIN CORE.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 1;
```

------------------------------------------------------------------------

# 46. Interview Questions

### Q1. What is a data warehouse?

A centralized analytical store containing integrated and historical data
for reporting and analytics.

### Q2. OLTP vs OLAP?

OLTP supports operational transactions; OLAP supports analytical queries
and decision-making.

### Q3. What is a fact table?

A table representing measurable business events.

### Q4. What is a dimension?

A descriptive business entity used to analyze facts.

### Q5. What is a star schema?

A central fact table connected directly to dimension tables.

### Q6. What is Snowflake?

A cloud data platform providing scalable storage, compute, SQL
analytics, and related data capabilities.

### Q7. What is a virtual warehouse?

A Snowflake compute cluster used for queries and DML.

### Q8. What is a schema?

A logical grouping of database objects such as tables and views.

### Q9. Why use staging?

To isolate source data before transformation into trusted warehouse
structures.

### Q10. ETL vs ELT?

ETL transforms before loading; ELT loads first and transforms within the
analytical platform.

### Q11. What is a slowly changing dimension?

A strategy for managing changes to dimension attributes over time.

### Q12. Why use a date dimension?

To provide standardized calendar attributes for analytical reporting.

### Q13. What is performance benchmarking?

Controlled measurement of workload performance under defined conditions.

### Q14. What are micro-partitions?

Snowflake's automatic physical storage units used to organize table data
and enable efficient pruning.

### Q15. Should every Snowflake table have a clustering key?

No. Clustering should be introduced when workload characteristics
justify it, especially for large tables.

------------------------------------------------------------------------

# 47. Practical Performance Interview Scenario

### Question

A dashboard takes 45 seconds. What do you investigate?

### Answer framework

``` text
1. Query history
       |
2. Query profile
       |
3. Bytes scanned
       |
4. Rows processed
       |
5. Warehouse size
       |
6. Join cardinality
       |
7. Predicate selectivity
       |
8. Micro-partition pruning
       |
9. Clustering
       |
10. Cache effects
       |
11. Concurrency
       |
12. Re-test
```

Do not immediately increase warehouse size.

First identify whether the bottleneck is:

``` text
Query Design
     OR
Data Organization
     OR
Compute
     OR
Concurrency
```

------------------------------------------------------------------------

# 48. Learning Roadmap

``` text
SQL
 |
 v
OLTP
 |
 v
OLAP
 |
 v
Data Warehouse
 |
 v
Dimensional Modelling
 |
 +--> Fact
 +--> Dimension
 +--> Star Schema
 +--> SCD
 |
 v
ETL / ELT
 |
 v
Snowflake
 |
 +--> Database
 +--> Schema
 +--> Warehouse
 +--> Tables
 +--> Micro-partitions
 |
 v
Performance
 |
 +--> Query History
 +--> Benchmarking
 +--> Clustering
 +--> Caching
 +--> Warehouse Sizing
 |
 v
Production Data Engineering
```

------------------------------------------------------------------------

# 49. Key Takeaways

``` text
OLTP
= Run the business

OLAP
= Analyze the business

DWH
= Historical + integrated analytical data

FACT
= What happened?

DIMENSION
= Who / What / Where / When?

STAR SCHEMA
= Fact + Dimensions

SNOWFLAKE
= Cloud data platform + scalable compute

VIRTUAL WAREHOUSE
= Compute for SQL and DML

STAGING
= Landing / raw layer

CORE
= Trusted dimensional model

ANALYTICS
= Business-ready datasets

BENCHMARKING
= Measure before optimizing
```

> **Build the warehouse around business questions, validate data quality
> at every layer, and benchmark performance using controlled workloads
> rather than assumptions.**

------------------------------------------------------------------------

# 50. Official References

-   Snowflake database/schema DDL:
    https://docs.snowflake.com/en/sql-reference/ddl-database
-   Snowflake CREATE TABLE:
    https://docs.snowflake.com/en/sql-reference/sql/create-table
-   Snowflake virtual warehouses:
    https://docs.snowflake.com/en/user-guide/warehouses
-   Snowflake performance optimization:
    https://docs.snowflake.com/en/guides-overview-performance
-   Snowflake interactive performance:
    https://docs.snowflake.com/en/user-guide/interactive-performance
-   Snowflake sample data:
    https://docs.snowflake.com/en/user-guide/sample-data
-   Snowflake TPC-DS:
    https://docs.snowflake.com/en/user-guide/sample-data-tpcds
