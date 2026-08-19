# SQL Practice Problems – Set 1

## Problem 1: Movies Released After the Year 2000

### Table Schema

```sql
CREATE DATABASE movie_streaming;

USE movie_streaming;

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT,
    genre_id INT
);
```

### Insert Queries

```sql
INSERT INTO Movies VALUES
(901, 'The Great Escape', 1963, 2),
(902, 'Life of Pi', 2012, 4),
(903, 'The Office (Series)', 2005, 3),
(904, 'Hamlet', 1996, 1);
```

### Solution

```sql
SELECT
    movie_id,
    title,
    release_year
FROM Movies
WHERE release_year > 2000
ORDER BY release_year;
```

### Expected Output

| movie_id | title               | release_year |
| -------: | ------------------- | -----------: |
|      903 | The Office (Series) |         2005 |
|      902 | Life of Pi          |         2012 |

---

# Problem 2: Products With Total Quantity Sold and Customer Names

## Table Schema

### Customers

```sql
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);
```

### Products

```sql
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);
```

### Orders

```sql
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);
```

### Order_Items

```sql
CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY(order_id)
        REFERENCES Orders(order_id),
    FOREIGN KEY(product_id)
        REFERENCES Products(product_id)
);
```

## Insert Queries

### Customers

```sql
INSERT INTO Customers VALUES
(201,'John Doe','john@example.com','1234567890'),
(202,'Jane Smith','jane@example.com','2345678901'),
(203,'Emily Davis','emily@example.com','3456789012'),
(204,'Mark Wilson','mark@example.com','4567890123');
```

### Products

```sql
INSERT INTO Products VALUES
(301,'Laptop','Electronics',1000.00),
(302,'Smartphone','Electronics',600.00),
(303,'Office Chair','Furniture',150.00),
(304,'Notebook Set','Stationery',10.00);
```

### Orders

```sql
INSERT INTO Orders VALUES
(401,201,'2023-08-01',1010.00),
(402,202,'2023-08-03',1600.00),
(403,203,'2023-08-04',20.00),
(404,204,'2023-08-05',750.00);
```

### Order_Items

```sql
INSERT INTO Order_Items VALUES
(401,301,1,1000.00),
(401,304,1,10.00),
(402,301,1,1000.00),
(402,302,1,600.00),
(403,304,2,10.00),
(404,303,5,150.00),
(404,304,1,10.00),
(402,303,1,150.00),
(403,302,1,600.00),
(401,303,2,150.00),
(403,301,1,1000.00),
(404,302,1,600.00);
```

## Solution

```sql
SELECT
    p.name AS product_name,
    tq.total_quantity_sold,
    c.name AS customer_name
FROM Products p
JOIN (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity_sold
    FROM Order_Items
    GROUP BY product_id
) tq
    ON p.product_id = tq.product_id
JOIN Order_Items oi
    ON p.product_id = oi.product_id
JOIN Orders o
    ON oi.order_id = o.order_id
JOIN Customers c
    ON o.customer_id = c.customer_id
GROUP BY
    p.name,
    tq.total_quantity_sold,
    c.name
ORDER BY
    p.name,
    c.name;
```

---

# Problem 3: Hospital Management

## Table Schema

### Doctors

```sql
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    department_id INT
);
```

### Appointments

```sql
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id)
);
```

## Insert Queries

The PDF only shows partial data. The following inserts reproduce the expected output.

### Doctors

```sql
INSERT INTO Doctors VALUES
(501,'Dr. Mehta','Cardiologist',1),
(502,'Dr. Rao','Neurologist',2),
(504,'Dr. Nair','Orthopedic Surgeon',4);
```

### Appointments

```sql
INSERT INTO Appointments VALUES
(704,101,504,'2023-08-05','Scheduled'),
(708,102,501,'2023-08-09','Scheduled'),
(712,103,502,'2023-08-13','Completed');
```

## Solution

```sql
SELECT
    a.appointment_id,
    a.appointment_date,
    d.name AS doctor_name,
    d.specialization
FROM Appointments a
JOIN Doctors d
    ON a.doctor_id = d.doctor_id
WHERE a.status = 'Scheduled';
```

## Expected Output

| appointment_id | appointment_date | doctor_name | specialization     |
| -------------: | ---------------- | ----------- | ------------------ |
|            704 | 2023-08-05       | Dr. Nair    | Orthopedic Surgeon |
|            708 | 2023-08-09       | Dr. Mehta   | Cardiologist       |

---

# Problem 4: Revenue Change Using `LAG()`

## Table Schema

```sql
CREATE DATABASE SALES_SUMMARY_DB;

USE SALES_SUMMARY_DB;

CREATE TABLE MonthlySales (
    month_start DATE PRIMARY KEY,
    total_revenue DECIMAL(12,2)
);
```

## Insert Queries

The PDF only shows expected output values. The following inserts reproduce it.

```sql
INSERT INTO MonthlySales VALUES
('2025-09-01',87000.00),
('2025-10-01',90000.00),
('2025-11-01',95000.00);
```

## Solution

```sql
SELECT
    month_start,
    total_revenue,
    LAG(total_revenue)
        OVER(ORDER BY month_start) AS prev_month_revenue,
    total_revenue -
    LAG(total_revenue)
        OVER(ORDER BY month_start) AS revenue_change
FROM MonthlySales
ORDER BY month_start DESC;
```

## Alternative: Ascending Order

```sql
SELECT
    month_start,
    total_revenue,
    LAG(total_revenue)
        OVER(ORDER BY month_start) AS prev_month_revenue,
    total_revenue -
    LAG(total_revenue)
        OVER(ORDER BY month_start) AS revenue_change
FROM MonthlySales
ORDER BY month_start;
```

## Understanding the `LAG()` Query

```sql
LAG(total_revenue)
OVER(ORDER BY month_start)
```

This retrieves the **previous month's revenue**.

For example:

| month_start | total_revenue | prev_month_revenue | revenue_change |
| ----------- | ------------: | -----------------: | -------------: |
| 2025-09-01  |         87000 |               NULL |           NULL |
| 2025-10-01  |         90000 |              87000 |           3000 |
| 2025-11-01  |         95000 |              90000 |           5000 |

The first month has no previous month, so `LAG()` returns `NULL`.

---

# Concepts Covered

1. **Filtering with `WHERE`**
2. **Sorting with `ORDER BY`**
3. **INNER JOIN**
4. **Aggregate Functions – `SUM()`**
5. **`GROUP BY`**
6. **Subqueries / Derived Tables**
7. **Foreign Key Relationships**
8. **Window Functions – `LAG()`**
9. **Business Reporting Queries**
10. **Multi-table Joins**

---

# Quick Concept Mapping

| Problem   | Main Concepts                              |
| --------- | ------------------------------------------ |
| Problem 1 | `WHERE`, `ORDER BY`                        |
| Problem 2 | `JOIN`, `SUM()`, `GROUP BY`, Derived Table |
| Problem 3 | `INNER JOIN`, `WHERE`, Foreign Key         |
| Problem 4 | `LAG()`, Window Function, `ORDER BY`       |

These problems progressively cover **filtering → joins → aggregation → derived tables → window functions**, making them useful for SQL practice and mock interviews.
