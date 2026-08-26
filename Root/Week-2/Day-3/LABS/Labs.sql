
LABS - 1
Implementing Slowly Changing Dimensions (SCD)

Objective
Understand how historical changes are tracked in dimension data (SCD Type 1, 2, and 3).

Scenario
A customer moves from Delhi → Mumbai and we must reflect it in our dimensional table depending on SCD strategy.

Step-by-Step

Step 1: Create Customer Dimension for SCD Testing
CREATE TABLE DimCustomer_SCD (
  CustomerKey INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  CustomerName VARCHAR(100),
  City VARCHAR(50),
  StartDate DATE,
  EndDate DATE,
  CurrentFlag CHAR(1)
);

Step 2: Insert Initial Record
INSERT INTO DimCustomer_SCD
(CustomerID, CustomerName, City, StartDate, EndDate, CurrentFlag)
VALUES (101,'John','Delhi','2022-01-01',NULL,'Y');
Explanation:
Represents the current active record for the customer.

Step 3: Apply SCD Type 1 (Overwrite Change)
UPDATE DimCustomer_SCD
SET City='Mumbai'
WHERE CustomerID=101;
Result:
City is updated — no historical record retained.

Use for non-critical fields.

Step 4: Apply SCD Type 2 (New Row with History)
UPDATE DimCustomer_SCD
SET EndDate='2023-03-01', CurrentFlag='N'
WHERE CustomerID=101 AND CurrentFlag='Y';

INSERT INTO DimCustomer_SCD
(CustomerID, CustomerName, City, StartDate, EndDate, CurrentFlag)
VALUES (101,'John','Mumbai','2023-03-02',NULL,'Y');
Explanation:
Keeps both old and new records — allowing time-based analysis.

Step 5: Apply SCD Type 3 (Track Previous Value)
ALTER TABLE DimCustomer_SCD ADD COLUMN PrevCity VARCHAR(50);

UPDATE DimCustomer_SCD
SET PrevCity='Delhi', City='Bangalore'
WHERE CustomerID=101 AND CurrentFlag='Y';
Explanation:
Only tracks the last change. Partial history only.

Step 6: Validate Historical Changes
SELECT * FROM DimCustomer_SCD ORDER BY CustomerKey;

——————————————————————————————————————————————————————————————————————
LAB-2
FindBorderBarSize
DescriptionVirtual Machine
Course: Data Modeling Foundations

Task 1 – Understanding Core Data Modeling Concepts

 Objective

Build a basic understanding of entities, relationships, normalization, and dimensional design by modeling a small retail business scenario.

Scenario

A startup named ShopEasy sells products online. They want to design a database to store customers, orders, and products efficiently before migrating it into a data warehouse.

 Step-by-Step

Step 1: Create the Database

CREATE DATABASE IF NOT EXISTS ShopEasy_DB;
USE ShopEasy_DB;

Explanation:
This sets up a workspace to hold all schema objects. Always start with a dedicated schema to isolate logical environments.

Step 2: Create Entity Tables (Normalized OLTP Model)

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Email VARCHAR(100),
  City VARCHAR(50)
);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY AUTO_INCREMENT,
  ProductName VARCHAR(100),
  Category VARCHAR(50),
  UnitPrice DECIMAL(10,2)
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  OrderDate DATE,
  CustomerID INT,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
  OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT,
  ProductID INT,
  Quantity INT,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

Explanation:
* Each entity has its own table (normalized design).
* Avoids duplication and ensures referential integrity.
* This model is ideal for OLTP operations.

Step 3: Insert Sample Data

INSERT INTO Customers (FirstName, LastName, Email, City) VALUES
('Amit','Sharma','amit@shop.com','Delhi'),
('Neha','Verma','neha@shop.com','Mumbai');

INSERT INTO Products (ProductName, Category, UnitPrice) VALUES
('Laptop','Electronics',65000),
('Mouse','Electronics',800),
('Shoes','Fashion',2500);

INSERT INTO Orders (OrderDate, CustomerID) VALUES
('2025-10-01',1),
('2025-10-02',2);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1,1,1),(1,2,2),(2,3,1);
Explanation:
Populates each entity with basic data to demonstrate relationships across the schema.

Step 4: Verify Data Integrity

SELECT o.OrderID, c.FirstName, p.ProductName, od.Quantity, p.UnitPrice
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

Expected Output:

Joined data showing customers, their orders, and items — proving relational integrity.

Step 5: Discuss Normalization

* Tables follow 3NF (no transitive dependencies).
* Each field depends solely on the primary key.
* Example:
* OrderDetails connects Orders → Products without redundancy.
* Advantage: Data accuracy and consistency.
* Trade-off: Requires joins during reporting (slower queries).

Learning Outcome
You learned:
* How to create an OLTP schema
* How to normalize data and enforce foreign keys
* The importance of entity design before moving to dimensional modeling

Task 2 – Designing a Star Schema (Dimensional Modeling)

Objective

Transform normalized OLTP data into a Star Schema for analytical querying in a data warehouse.

Step-by-Step

Step 1: Create Data Warehouse Schema
CREATE DATABASE IF NOT EXISTS ShopEasy_DW;
USE ShopEasy_DW;
Why:
We always separate transactional (OLTP) and analytical (OLAP) systems.

Step 2: Create Dimension Tables
CREATE TABLE DimCustomer (
  CustomerKey INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  CustomerName VARCHAR(100),
  City VARCHAR(50)
);

CREATE TABLE DimProduct (
  ProductKey INT PRIMARY KEY AUTO_INCREMENT,
  ProductID INT,
  ProductName VARCHAR(100),
  Category VARCHAR(50)
);

CREATE TABLE DimDate (
  DateKey INT PRIMARY KEY AUTO_INCREMENT,
  FullDate DATE,
  Year INT,
  Month INT,
  Day INT
);
Explanation:
Dimension tables store contextual attributes — descriptive data used for slicing and filtering.

Step 3: Create Fact Table
CREATE TABLE FactSales (
  FactID INT PRIMARY KEY AUTO_INCREMENT,
  DateKey INT,
  CustomerKey INT,
  ProductKey INT,
  Quantity INT,
  TotalAmount DECIMAL(10,2),
  FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
  FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
  FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey)
);
Explanation:
* Central table for quantitative metrics.
* References all dimensions through foreign keys.
* This structure = Star Schema.

Step 4: Populate Dimensions
INSERT INTO DimCustomer (CustomerID, CustomerName, City)
VALUES (1,'Amit Sharma','Delhi'),(2,'Neha Verma','Mumbai');

INSERT INTO DimProduct (ProductID, ProductName, Category)
VALUES (1,'Laptop','Electronics'),(2,'Mouse','Electronics'),(3,'Shoes','Fashion');

INSERT INTO DimDate (FullDate, Year, Month, Day)
VALUES ('2025-10-01',2025,10,1),('2025-10-02',2025,10,2);

Step 5: Populate Fact Table
INSERT INTO FactSales (DateKey, CustomerKey, ProductKey, Quantity, TotalAmount)
VALUES (1,1,1,1,65000),
       (1,1,2,2,1600),
       (2,2,3,1,2500);
Explanation:
Each row represents a sales event, linking to multiple dimensions by surrogate keys.

Step 6: Query Star Schema
SELECT d.FullDate, c.CustomerName, p.ProductName,
       f.Quantity, f.TotalAmount
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey=c.CustomerKey
JOIN DimProduct p ON f.ProductKey=p.ProductKey
JOIN DimDate d ON f.DateKey=d.DateKey;

Expected Output:
Consolidated fact data showing who bought what, when, and for how much.

