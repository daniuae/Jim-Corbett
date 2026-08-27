# ETL & ELT Training Labs

This repository contains hands-on labs for understanding **ETL, ELT, data integration, data transformation, Snowflake compute management, and dimensional data warehousing**.

The exercises are designed around practical scenarios so that learners can understand not only the concepts, but also how data moves from source systems into analytics-ready structures.

---

## 📚 Labs Overview

The training material covers three major areas:

1. **Snowflake ETL Lab**
2. **Snowflake Compute Management Lab**
3. **MySQL ETL vs ELT Implementation Lab**

The labs progressively demonstrate how raw data is ingested, transformed, validated, and loaded into structures suitable for analytics and BI.

---

# 1. Snowflake ETL Lab

## 🎯 Goal

Load a CSV file into a Snowflake table and understand the basic workflow of ingesting file-based data into Snowflake.

The lab uses an employee dataset containing:

* Employee ID
* First Name
* Department
* Salary
* Start Date

The learner creates an `EMPLOYEES` table, uses Snowflake's **Load Data** wizard, and validates the loaded records.

## Key Activities

* Prepare an `employees.csv` file
* Create a Snowflake table
* Navigate Snowflake databases and schemas
* Use the **Load Data** wizard
* Load CSV data into Snowflake
* Preview the loaded data
* Validate the data using SQL
* Clean up the lab environment

### Example validation

```sql
SELECT *
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;
```

### Learning Outcome

By completing this lab, learners understand the basic process of moving structured CSV data into Snowflake and validating the resulting table.

---

# 2. Snowflake Compute Management

## 🎯 Goal

Understand how Snowflake virtual warehouses provide the compute resources required to execute queries.

The lab demonstrates how to:

* Identify the current warehouse
* Create warehouses
* Create warehouses of different sizes
* Switch between warehouses
* Resize a warehouse
* Compare query execution using different warehouse sizes
* Suspend warehouses
* Understand auto-suspend
* Resume warehouses automatically

### Identify the Current Warehouse

```sql
SELECT CURRENT_WAREHOUSE(), CURRENT_USER();
```

### Query Used for Compute Testing

The lab uses Snowflake's `GENERATOR` function to create a large synthetic dataset and compare execution using different warehouse sizes.

```sql
SELECT SEQ4() AS N, RAND() AS R
FROM TABLE(GENERATOR(ROWCOUNT => 100000000));
```

### Key Concept

A Snowflake warehouse is the **compute engine** used to execute queries.

Warehouse sizing and suspension therefore have an important relationship with:

* Query performance
* Compute consumption
* Cost management

The lab also demonstrates **auto-suspend**, where a warehouse becomes suspended after a configured period of inactivity, and **auto-resume**, where it becomes active again when a query is executed.

---

# 3. MySQL ETL and ELT Lab

## 🛒 Business Scenario

**ShopNow**, an e-commerce startup, receives daily CSV files from its website:

```text
customers.csv
products.csv
orders.csv
order_items.csv
```

The incoming data is intentionally messy and contains issues such as:

* Extra spaces
* Different date formats
* Missing values
* Text-based source fields
* Data requiring type conversion

The analytics team needs to transform this source data into a clean **star schema** in MySQL for dashboards and finance checks.

---

# 🔄 ETL vs ELT

This lab implements **both ETL and ELT approaches** using the same business scenario.

## ETL

**Extract → Transform → Load**

Data is transformed during the ingestion process before it reaches the final target structure.

In this lab, MySQL's:

```sql
LOAD DATA ... SET ...
```

is used to perform transformations while loading CSV data into clean staging tables.

Examples include:

* Trimming spaces
* Converting strings to numeric values
* Standardizing country codes
* Parsing dates

## ELT

**Extract → Load → Transform**

Data is first loaded into raw tables with minimal or no transformation.

SQL is then used to transform the raw data into the target dimensional model.

The lab uses:

```sql
INSERT ... SELECT ...
```

along with functions such as:

```sql
TRIM()
CAST()
COALESCE()
STR_TO_DATE()
UPPER()
NULLIF()
```

---

# 🏗️ Data Architecture

The MySQL lab separates the environment into two logical databases:

```text
                 SOURCE
                   │
                   ▼
        ┌─────────────────────┐
        │      CSV FILES      │
        │ customers.csv       │
        │ products.csv        │
        │ orders.csv          │
        │ order_items.csv     │
        └──────────┬──────────┘
                   │
          ┌────────┴────────┐
          │                 │
          ▼                 ▼
        ETL                ELT
          │                 │
          ▼                 ▼
   Clean Staging        Raw Tables
          │                 │
          │                 ▼
          │            SQL Transformations
          │                 │
          └────────┬────────┘
                   ▼
             STAR SCHEMA
                   │
          ┌────────┴─────────┐
          ▼                  ▼
   DIMENSIONS             FACT
          │                  │
          ▼                  ▼
 dim_customer          fact_order
 dim_product
          │
          ▼
      BI / Reporting
```

---

# 🗄️ Database Structure

The lab creates two databases:

```sql
CREATE DATABASE IF NOT EXISTS shopnow_raw;

CREATE DATABASE IF NOT EXISTS shopnow_dw;
```

## Raw Database

The `shopnow_raw` database contains the source data in raw form.

```text
shopnow_raw
│
├── customers_raw
├── products_raw
├── orders_raw
└── order_items_raw
```

The raw tables intentionally use text-friendly data types so that messy source data can be landed without immediately enforcing strict target formats.

---

# 🏛️ Data Warehouse

The transformed data is loaded into `shopnow_dw`.

```text
shopnow_dw
│
├── dim_customer
├── dim_product
├── fact_order
│
├── stg_customers_etl
└── stg_order_items_etl
```

The dimensional model consists of:

### `dim_customer`

Stores customer information such as:

* Customer key
* Customer ID
* Name
* Email
* Country
* Created date

### `dim_product`

Stores product information such as:

* Product key
* Product ID
* SKU
* Product name
* Category
* Unit price

### `fact_order`

Stores transactional information such as:

* Order ID
* Customer key
* Product key
* Order date
* Currency
* Order status
* Quantity
* Item price
* Line amount

The fact table contains foreign-key relationships to the customer and product dimensions.

---

# 🧹 Data Transformation

The ELT implementation demonstrates practical data cleansing and transformation techniques.

### String Cleaning

```sql
TRIM()
NULLIF()
UPPER()
```

These functions are used to remove unnecessary spaces, handle empty values, and standardize text.

### Data Type Conversion

Source values are converted from strings into appropriate warehouse types using:

```sql
CAST()
```

For example:

```text
VARCHAR → INT
VARCHAR → DECIMAL
VARCHAR → DATE
```

### Date Standardization

The source data can contain multiple date formats:

```text
YYYY-MM-DD
MM/DD/YYYY
```

The lab uses `STR_TO_DATE()` and `COALESCE()` to support both formats.

### Business Rules

The example applies a business rule that only **PAID** orders should be loaded into the fact table.

Cancelled orders are excluded from `fact_order`.

---

# 🔍 Data Validation

A data pipeline is not complete simply because data was loaded successfully.

The lab therefore includes validation checks for:

## 1. Row Counts

Compare the number of records in:

* Raw tables
* Dimension tables
* Fact tables
* ETL staging tables

## 2. Referential Integrity

Verify that every fact record references an existing:

* Customer
* Product

## 3. Business Rules

Verify that cancelled orders do not appear in the fact table.

## 4. Revenue Validation

Calculate total revenue using:

```text
Quantity × Unit Price
```

and validate revenue at both:

* Overall level
* Individual order level

---

# 📊 Business Query

The warehouse can then support analytical queries such as identifying the products generating the highest revenue.

Example:

```sql
SELECT
    dp.product_name,
    SUM(fo.line_amount) AS revenue
FROM shopnow_dw.fact_order fo
JOIN shopnow_dw.dim_product dp
    ON fo.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY revenue DESC;
```

This demonstrates how the dimensional model can be used as the foundation for business intelligence and reporting.

---

# 🔁 Incremental Loads

The lab also introduces concepts required for production-oriented data pipelines.

## Dimension Upserts

The product dimension demonstrates an `INSERT ... ON DUPLICATE KEY UPDATE` pattern to update existing records or insert new records.

This helps make dimension loading more **idempotent**.

## Late-Arriving Facts

The lab introduces the concept of late-arriving facts:

> Facts should only be inserted when their related dimensions exist; otherwise they can be staged and reprocessed later.

---

# 🆚 ETL vs ELT — Final Comparison

| Area                    | ETL                        | ELT                             |
| ----------------------- | -------------------------- | ------------------------------- |
| Transformation          | During loading             | After loading                   |
| Initial landing         | Clean staging              | Raw tables                      |
| Main SQL pattern        | `LOAD DATA ... SET`        | `INSERT ... SELECT`             |
| Raw data preservation   | Limited in this example    | Yes                             |
| Transformation location | In ingestion process       | Inside database                 |
| Reprocessing            | More dependent on pipeline | Easier from raw layer           |
| Transparency            | Moderate                   | High                            |
| Best demonstrated by    | Clean staging loads        | Raw → warehouse transformations |

The lab emphasizes that **both approaches are valid** and that real-world organizations may use a **hybrid approach**: raw data can be preserved for transparency and repeatability while ETL-style processing can still be used for specific cleansing requirements.

---

# 🛠️ Prerequisites

## Snowflake

* Snowflake account
* Access to Snowsight
* Permission to create tables and warehouses

## MySQL

* MySQL 8.x
* Ability to create databases and tables
* Ability to load CSV files
* `LOCAL INFILE` enabled when using client-side file loading

For example:

```sql
SET GLOBAL local_infile = 1;
```

The MySQL client may also need to be started with:

```bash
mysql --local-infile=1 -u <user> -p
```

---

# 🎓 Learning Outcomes

After completing these labs, learners should be able to:

* Explain the difference between ETL and ELT
* Load CSV data into Snowflake
* Work with Snowflake virtual warehouses
* Understand warehouse sizing and compute management
* Create raw and staging layers
* Load raw data into MySQL
* Transform data using SQL
* Clean and standardize source data
* Handle missing and malformed values
* Convert source data types
* Standardize multiple date formats
* Build a basic star schema
* Create dimension and fact tables
* Apply foreign-key relationships
* Validate row counts
* Perform referential integrity checks
* Validate business rules
* Calculate and verify revenue
* Perform incremental dimension loads
* Understand late-arriving facts
* Compare ETL and ELT architectures

---

# 🚀 Suggested Learning Flow

```text
1. Understand ETL & ELT
          ↓
2. Load CSV into Snowflake
          ↓
3. Explore Snowflake Compute
          ↓
4. Understand Raw Data
          ↓
5. Implement ELT in MySQL
          ↓
6. Implement ETL in MySQL
          ↓
7. Build Star Schema
          ↓
8. Validate Data
          ↓
9. Run Business Queries
          ↓
10. Implement Incremental Loads
```

---

# 📌 Key Takeaway

The central objective of these labs is to move beyond theoretical ETL concepts and understand a complete data pipeline:

```text
SOURCE
  ↓
EXTRACT
  ↓
RAW / STAGING
  ↓
TRANSFORM
  ↓
VALIDATE
  ↓
LOAD
  ↓
DATA WAREHOUSE
  ↓
BI / REPORTING
```

The Snowflake exercises introduce **cloud data loading and compute management**, while the ShopNow MySQL exercise provides a practical comparison of **ETL and ELT**, including data cleansing, dimensional modeling, validation, business rules, and incremental processing.

Together, the labs provide a practical foundation for understanding how modern data engineering pipelines move data from operational sources to analytics-ready data warehouses.
