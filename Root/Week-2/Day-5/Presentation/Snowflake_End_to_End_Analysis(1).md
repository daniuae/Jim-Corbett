# Snowflake: End-to-End Analysis

## What You Will Do

In this lab, you will complete an end-to-end coffee sales analysis in Snowflake.

You will:

- Load a real CSV file.
- Explore and clean the data.
- Write five easy SQL queries.
- Build a simple dashboard.
- Convert raw sales data into useful business insights.

---

## Lab Checklist

- [x] Created `COFFEE_LAB` database
- [x] Created `DATA` schema
- [x] Created `SALES` table
- [x] Created `coffee_sales.csv`
- [x] Loaded CSV into Snowflake
- [x] Confirmed 8 rows were loaded
- [x] Previewed the `SALES` table
- [x] Profiled `CUSTOMER_AGE`
- [x] Calculated total revenue
- [x] Analyzed revenue by product
- [x] Analyzed revenue by store
- [x] Calculated average customer age
- [x] Identified the best-selling day
- [x] Created Coffee Sales Dashboard
- [x] Added tables/charts
- [x] Resized dashboard tiles
- [x] Shared the dashboard

---

## Learning Outcomes

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

---

## End-to-End Flow

```text
CSV File
   ↓
Load into Snowflake
   ↓
COFFEE_LAB Database
   ↓
DATA Schema
   ↓
SALES Table
   ↓
Explore & Profile Data
   ↓
Write SQL Queries
   ↓
Analyze Revenue & Sales
   ↓
Build Dashboard
   ↓
Business Insights
```

---

## Key Analysis Areas

### 1. Data Exploration

Preview the `SALES` table and understand the available columns and records.

### 2. Data Profiling

Examine important fields such as `CUSTOMER_AGE` to understand the data distribution and identify potential data-quality issues.

### 3. Revenue Analysis

Calculate total revenue from the sales data and understand how revenue is generated.

### 4. Product Analysis

Group sales by product to identify products contributing the most revenue.

### 5. Store Analysis

Analyze revenue by store to compare store-level performance.

### 6. Customer Analysis

Calculate the average customer age to understand the customer profile represented in the dataset.

### 7. Day Analysis

Identify the best-selling day using aggregated sales results and sorting.

---

## SQL Concepts Practiced

| SQL Concept | Purpose |
|---|---|
| `SELECT` | Retrieve data |
| `WHERE` | Filter records |
| Aggregate functions | Calculate metrics such as `SUM()` and `AVG()` |
| `GROUP BY` | Analyze data by category |
| `ORDER BY` | Sort analytical results |
| `LIMIT` | Restrict the number of returned rows |
| SQL expressions | Calculate derived metrics such as revenue |

---

## Dashboard

The **Coffee Sales Dashboard** provides a simple visual summary of the analysis.

Recommended dashboard components include:

- Total Revenue
- Revenue by Product
- Revenue by Store
- Average Customer Age
- Best-Selling Day
- Sales Data Table

Dashboard tasks completed:

- Added tables and charts.
- Resized dashboard tiles.
- Organized the dashboard for readability.
- Shared the dashboard.

---

## Business Insights

The final goal of the lab is not only to execute SQL but also to translate the results into business insights.

For example:

- Which product generates the most revenue?
- Which store performs best?
- What is the average customer age?
- Which day has the highest sales?
- What patterns can be observed in the sales data?

> **Remember:** SQL produces the numbers; analysis turns those numbers into decisions.

---

## Lab Completion

At the end of this exercise, you should have:

- A Snowflake database named `COFFEE_LAB`.
- A `DATA` schema.
- A `SALES` table containing the loaded CSV data.
- SQL analysis results.
- A Coffee Sales Dashboard.
- A set of business insights derived from the sales data.

---

## Skills Demonstrated

**Snowflake + SQL + Data Analysis + Data Visualization + Business Intelligence**

This lab demonstrates a complete beginner-friendly analytics workflow:

```text
Load → Explore → Clean → Query → Analyze → Visualize → Share → Decide
```
