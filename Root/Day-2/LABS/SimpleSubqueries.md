# SQL Subquery Practice — Complete Solutions

## Objective

Use subqueries for data analysis in MySQL.

---

## 1. Create the Tables

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);
