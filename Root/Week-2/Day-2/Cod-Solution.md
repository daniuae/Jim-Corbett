# Assignment: Build a Star Schema in MySQL

**Total Marks: 10**

## Goal

Design and implement a simple **Star Schema in MySQL** for Sales and Customer Analytics.

You will:

* Create dimension and fact tables
* Insert sample data
* Run basic analytical queries
* Design a Star Schema ERD

---

# Scenario

Your organization wants to analyze sales performance across:

* Customers
* Products
* Time

You need to build a **Sales Data Mart using a Star Schema**.

---

# Task 1: Design the Star Schema

Create a simple ERD, either on paper or digitally, using the following tables.

## 1. `dim_customer`

| Column          | Description      |
| --------------- | ---------------- |
| `customer_key`  | Primary Key      |
| `customer_name` | Customer name    |
| `region`        | Customer region  |
| `segment`       | Customer segment |

## 2. `dim_product`

| Column         | Description          |
| -------------- | -------------------- |
| `product_key`  | Primary Key          |
| `product_name` | Product name         |
| `category`     | Product category     |
| `sub_category` | Product sub-category |

## 3. `dim_date`

| Column      | Description                    |
| ----------- | ------------------------------ |
| `date_key`  | Primary Key, format `YYYYMMDD` |
| `full_date` | Actual calendar date           |
| `day`       | Day number                     |
| `month`     | Month number                   |
| `quarter`   | Quarter number                 |
| `year`      | Year                           |

## 4. `fact_sales`

| Column          | Description   |
| --------------- | ------------- |
| `sales_key`     | Primary Key   |
| `date_key`      | Foreign Key   |
| `customer_key`  | Foreign Key   |
| `product_key`   | Foreign Key   |
| `quantity_sold` | Quantity sold |
| `sales_amount`  | Sales amount  |

### Star Schema Relationship

The `fact_sales` table must be connected to all three dimension tables:

```text
                    dim_customer
                         |
                         |
                         | customer_key
                         |
                         v
                   +-------------+
                   | fact_sales  |
                   +-------------+
                         ^
                         |
                         | product_key
                         |
                    dim_product

                         ^
                         |
                         | date_key
                         |
                      dim_date
```

The complete Star Schema should have:

```text
                 +------------------+
                 |   dim_customer   |
                 +------------------+
                 | PK customer_key  |
                 | customer_name    |
                 | region           |
                 | segment          |
                 +------------------+
                          |
                          |
                          v
+------------------+   +------------------+   +------------------+
|    dim_date      |-->|    fact_sales    |<--|   dim_product    |
+------------------+   +------------------+   +------------------+
| PK date_key      |   | PK sales_key     |   | PK product_key   |
| full_date        |   | FK date_key      |   | product_name     |
| day              |   | FK customer_key  |   | category         |
| month            |   | FK product_key   |   | sub_category     |
| quarter          |   | quantity_sold    |   +------------------+
| year             |   | sales_amount     |
+------------------+   +------------------+
```

### Important

Make sure the **fact table is connected correctly to all three dimension tables**.

The relationship is:

```text
dim_customer.customer_key
        |
        | 1 : Many
        v
fact_sales.customer_key


dim_product.product_key
        |
        | 1 : Many
        v
fact_sales.product_key


dim_date.date_key
        |
        | 1 : Many
        v
fact_sales.date_key
```

---

# Task 2: Create the Tables in MySQL

Create the four tables using the following SQL.

## Step 1: Create `dim_customer`

```sql
CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    segment VARCHAR(50)
);
```

## Step 2: Create `dim_product`

```sql
CREATE TABLE dim_product (
    product_key INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);
```

## Step 3: Create `dim_date`

```sql
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    quarter INT,
    year INT
);
```

## Step 4: Create `fact_sales`

```sql
CREATE TABLE fact_sales (
    sales_key INT PRIMARY KEY,
    date_key INT,
    customer_key INT,
    product_key INT,
    quantity_sold INT,
    sales_amount DECIMAL(10,2),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key)
);
```

### Key Point

The three foreign keys in `fact_sales` establish the Star Schema relationships:

```text
fact_sales.date_key
       ↓
dim_date.date_key

fact_sales.customer_key
       ↓
dim_customer.customer_key

fact_sales.product_key
       ↓
dim_product.product_key
```

---

# Task 3: Insert Sample Data

## 3.1 Insert Data into `dim_customer`

```sql
INSERT INTO dim_customer
VALUES
(1, 'Alice Corp', 'North', 'Enterprise'),
(2, 'Beta LLC', 'South', 'SMB');
```

Verify:

```sql
SELECT * FROM dim_customer;
```

Expected data:

| customer_key | customer_name | region | segment    |
| -----------: | ------------- | ------ | ---------- |
|            1 | Alice Corp    | North  | Enterprise |
|            2 | Beta LLC      | South  | SMB        |

---

## 3.2 Insert Data into `dim_product`

```sql
INSERT INTO dim_product
VALUES
(1, 'Laptop Pro', 'Electronics', 'Computers'),
(2, 'Office Chair', 'Furniture', 'Chairs');
```

Verify:

```sql
SELECT * FROM dim_product;
```

Expected data:

| product_key | product_name | category    | sub_category |
| ----------: | ------------ | ----------- | ------------ |
|           1 | Laptop Pro   | Electronics | Computers    |
|           2 | Office Chair | Furniture   | Chairs       |

---

## 3.3 Insert Data into `dim_date`

```sql
INSERT INTO dim_date
VALUES
(20250101, '2025-01-01', 1, 1, 1, 2025),
(20250102, '2025-01-02', 2, 1, 1, 2025);
```

Verify:

```sql
SELECT * FROM dim_date;
```

Expected data:

| date_key | full_date  | day | month | quarter | year |
| -------: | ---------- | --: | ----: | ------: | ---: |
| 20250101 | 2025-01-01 |   1 |     1 |       1 | 2025 |
| 20250102 | 2025-01-02 |   2 |     1 |       1 | 2025 |

---

## 3.4 Insert Data into `fact_sales`

```sql
INSERT INTO fact_sales
VALUES
(1, 20250101, 1, 1, 10, 15000.00),
(2, 20250102, 2, 2, 5, 1000.00);
```

Verify:

```sql
SELECT * FROM fact_sales;
```

Expected data:

| sales_key | date_key | customer_key | product_key | quantity_sold | sales_amount |
| --------: | -------: | -----------: | ----------: | ------------: | -----------: |
|         1 | 20250101 |            1 |           1 |            10 |     15000.00 |
|         2 | 20250102 |            2 |           2 |             5 |      1000.00 |

---

# Task 4: Run Analytical Queries

## A. Total Sales Amount

### Business Question

> What is the total sales amount?

```sql
SELECT
    SUM(sales_amount) AS total_sales
FROM fact_sales;
```

### Expected Result

| total_sales |
| ----------: |
|    16000.00 |

---

# B. Sales by Customer

### Business Question

> How much did each customer purchase?

```sql
SELECT
    c.customer_name,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_name;
```

### Expected Result

| customer_name | total_sales |
| ------------- | ----------: |
| Alice Corp    |    15000.00 |
| Beta LLC      |     1000.00 |

---

# C. Sales by Product Category

### Business Question

> How much sales revenue was generated by each product category?

```sql
SELECT
    p.category,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category;
```

### Expected Result

| category    | total_sales |
| ----------- | ----------: |
| Electronics |    15000.00 |
| Furniture   |     1000.00 |

---

# D. Daily Sales Trend

### Business Question

> How much sales revenue was generated each day?

```sql
SELECT
    d.full_date,
    SUM(f.sales_amount) AS daily_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;
```

### Expected Result

| full_date  | daily_sales |
| ---------- | ----------: |
| 2025-01-01 |    15000.00 |
| 2025-01-02 |     1000.00 |

---

# Complete SQL Script

The following script contains the complete solution in one place.

```sql
/* =========================================================
   STAR SCHEMA - SALES DATA MART
   ========================================================= */


/* =========================================================
   1. CREATE DIMENSION TABLES
   ========================================================= */

CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    segment VARCHAR(50)
);


CREATE TABLE dim_product (
    product_key INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);


CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    quarter INT,
    year INT
);


/* =========================================================
   2. CREATE FACT TABLE
   ========================================================= */

CREATE TABLE fact_sales (
    sales_key INT PRIMARY KEY,
    date_key INT,
    customer_key INT,
    product_key INT,
    quantity_sold INT,
    sales_amount DECIMAL(10,2),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key)
);


/* =========================================================
   3. INSERT CUSTOMER DATA
   ========================================================= */

INSERT INTO dim_customer
VALUES
(1, 'Alice Corp', 'North', 'Enterprise'),
(2, 'Beta LLC', 'South', 'SMB');


/* =========================================================
   4. INSERT PRODUCT DATA
   ========================================================= */

INSERT INTO dim_product
VALUES
(1, 'Laptop Pro', 'Electronics', 'Computers'),
(2, 'Office Chair', 'Furniture', 'Chairs');


/* =========================================================
   5. INSERT DATE DATA
   ========================================================= */

INSERT INTO dim_date
VALUES
(20250101, '2025-01-01', 1, 1, 1, 2025),
(20250102, '2025-01-02', 2, 1, 1, 2025);


/* =========================================================
   6. INSERT SALES DATA
   ========================================================= */

INSERT INTO fact_sales
VALUES
(1, 20250101, 1, 1, 10, 15000.00),
(2, 20250102, 2, 2, 5, 1000.00);


/* =========================================================
   7. VERIFY TABLE DATA
   ========================================================= */

SELECT * FROM dim_customer;

SELECT * FROM dim_product;

SELECT * FROM dim_date;

SELECT * FROM fact_sales;


/* =========================================================
   8. ANALYTICAL QUERY A
      TOTAL SALES
   ========================================================= */

SELECT
    SUM(sales_amount) AS total_sales
FROM fact_sales;


/* =========================================================
   9. ANALYTICAL QUERY B
      SALES BY CUSTOMER
   ========================================================= */

SELECT
    c.customer_name,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_name;


/* =========================================================
   10. ANALYTICAL QUERY C
       SALES BY PRODUCT CATEGORY
   ========================================================= */

SELECT
    p.category,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category;


/* =========================================================
   11. ANALYTICAL QUERY D
       DAILY SALES TREND
   ========================================================= */

SELECT
    d.full_date,
    SUM(f.sales_amount) AS daily_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;
```

---

# Submission Requirements

Submit **exactly 4 clear screenshots**.

## Screenshot 1 — Star Schema ERD

The screenshot must clearly show:

* `fact_sales`
* `dim_customer`
* `dim_product`
* `dim_date`
* Primary keys
* Foreign keys
* Relationships between the fact and dimension tables

---

## Screenshot 2 — Created Tables

Show that all four tables were successfully created:

```text
dim_customer
dim_product
dim_date
fact_sales
```

The screenshot should make the table structures and keys visible.

---

## Screenshot 3 — Inserted Data

Show the sample data available in:

```text
dim_customer
dim_product
dim_date
fact_sales
```

---

## Screenshot 4 — Query Results

Show the results of **all four analytical queries**:

1. Total Sales Amount
2. Sales by Customer
3. Sales by Product Category
4. Daily Sales Trend

---

# Evaluation Rubric

| Evaluation Area                 |  Marks |
| ------------------------------- | -----: |
| Star Schema Design              |      2 |
| Table Creation                  |      2 |
| Sample Data                     |      2 |
| Analytical Queries              |      3 |
| SQL Script and Final Submission |      1 |
| **Total**                       | **10** |

## 1. Star Schema Design — 2 Marks

The ERD correctly shows:

* `fact_sales`
* Three dimension tables
* Correct relationships
* Primary and foreign keys

## 2. Table Creation — 2 Marks

All four tables are created correctly with:

* Required columns
* Primary keys
* Foreign keys

## 3. Sample Data — 2 Marks

The provided sample data is inserted correctly into all four tables.

## 4. Analytical Queries — 3 Marks

All four required queries execute correctly and produce the expected results.

## 5. SQL Script and Final Submission — 1 Mark

The SQL script contains:

* Table creation
* Data insertion
* Analytical queries

---

# Final Verification Checklist

Before submitting, verify the following:

* [ ] ERD shows all four tables
* [ ] `fact_sales` connects to `dim_customer`
* [ ] `fact_sales` connects to `dim_product`
* [ ] `fact_sales` connects to `dim_date`
* [ ] All primary keys are defined
* [ ] All three foreign keys are defined
* [ ] Customer data is inserted
* [ ] Product data is inserted
* [ ] Date data is inserted
* [ ] Sales data is inserted
* [ ] Total sales query works
* [ ] Sales-by-customer query works
* [ ] Sales-by-category query works
* [ ] Daily-sales query works
* [ ] Exactly 4 screenshots are submitted
* [ ] Complete SQL script is submitted

## Expected Overall Result

```text
                    STAR SCHEMA
                         |
        +----------------+----------------+
        |                |                |
        v                v                v
   DIM_CUSTOMER     DIM_PRODUCT       DIM_DATE
        \                |                /
         \               |               /
          \              |              /
           +-------------+-------------+
                         |
                         v
                    FACT_SALES
                         |
                         v
                  SALES ANALYTICS
```

**Expected total sales: `16,000.00`**

The Star Schema enables sales analysis across **customer, product, and time dimensions** using the central `fact_sales` table.
