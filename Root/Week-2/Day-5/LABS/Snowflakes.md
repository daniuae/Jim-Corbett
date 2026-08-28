# Snowflake: End-to-End Analysis

## What You Will Do

1. Load a real CSV file
2. Explore & clean data
3. Write 5 easy SQL queries
4. Build a dashboard

---

## Step 1 – Create Your Lab Database & Table

Open a new worksheet and run this once:

```sql
CREATE OR REPLACE DATABASE COFFEE_LAB;
CREATE OR REPLACE SCHEMA DATA;
USE DATABASE COFFEE_LAB;
USE SCHEMA DATA;
```

Create the `SALES` table:

```sql
CREATE OR REPLACE TABLE SALES (
    SALE_DATE DATE,
    STORE STRING,
    PRODUCT STRING,
    QUANTITY INT,
    PRICE NUMBER(10,2),
    CUSTOMER_AGE INT
);
```

---

## Step 2 – Load Real Data

### 1. Create the CSV File

Create a file named `coffee_sales.csv` and paste:

```csv
SALE_DATE,STORE,PRODUCT,QUANTITY,PRICE,CUSTOMER_AGE
2025-01-01,London,Latte,2,4.50,28
2025-01-01,Paris,Espresso,1,3.20,35
2025-01-02,London,Cappuccino,3,4.80,42
2025-01-02,Berlin,Latte,1,4.20,19
2025-01-03,Paris,Americano,2,3.50,55
2025-01-03,London,Latte,4,4.50,31
2025-01-04,Berlin,Cappuccino,2,4.60,27
2025-01-05,Paris,Latte,3,4.30,38
```

### 2. Upload the CSV to Snowflake

1. Open the left sidebar.
2. Go to **Databases → COFFEE_LAB → DATA → Tables**.
3. Select the `SALES` table.
4. Click **Load Data**.
5. Select warehouse `COMPUTE_WH` → **Next**.
6. Drag and drop `coffee_sales.csv` → **Next**.
7. Select **CSV** and check **First row contains column names**.
8. Click **Load → Append → Load**.

You should see a confirmation similar to **8 rows loaded**.

---

## Step 3 – Explore & Clean with Clicks

1. Click the `SALES` table.
2. Open **Data Preview**.
3. Select `CUSTOMER_AGE`.
4. Open **Profile**.

You can inspect minimum, maximum, average, distribution, and potential data-quality issues.

---

## Step 4 – Build a Dashboard with Drag & Drop

### 1. Create the Dashboard

Go to **Dashboards → + Dashboard** and name it:

**Coffee Sales Dashboard**

### 2. Add a Data Table

**+ Tile → Choose Table → SALES**

### 3. Recommended Chart Tiles

| Tile | Purpose |
|---|---|
| Total Revenue | Overall sales performance |
| Revenue by Product | Identify best-performing products |
| Revenue by Store | Compare store performance |
| Transactions by Store | Compare transaction volume |
| Average Customer Age | Understand customer demographics |
| Daily Sales | Identify high-performing sales days |

Drag tile corners to resize and click **Done**.

---

## Step 5 – Your First Analysis Queries

### Query 1 – Total Sales Amount

```sql
SELECT SUM(QUANTITY * PRICE) AS TOTAL_REVENUE
FROM SALES;
```

### Query 2 – Sales by Product

```sql
SELECT PRODUCT, SUM(QUANTITY * PRICE) AS REVENUE
FROM SALES
GROUP BY PRODUCT
ORDER BY REVENUE DESC;
```

### Query 3 – Sales by Store

```sql
SELECT STORE, COUNT(*) AS TRANSACTIONS, SUM(QUANTITY * PRICE) AS REVENUE
FROM SALES
GROUP BY STORE
ORDER BY REVENUE DESC;
```

### Query 4 – Average Customer Age per Store

```sql
SELECT STORE, ROUND(AVG(CUSTOMER_AGE)) AS AVG_AGE
FROM SALES
GROUP BY STORE;
```

### Query 5 – Best-Selling Day

```sql
SELECT SALE_DATE, SUM(QUANTITY * PRICE) AS DAILY_SALES
FROM SALES
GROUP BY SALE_DATE
ORDER BY DAILY_SALES DESC
LIMIT 1;
```

---

## Step 6 – Share Your Dashboard

1. Click **Share**.
2. Enable sharing if required.
3. Copy the dashboard link.
4. Share it with your intended audience.

> **Note:** Viewer access depends on your Snowflake account configuration, permissions, and sharing settings. Verify access before distributing the link.

---

# End-to-End Lab Flow

```text
                 SNOWFLAKE COFFEE SALES LAB

                           START
                             │
                             ▼
                Create COFFEE_LAB Database
                             │
                             ▼
                    Create DATA Schema
                             │
                             ▼
                      Create SALES Table
                             │
                             ▼
                      Create CSV File
                             │
                             ▼
                     Load CSV into SALES
                             │
                             ▼
                   Preview & Profile Data
                             │
                             ▼
                   Analyze with SQL Queries
                             │
               ┌─────────────┼─────────────┐
               ▼             ▼             ▼
          Total Revenue Product Revenue Store Revenue
               │             │             │
               └─────────────┼─────────────┘
                             ▼
                    Dashboard Creation
                             │
                             ▼
                    Add Charts & Tables
                             │
                             ▼
                     Share Dashboard
                             │
                             ▼
                            END
```

---

# Lab Checklist

- [ ] Created `COFFEE_LAB` database
- [ ] Created `DATA` schema
- [ ] Created `SALES` table
- [ ] Created `coffee_sales.csv`
- [ ] Loaded CSV into Snowflake
- [ ] Confirmed 8 rows were loaded
- [ ] Previewed the `SALES` table
- [ ] Profiled `CUSTOMER_AGE`
- [ ] Calculated total revenue
- [ ] Analyzed revenue by product
- [ ] Analyzed revenue by store
- [ ] Calculated average customer age
- [ ] Identified the best-selling day
- [ ] Created `Coffee Sales Dashboard`
- [ ] Added tables/charts
- [ ] Resized dashboard tiles
- [ ] Shared the dashboard

---

# Learning Outcomes

After completing this lab, you should be able to:

1. Create a Snowflake database, schema, and table.
2. Load CSV data into Snowflake.
3. Perform basic data exploration and profiling.
4. Calculate revenue using SQL expressions.
5. Use `GROUP BY` for business analysis.
6. Sort analytical results using `ORDER BY`.
7. Limit results using `LIMIT`.
8. Build a simple Snowflake dashboard.
9. Convert raw sales data into useful business insights.
