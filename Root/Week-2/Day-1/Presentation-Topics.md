# Advanced Analytical SQL Topics

## Query Optimization, Execution Plans, Temporary Tables, Clustering, CTEs & Recursive CTEs

**Primary database:** SmartMart\
**Secondary example:** Hospital DB / Organizational Hierarchy\
**SQL dialect:** SQL Server / T-SQL\
**Level:** Advanced SQL / Data Engineering / Analytics

------------------------------------------------------------------------

## 1. Learning Objectives

By the end of this module, you should be able to:

-   Read and interpret a SQL Server execution plan.
-   Identify expensive scans, seeks, joins, sorts, and key lookups.
-   Understand how indexes influence query execution.
-   Use temporary tables for intermediate analytical results.
-   Understand clustered and nonclustered indexes.
-   Write ordinary CTEs for readable analytical SQL.
-   Write recursive CTEs.
-   Traverse organizational hierarchies.
-   Calculate hierarchical paths, levels, and reporting chains.
-   Compare recursive CTEs with self-joins and iterative approaches.
-   Optimize analytical queries using appropriate predicates, indexes,
    and query rewrites.

------------------------------------------------------------------------

# 2. SmartMart Database Schema

We will use a simplified SmartMart retail database.

``` text
                    +------------------+
                    |    customers     |
                    +------------------+
                    | PK customer_id   |
                    | customer_name    |
                    | city             |
                    | state            |
                    +--------+---------+
                             |
                             | 1:M
                             |
                    +--------v---------+
                    |     purchases    |
                    +------------------+
                    | PK purchase_id   |
                    | FK customer_id   |
                    | purchase_date   |
                    | total_amount     |
                    +--------+---------+
                             |
                             | M:1
                             |
                    +--------v---------+
                    |    products      |
                    +------------------+
                    | PK product_id    |
                    | product_name     |
                    | category         |
                    | unit_price       |
                    +------------------+
```

### Schema

``` sql
CREATE DATABASE SmartMart;
GO

USE SmartMart;
GO

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_purchase_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_purchase_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
```

------------------------------------------------------------------------

# 3. Sample Data

## Customers

``` sql
INSERT INTO customers
(customer_id, customer_name, city, state)
VALUES
(1, 'Arun Kumar', 'Coimbatore', 'Tamil Nadu'),
(2, 'Priya Sharma', 'Bengaluru', 'Karnataka'),
(3, 'Rahul Verma', 'Chennai', 'Tamil Nadu'),
(4, 'Sneha Iyer', 'Kochi', 'Kerala'),
(5, 'Vijay Rao', 'Hyderabad', 'Telangana'),
(6, 'Meena Krishnan', 'Madurai', 'Tamil Nadu'),
(7, 'Karthik Raj', 'Salem', 'Tamil Nadu'),
(8, 'Anitha Das', 'Bengaluru', 'Karnataka');
```

## Products

``` sql
INSERT INTO products
(product_id, product_name, category, unit_price)
VALUES
(101, 'Laptop', 'Electronics', 65000.00),
(102, 'Mobile Phone', 'Electronics', 25000.00),
(103, 'Headphones', 'Electronics', 3000.00),
(104, 'Office Chair', 'Furniture', 8500.00),
(105, 'Desk', 'Furniture', 12000.00),
(106, 'Coffee Maker', 'Home Appliances', 5500.00),
(107, 'Backpack', 'Accessories', 2500.00),
(108, 'Monitor', 'Electronics', 18000.00);
```

## Purchases

``` sql
INSERT INTO purchases
(purchase_id, customer_id, product_id, purchase_date, quantity, total_amount)
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
(1012, 3, 102, '2026-03-20', 2, 50000);
```

------------------------------------------------------------------------

# 4. Query Optimization

## What is Query Optimization?

Query optimization is the process of finding an efficient way to execute
a SQL statement.

The database engine considers alternatives such as:

``` text
SQL Query
   |
   v
Parser
   |
   v
Algebrizer / Binder
   |
   v
Optimizer
   |
   +-------------------+
   |                   |
   v                   v
Plan A               Plan B
   |                   |
   +---------+---------+
             |
             v
      Cheapest estimated
          execution plan
             |
             v
          Execution
```

The optimizer attempts to minimize factors such as:

-   CPU usage
-   Disk I/O
-   Memory usage
-   Number of rows processed
-   Sort operations
-   Join cost
-   Network traffic

------------------------------------------------------------------------

# 5. Example: An Expensive Query

``` sql
SELECT
    c.customer_name,
    SUM(p.total_amount) AS total_spent
FROM customers c
JOIN purchases p
    ON c.customer_id = p.customer_id
WHERE YEAR(p.purchase_date) = 2026
GROUP BY c.customer_name;
```

The query looks simple, but:

``` sql
YEAR(p.purchase_date)
```

applies a function to the indexed column.

This can prevent the optimizer from efficiently using an index on
`purchase_date`.

------------------------------------------------------------------------

# 6. Better Query

Instead of:

``` sql
WHERE YEAR(p.purchase_date) = 2026
```

prefer:

``` sql
WHERE p.purchase_date >= '2026-01-01'
  AND p.purchase_date <  '2027-01-01'
```

Complete query:

``` sql
SELECT
    c.customer_name,
    SUM(p.total_amount) AS total_spent
FROM customers c
JOIN purchases p
    ON c.customer_id = p.customer_id
WHERE p.purchase_date >= '2026-01-01'
  AND p.purchase_date <  '2027-01-01'
GROUP BY c.customer_name;
```

This form is generally more **SARGable**.

------------------------------------------------------------------------

# 7. What is SARGability?

SARG stands for:

> Search ARGument Able

A predicate is SARGable when the database can efficiently use an index
to locate qualifying rows.

### Less SARGable

``` sql
WHERE YEAR(purchase_date) = 2026
```

### More SARGable

``` sql
WHERE purchase_date >= '2026-01-01'
  AND purchase_date < '2027-01-01'
```

### Another example

Avoid:

``` sql
WHERE UPPER(customer_name) = 'ARUN KUMAR'
```

Potentially better:

``` sql
WHERE customer_name = 'Arun Kumar'
```

depending on database collation and requirements.

------------------------------------------------------------------------

# 8. Execution Plans

An execution plan describes **how the database intends to execute a
query**.

In SQL Server Management Studio:

``` text
Query
  |
  v
Display Estimated Execution Plan
       Ctrl + L
```

For an actual execution plan:

``` text
Query
  |
  v
Include Actual Execution Plan
       Ctrl + M
```

------------------------------------------------------------------------

# 9. Typical Execution Plan Operators

``` text
                 SELECT
                    |
                 GROUP BY
                    |
                 HASH MATCH
                 /       \
                /         \
        INDEX SEEK       INDEX SEEK
             |               |
        purchases         customers
```

Common operators include:

  Operator       Meaning
  -------------- -------------------------------------------
  Table Scan     Reads the table
  Index Scan     Reads many/all index pages
  Index Seek     Locates specific index ranges
  Key Lookup     Retrieves missing columns from base table
  Sort           Sorts rows
  Hash Match     Performs hash-based join/group
  Nested Loops   Repeatedly probes one input using another
  Merge Join     Joins sorted inputs
  Aggregate      Calculates SUM, COUNT, AVG, etc.
  Filter         Removes rows according to a predicate

------------------------------------------------------------------------

# 10. Table Scan vs Index Seek

## Table Scan

``` text
Table
+---+---+---+---+---+---+---+
| 1 | 2 | 3 | 4 | 5 | 6 | 7 |
+---+---+---+---+---+---+---+
 \_________________________/
          Read all
```

## Index Seek

``` text
Index
      10
     /  \
    5    20
   / \
  2   7

Search for 7
   |
   +----> 7
```

If only a small percentage of rows is required, an index seek can be
much more efficient.

------------------------------------------------------------------------

# 11. Creating Indexes

Create an index on the purchase date:

``` sql
CREATE INDEX IX_purchases_purchase_date
ON purchases(purchase_date);
```

Create an index for customer-based analysis:

``` sql
CREATE INDEX IX_purchases_customer_id
ON purchases(customer_id);
```

Composite index:

``` sql
CREATE INDEX IX_purchases_customer_date
ON purchases(customer_id, purchase_date);
```

------------------------------------------------------------------------

# 12. Covering Index

Suppose the query is:

``` sql
SELECT
    customer_id,
    purchase_date,
    total_amount
FROM purchases
WHERE customer_id = 1
  AND purchase_date >= '2026-01-01';
```

A covering index can include the required columns:

``` sql
CREATE INDEX IX_purchases_customer_date_covering
ON purchases(customer_id, purchase_date)
INCLUDE (total_amount);
```

Conceptually:

``` text
Index Key
-------------------------
customer_id
purchase_date
-------------------------
Included:
total_amount
```

The database may not need to access the base table for the selected
columns.

------------------------------------------------------------------------

# 13. Important Optimization Rule

Do not blindly create indexes.

Every additional index can increase:

-   INSERT cost
-   UPDATE cost
-   DELETE cost
-   Storage requirements
-   Maintenance overhead

Think:

``` text
                    Query Performance
                          ^
                          |
             +------------+------------+
             |                         |
          Indexes                  Query Design
             |                         |
       Faster Reads              Better Predicates
             |                         |
       Higher Write Cost         Less Data Processed
```

------------------------------------------------------------------------

# 14. Temporary Tables

A temporary table stores intermediate data temporarily.

SQL Server local temporary tables begin with:

``` sql
#
```

Example:

``` sql
CREATE TABLE #CustomerRevenue
(
    customer_id INT,
    total_revenue DECIMAL(14,2)
);
```

Insert data:

``` sql
INSERT INTO #CustomerRevenue
(customer_id, total_revenue)
SELECT
    customer_id,
    SUM(total_amount)
FROM purchases
GROUP BY customer_id;
```

Query it:

``` sql
SELECT *
FROM #CustomerRevenue
ORDER BY total_revenue DESC;
```

Drop it:

``` sql
DROP TABLE #CustomerRevenue;
```

------------------------------------------------------------------------

# 15. Temporary Table Workflow

``` text
Purchases
    |
    v
Aggregation
    |
    v
#CustomerRevenue
    |
    +----------+
    |          |
    v          v
Top Customers  Average Revenue
    |
    v
Final Analysis
```

------------------------------------------------------------------------

# 16. Temporary Table vs CTE

  Feature                                 Temporary Table             CTE
  --------------------------------------- --------------------------- --------------------------
  Stores intermediate result              Yes                         Logical query expression
  Can be indexed                          Yes                         No direct index
  Reusable across statements              Yes                         Generally one statement
  Recursive support                       No                          Yes
  Useful for large intermediate results   Often                       Sometimes
  Materialization                         Physical temporary object   Optimizer-dependent
  Scope                                   Session/batch               Single statement

------------------------------------------------------------------------

# 17. Example: Temporary Table for Customer Revenue

``` sql
CREATE TABLE #CustomerRevenue
(
    customer_id INT PRIMARY KEY,
    total_revenue DECIMAL(14,2)
);

INSERT INTO #CustomerRevenue
SELECT
    customer_id,
    SUM(total_amount)
FROM purchases
GROUP BY customer_id;

SELECT
    c.customer_name,
    r.total_revenue
FROM #CustomerRevenue r
JOIN customers c
    ON c.customer_id = r.customer_id
WHERE r.total_revenue > 30000
ORDER BY r.total_revenue DESC;
```

The temporary table can be indexed:

``` sql
CREATE INDEX IX_CustomerRevenue_TotalRevenue
ON #CustomerRevenue(total_revenue);
```

------------------------------------------------------------------------

# 18. Clustering and Clustered Indexes

In SQL Server, a **clustered index** determines the physical ordering of
the rows in the table.

A table can have only one clustered index.

Example:

``` sql
CREATE CLUSTERED INDEX CX_purchases_purchase_id
ON purchases(purchase_id);
```

Because `purchase_id` is already the primary key, SQL Server commonly
creates a clustered index for it by default unless another index type is
explicitly specified.

------------------------------------------------------------------------

# 19. Clustered vs Nonclustered Index

``` text
Clustered Index

Table data arranged according
to clustered index key

10 -> Row
20 -> Row
30 -> Row
40 -> Row
50 -> Row
```

Nonclustered index:

``` text
Nonclustered Index
-------------------
10 -> pointer
20 -> pointer
30 -> pointer
40 -> pointer
50 -> pointer
          |
          v
       Base Table
```

Comparison:

  Feature                       Clustered               Nonclustered
  ----------------------------- ----------------------- --------------------
  Number per table              1                       Many
  Determines row organization   Yes                     No
  Contains row data/order       Closely associated      Separate structure
  Good for range access         Yes                     Yes
  Storage                       Integrated with table   Additional storage

------------------------------------------------------------------------

# 20. CTE --- Common Table Expression

A CTE creates a temporary named result set for a single SQL statement.

Syntax:

``` sql
WITH cte_name AS
(
    SELECT ...
)
SELECT ...
FROM cte_name;
```

Example:

``` sql
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(total_amount) AS total_revenue
    FROM purchases
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    cr.total_revenue
FROM CustomerRevenue cr
JOIN customers c
    ON c.customer_id = cr.customer_id;
```

------------------------------------------------------------------------

# 21. Why Use CTEs?

CTEs improve:

-   Readability
-   Maintainability
-   Complex query decomposition
-   Multi-step transformations
-   Recursive processing
-   Analytical SQL

Instead of:

``` text
Huge Query
   |
   +-- Aggregation
   |
   +-- Filtering
   |
   +-- Ranking
   |
   +-- Joining
```

Use:

``` text
CTE 1
  |
  v
CTE 2
  |
  v
CTE 3
  |
  v
Final Query
```

------------------------------------------------------------------------

# 22. Multiple CTEs

``` sql
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(total_amount) AS revenue
    FROM purchases
    GROUP BY customer_id
),
CustomerCategory AS
(
    SELECT
        customer_id,
        CASE
            WHEN revenue >= 50000 THEN 'Premium'
            WHEN revenue >= 20000 THEN 'Gold'
            ELSE 'Standard'
        END AS customer_segment
    FROM CustomerRevenue
)
SELECT *
FROM CustomerCategory;
```

------------------------------------------------------------------------

# 23. CTE with Window Functions

Find the top customers:

``` sql
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(total_amount) AS revenue
    FROM purchases
    GROUP BY customer_id
),
RankedCustomers AS
(
    SELECT
        customer_id,
        revenue,
        RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM CustomerRevenue
)
SELECT
    c.customer_name,
    r.revenue,
    r.revenue_rank
FROM RankedCustomers r
JOIN customers c
    ON c.customer_id = r.customer_id
ORDER BY r.revenue_rank;
```

------------------------------------------------------------------------

# 24. Recursive CTE

A recursive CTE is a CTE that references itself.

It is especially useful for:

-   Organizational hierarchies
-   Employee-manager relationships
-   Product category trees
-   Folder structures
-   Bill of materials
-   Parent-child relationships
-   Geographic hierarchies

Conceptually:

``` text
Recursive CTE
     |
     +---- Anchor Query
     |
     +---- Recursive Query
                 |
                 v
             More Rows
                 |
                 v
             More Rows
                 |
                 v
              STOP
```

------------------------------------------------------------------------

# 25. Recursive CTE Structure

``` sql
WITH EmployeeHierarchy AS
(
    -- Anchor member
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive member
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        eh.hierarchy_level + 1
    FROM employees e
    JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
)
SELECT *
FROM EmployeeHierarchy;
```

------------------------------------------------------------------------

# 26. Organizational Hierarchy Example

Create an employee table:

``` sql
CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(100),
    manager_id INT NULL,

    CONSTRAINT fk_employee_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);
```

------------------------------------------------------------------------

# 27. Insert Organizational Data

``` sql
INSERT INTO employees
(employee_id, employee_name, job_title, manager_id)
VALUES
(1, 'Ramesh', 'CEO', NULL),

(2, 'Anita', 'CTO', 1),
(3, 'Suresh', 'CFO', 1),
(4, 'Meena', 'COO', 1),

(5, 'Arun', 'Engineering Manager', 2),
(6, 'Priya', 'Engineering Manager', 2),

(7, 'Karthik', 'Senior Developer', 5),
(8, 'Divya', 'Developer', 5),
(9, 'Rahul', 'Developer', 6),

(10, 'Sneha', 'Finance Manager', 3),
(11, 'Vijay', 'Accountant', 10),

(12, 'Deepa', 'Operations Manager', 4),
(13, 'Mohan', 'Operations Executive', 12);
```

------------------------------------------------------------------------

# 28. Organizational Tree

``` text
Ramesh - CEO
|
+-- Anita - CTO
|   |
|   +-- Arun - Engineering Manager
|   |   |
|   |   +-- Karthik - Senior Developer
|   |   |
|   |   +-- Divya - Developer
|   |
|   +-- Priya - Engineering Manager
|       |
|       +-- Rahul - Developer
|
+-- Suresh - CFO
|   |
|   +-- Meena - Finance Manager
|       |
|       +-- Vijay - Accountant
|
+-- Meena - COO
    |
    +-- Deepa - Operations Manager
        |
        +-- Mohan - Operations Executive
```

------------------------------------------------------------------------

# 29. Find the Complete Organization

``` sql
WITH EmployeeHierarchy AS
(
    SELECT
        employee_id,
        employee_name,
        job_title,
        manager_id,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.job_title,
        e.manager_id,
        eh.hierarchy_level + 1
    FROM employees e
    JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
)
SELECT
    employee_id,
    employee_name,
    job_title,
    manager_id,
    hierarchy_level
FROM EmployeeHierarchy
ORDER BY hierarchy_level, employee_id
OPTION (MAXRECURSION 100);
```

------------------------------------------------------------------------

# 30. Generate an Indented Organization Chart

``` sql
WITH EmployeeHierarchy AS
(
    SELECT
        employee_id,
        employee_name,
        job_title,
        manager_id,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.job_title,
        e.manager_id,
        eh.hierarchy_level + 1
    FROM employees e
    JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
)
SELECT
    REPLICATE('    ', hierarchy_level)
        + employee_name AS employee_tree,
    job_title,
    hierarchy_level
FROM EmployeeHierarchy
ORDER BY hierarchy_level, employee_id
OPTION (MAXRECURSION 100);
```

Expected conceptual output:

``` text
Ramesh
    Anita
        Arun
            Karthik
            Divya
        Priya
            Rahul
    Suresh
        Meena
            Vijay
    Meena
        Deepa
            Mohan
```

------------------------------------------------------------------------

# 31. Find All Employees Reporting to a Manager

Suppose we want everyone under Anita.

``` sql
WITH EmployeeHierarchy AS
(
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS level
    FROM employees
    WHERE employee_id = 2

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        eh.level + 1
    FROM employees e
    JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
)
SELECT *
FROM EmployeeHierarchy
WHERE level > 0
ORDER BY level
OPTION (MAXRECURSION 100);
```

Result conceptually:

``` text
Anita
 |
 +-- Arun
 |    |
 |    +-- Karthik
 |    +-- Divya
 |
 +-- Priya
      |
      +-- Rahul
```

------------------------------------------------------------------------

# 32. Build a Management Path

We can maintain a path from the root to every employee.

``` sql
WITH EmployeeHierarchy AS
(
    SELECT
        employee_id,
        employee_name,
        manager_id,
        CAST(employee_name AS VARCHAR(MAX)) AS management_path,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        CAST(
            eh.management_path
            + ' -> '
            + e.employee_name
            AS VARCHAR(MAX)
        ) AS management_path,
        eh.hierarchy_level + 1
    FROM employees e
    JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
)
SELECT
    employee_name,
    hierarchy_level,
    management_path
FROM EmployeeHierarchy
ORDER BY management_path
OPTION (MAXRECURSION 100);
```

Example:

``` text
Ramesh
Ramesh -> Anita
Ramesh -> Anita -> Arun
Ramesh -> Anita -> Arun -> Karthik
Ramesh -> Anita -> Arun -> Divya
```

------------------------------------------------------------------------

# 33. Recursive CTE in a Hospital Database

The same concept can represent:

``` text
Hospital
   |
   +-- Department
          |
          +-- Head of Department
                 |
                 +-- Doctors
                        |
                        +-- Specialists
```

Example:

``` sql
CREATE TABLE hospital_staff
(
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100),
    role_name VARCHAR(100),
    manager_id INT NULL,

    CONSTRAINT fk_hospital_staff_manager
        FOREIGN KEY (manager_id)
        REFERENCES hospital_staff(staff_id)
);
```

Sample data:

``` sql
INSERT INTO hospital_staff
(staff_id, staff_name, role_name, manager_id)
VALUES
(1, 'Dr. Kumar', 'Medical Director', NULL),
(2, 'Dr. Priya', 'Cardiology Head', 1),
(3, 'Dr. Arun', 'Cardiologist', 2),
(4, 'Dr. Meena', 'Cardiologist', 2),
(5, 'Dr. Ravi', 'Neurology Head', 1),
(6, 'Dr. Anitha', 'Neurologist', 5);
```

Recursive query:

``` sql
WITH HospitalHierarchy AS
(
    SELECT
        staff_id,
        staff_name,
        role_name,
        manager_id,
        0 AS level
    FROM hospital_staff
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        hs.staff_id,
        hs.staff_name,
        hs.role_name,
        hs.manager_id,
        hh.level + 1
    FROM hospital_staff hs
    JOIN HospitalHierarchy hh
        ON hs.manager_id = hh.staff_id
)
SELECT *
FROM HospitalHierarchy
ORDER BY level, staff_id
OPTION (MAXRECURSION 100);
```

------------------------------------------------------------------------

# 34. Recursive CTE for Product Categories

Recursive CTEs are not limited to employees.

Suppose SmartMart has categories:

``` text
Electronics
|
+-- Computers
|   |
|   +-- Laptops
|   +-- Desktops
|
+-- Mobile
    |
    +-- Smartphones
    +-- Accessories
```

Schema:

``` sql
CREATE TABLE product_categories
(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    parent_category_id INT NULL,

    CONSTRAINT fk_category_parent
        FOREIGN KEY (parent_category_id)
        REFERENCES product_categories(category_id)
);
```

Data:

``` sql
INSERT INTO product_categories
(category_id, category_name, parent_category_id)
VALUES
(1, 'Electronics', NULL),
(2, 'Computers', 1),
(3, 'Laptops', 2),
(4, 'Desktops', 2),
(5, 'Mobile', 1),
(6, 'Smartphones', 5),
(7, 'Accessories', 5);
```

Recursive query:

``` sql
WITH CategoryHierarchy AS
(
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level
    FROM product_categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        pc.category_id,
        pc.category_name,
        pc.parent_category_id,
        ch.level + 1
    FROM product_categories pc
    JOIN CategoryHierarchy ch
        ON pc.parent_category_id = ch.category_id
)
SELECT
    REPLICATE('  ', level) + category_name AS category_tree,
    level
FROM CategoryHierarchy
ORDER BY level, category_id
OPTION (MAXRECURSION 100);
```

------------------------------------------------------------------------

# 35. Recursive CTE Execution Model

Consider:

``` text
Anchor
  |
  v
Level 0
  |
  v
Find children
  |
  v
Level 1
  |
  v
Find children
  |
  v
Level 2
  |
  v
Find children
  |
  v
No more children
  |
  v
STOP
```

This is conceptually different from an ordinary CTE.

### Ordinary CTE

``` text
Base Tables
    |
    v
CTE
    |
    v
Final Query
```

### Recursive CTE

``` text
Anchor
   |
   v
Recursive Member
   |
   +----> Recursive Member
               |
               +----> Recursive Member
                           |
                           v
                         STOP
```

------------------------------------------------------------------------

# 36. MAXRECURSION

SQL Server protects against infinite recursion.

Example:

``` sql
OPTION (MAXRECURSION 100);
```

This permits up to 100 recursion levels.

For unlimited recursion:

``` sql
OPTION (MAXRECURSION 0);
```

Use unlimited recursion carefully.

A circular hierarchy such as:

``` text
A -> B
B -> C
C -> A
```

can cause recursion problems.

------------------------------------------------------------------------

# 37. Detecting Hierarchical Problems

A production organizational table should avoid:

``` text
Employee A
   |
   v
Employee B
   |
   v
Employee C
   |
   +------> Employee A
```

This creates a cycle.

For production systems, validate:

-   An employee cannot be their own manager.
-   A manager relationship cannot form a cycle.
-   Root employees should have `NULL` manager IDs.
-   Deleted managers should be handled appropriately.
-   Hierarchy depth should be reasonable.

------------------------------------------------------------------------

# 38. Recursive CTE vs Self Join

For a fixed number of levels:

``` sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;
```

This is simple for one level.

For multiple unknown levels:

``` text
CEO
 |
 +-- VP
      |
      +-- Manager
            |
            +-- Lead
                  |
                  +-- Developer
```

a recursive CTE is usually much more suitable.

------------------------------------------------------------------------

# 39. Query Optimization Checklist

Before optimizing:

``` text
1. Understand the business requirement
2. Check returned row count
3. Check execution plan
4. Identify expensive operators
5. Check indexes
6. Check statistics
7. Check joins
8. Check predicates
9. Check unnecessary columns
10. Re-test performance
```

------------------------------------------------------------------------

# 40. Practical Optimization Example

### Initial query

``` sql
SELECT *
FROM purchases
WHERE YEAR(purchase_date) = 2026;
```

Problems:

-   Uses `SELECT *`
-   Function on indexed column
-   May scan more data than required

### Improved query

``` sql
SELECT
    purchase_id,
    customer_id,
    product_id,
    purchase_date,
    total_amount
FROM purchases
WHERE purchase_date >= '2026-01-01'
  AND purchase_date < '2027-01-01';
```

Potential supporting index:

``` sql
CREATE INDEX IX_purchases_date
ON purchases(purchase_date)
INCLUDE
(
    purchase_id,
    customer_id,
    product_id,
    total_amount
);
```

------------------------------------------------------------------------

# 41. Execution Plan Investigation Workflow

``` text
              SQL Query
                  |
                  v
          Actual Execution Plan
                  |
        +---------+---------+
        |         |         |
        v         v         v
      Scan      Sort      Join
        |         |         |
        +---------+---------+
                  |
                  v
           Identify Cost
                  |
                  v
          Rewrite / Index
                  |
                  v
             Re-test
                  |
                  v
          Compare Metrics
```

Useful metrics include:

-   Logical reads
-   CPU time
-   Elapsed time
-   Rows returned
-   Rows estimated
-   Rows actually processed
-   Memory grant
-   Spill warnings

------------------------------------------------------------------------

# 42. Estimated vs Actual Rows

One of the most important execution-plan concepts is the difference
between:

``` text
Estimated Rows
      vs
Actual Rows
```

Example:

``` text
Estimated Rows: 100
Actual Rows:   100,000
```

A huge mismatch can cause the optimizer to choose a poor plan.

Potential causes include:

-   Outdated statistics
-   Data distribution changes
-   Correlated columns
-   Parameter sensitivity
-   Poor cardinality estimates

------------------------------------------------------------------------

# 43. Statistics

SQL Server uses statistics to estimate how many rows satisfy a
predicate.

Conceptually:

``` text
Column Distribution

Value
 ^
 |       ****
 |      ******
 | **  *******
 |************
 +----------------->

Statistics help the optimizer
understand this distribution.
```

Update statistics when appropriate:

``` sql
UPDATE STATISTICS purchases;
```

For a specific index/statistic:

``` sql
UPDATE STATISTICS purchases IX_purchases_date;
```

------------------------------------------------------------------------

# 44. Common Query Optimization Mistakes

### Mistake 1

``` sql
SELECT *
```

Better:

``` sql
SELECT customer_id, total_amount
```

### Mistake 2

``` sql
WHERE YEAR(purchase_date) = 2026
```

Better:

``` sql
WHERE purchase_date >= '2026-01-01'
AND purchase_date < '2027-01-01'
```

### Mistake 3

Creating too many indexes.

### Mistake 4

Ignoring execution plans.

### Mistake 5

Joining large tables before filtering.

### Mistake 6

Using `DISTINCT` to hide an incorrect join.

### Mistake 7

Using a recursive query without thinking about cycles.

------------------------------------------------------------------------

# 45. Advanced Challenge --- Customer Revenue Ranking

Write a query that:

1.  Calculates customer revenue.
2.  Assigns a rank.
3.  Calculates percentage contribution.
4.  Returns customers contributing more than 5% of revenue.

``` sql
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(total_amount) AS revenue
    FROM purchases
    GROUP BY customer_id
),
RevenueAnalysis AS
(
    SELECT
        customer_id,
        revenue,
        RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank,
        SUM(revenue) OVER () AS total_market_revenue
    FROM CustomerRevenue
)
SELECT
    c.customer_name,
    ra.revenue,
    ra.revenue_rank,
    CAST(
        100.0 * ra.revenue / ra.total_market_revenue
        AS DECIMAL(10,2)
    ) AS revenue_percentage
FROM RevenueAnalysis ra
JOIN customers c
    ON c.customer_id = ra.customer_id
WHERE
    100.0 * ra.revenue / ra.total_market_revenue > 5
ORDER BY revenue_rank;
```

------------------------------------------------------------------------

# 46. Advanced Challenge --- Top Product by Category

``` sql
WITH ProductRevenue AS
(
    SELECT
        p.category,
        p.product_id,
        p.product_name,
        SUM(pr.total_amount) AS revenue
    FROM products p
    JOIN purchases pr
        ON p.product_id = pr.product_id
    GROUP BY
        p.category,
        p.product_id,
        p.product_name
),
RankedProducts AS
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS rn
    FROM ProductRevenue
)
SELECT
    category,
    product_name,
    revenue
FROM RankedProducts
WHERE rn = 1
ORDER BY category;
```

------------------------------------------------------------------------

# 47. Advanced Challenge --- Organizational Depth

Find employees at level 3 or deeper.

``` sql
WITH EmployeeHierarchy AS
(
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        eh.hierarchy_level + 1
    FROM employees e
    JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
)
SELECT
    employee_id,
    employee_name,
    hierarchy_level
FROM EmployeeHierarchy
WHERE hierarchy_level >= 3
ORDER BY hierarchy_level
OPTION (MAXRECURSION 100);
```

------------------------------------------------------------------------

# 48. Interview Questions

## Q1. What is a query execution plan?

An execution plan describes the operations the database engine uses to
execute a SQL query.

## Q2. What is the difference between Index Scan and Index Seek?

An index seek navigates to a relevant portion of an index, while an
index scan reads a larger portion or the entire index.

## Q3. What is SARGability?

SARGability means writing predicates in a form that allows efficient
index-based searching.

## Q4. How many clustered indexes can a table have?

One.

## Q5. Can a table have multiple nonclustered indexes?

Yes.

## Q6. What is a CTE?

A Common Table Expression is a named query expression used by a single
SQL statement.

## Q7. What is a recursive CTE?

A CTE whose recursive member references the CTE itself.

## Q8. What are the two major parts of a recursive CTE?

The anchor member and recursive member.

## Q9. Where are recursive CTEs useful?

Hierarchies, trees, category structures, organizational reporting
chains, and bill-of-materials structures.

## Q10. What does MAXRECURSION do?

It limits the recursion depth of a recursive CTE in SQL Server.

------------------------------------------------------------------------

# 49. Hands-On Lab

## Lab 1 --- Execution Plans

Create:

``` sql
CREATE INDEX IX_purchases_date
ON purchases(purchase_date);
```

Compare:

``` sql
SELECT *
FROM purchases
WHERE YEAR(purchase_date) = 2026;
```

with:

``` sql
SELECT *
FROM purchases
WHERE purchase_date >= '2026-01-01'
AND purchase_date < '2027-01-01';
```

Inspect the execution plan.

------------------------------------------------------------------------

## Lab 2 --- Temporary Table

Create:

``` sql
#CustomerRevenue
```

Populate it with customer revenue.

Then:

-   Add an index.
-   Find top 3 customers.
-   Calculate average revenue.
-   Delete the temporary table.

------------------------------------------------------------------------

## Lab 3 --- CTE

Create a CTE that calculates:

``` text
Customer
Revenue
Rank
Segment
```

Segments:

``` text
Revenue >= 50000 -> Platinum
Revenue >= 25000 -> Gold
Revenue >= 10000 -> Silver
Otherwise        -> Bronze
```

------------------------------------------------------------------------

## Lab 4 --- Recursive Organization

Using `employees`:

1.  Find the CEO.
2.  Find direct reports.
3.  Find all descendants.
4.  Calculate hierarchy depth.
5.  Generate management paths.
6.  Create an indented hierarchy.
7.  Find employees reporting under Anita.
8.  Experiment with `MAXRECURSION`.

------------------------------------------------------------------------

# 50. Mental Model

Remember these four concepts as:

``` text
QUERY OPTIMIZATION
       |
       +--> How can I execute this faster?
       |
       +--> Execution Plan
       |
       +--> Indexes
       |
       +--> SARGability
       |
       +--> Statistics


TEMPORARY TABLE
       |
       +--> Store intermediate results
       +--> Reuse within session/batch
       +--> Can be indexed


CTE
       |
       +--> Make complex SQL readable
       +--> Transform data in stages
       +--> Useful with window functions


RECURSIVE CTE
       |
       +--> Parent -> Child
       +--> Child -> Grandchild
       +--> Hierarchies
       +--> Trees
       +--> Organizational structures
```

------------------------------------------------------------------------

# 51. Final Takeaway

The progression to advanced SQL can be visualized as:

``` text
Basic SQL
   |
   +--> SELECT / WHERE / GROUP BY
   |
   v
Joins
   |
   v
Subqueries
   |
   v
Window Functions
   |
   v
CTEs
   |
   v
Recursive CTEs
   |
   v
Execution Plans
   |
   v
Indexes
   |
   v
Query Optimization
   |
   v
Production-Grade Analytical SQL
```

The most important practical lesson is:

> **Do not optimize SQL by guessing. Read the execution plan, understand
> the data access pattern, change one thing at a time, and measure the
> result.**

For recursive queries, remember:

> **Anchor → Recursive Member → Next Level → Repeat → Stop**

For performance tuning, remember:

> **Filter early → Read less data → Use appropriate indexes → Inspect
> the plan → Measure again.**
