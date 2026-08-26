-- Data Profiling and Cleansing
-- Total Marks: 10

-- Objective
-- Use SQL to identify data-quality issues such as missing values, duplicates, extra spaces, inconsistent casing, and invalid phone lengths, then clean the data.
-- Scenario
-- You are a data analyst at ShopEasy Retail.
-- The Customers table contains data collected from different branches. Before loading it into the warehouse, you need to profile and clean the data.

-- Step 1: Create the Database
-- CREATE DATABASE IF NOT EXISTS ShopEasy_Profile;

USE ShopEasy_Profile;

-- Step 2: Create the Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(120),
    Phone VARCHAR(20),
    City VARCHAR(50),
    Country VARCHAR(50)
);

-- Step 3: Insert Sample Data
INSERT INTO
    Customers
VALUES (
        1,
        'Amit  Sharma',
        'amit@shop.com',
        '9876543210',
        'Delhi',
        'India'
    ),
    (
        2,
        'Neha  Verma',
        'neha@shop.com',
        ' ',
        'mumbai',
        'india'
    ),
    (
        3,
        'Ravi Kumar',
        NULL,
        '9567843210',
        'Bangalore',
        'India'
    ),
    (
        4,
        'Amit  Sharma',
        'amit@shop.com',
        '9876543210',
        'Delhi',
        'India'
    ),
    (
        5,
        NULL,
        'john@shop.com',
        '9999999999',
        'Chennai',
        'INDIA'
    );

-- The data contains issues such as duplicates, missing values, blank values, extra spaces, and inconsistent casing.

-- Step 4: Profile the Data
-- Check the total number of records.
SELECT COUNT(*) AS TotalRecords FROM Customers;

-- Check NULL and blank values.
SELECT
    SUM(
        CASE
            WHEN FullName IS NULL
            OR TRIM(FullName) = '' THEN 1
            ELSE 0
        END
    ) AS NullNames,
    SUM(
        CASE
            WHEN Email IS NULL
            OR TRIM(Email) = '' THEN 1
            ELSE 0
        END
    ) AS NullEmails,
    SUM(
        CASE
            WHEN Phone IS NULL
            OR TRIM(Phone) = '' THEN 1
            ELSE 0
        END
    ) AS NullPhones
FROM Customers;

-- Check duplicate customers.

SELECT FullName, Email, COUNT(*) AS DupCount
FROM Customers
GROUP BY
    FullName,
    Email
HAVING
    COUNT(*) > 1;

-- Check inconsistent country values.
SELECT DISTINCT Country FROM Customers;

-- Step 5: Clean the Data
-- Remove extra spaces and standardize text.
UPDATE Customers
SET
    FullName = TRIM(FullName),
    City = CONCAT(
        UPPER(LEFT(TRIM(City), 1)),
        LOWER(SUBSTRING(TRIM(City), 2))
    ),
    Country = UPPER(TRIM(Country));

-- Convert blank phone numbers to NULL.

UPDATE Customers SET Phone = NULL WHERE TRIM(Phone) = '';

-- Replace missing values.
UPDATE Customers SET Country = 'INDIA' WHERE Country IS NULL;

UPDATE Customers
SET
    FullName = 'Unknown Customer'
WHERE
    FullName IS NULL;

-- Remove duplicate records
-- and keep the first record.

DELETE c1
FROM
    Customers c1
    JOIN Customers c2 ON c1.FullName = c2.FullName
    AND c1.Email = c2.Email
    AND c1.CustomerID > c2.CustomerID;

-- Step 6: Validate the Cleaned Data
-- Check the cleaned data.
SELECT * FROM Customers;

-- Check for phone - length issues.

SELECT *
FROM Customers
WHERE
    Phone IS NOT NULL
    AND (
        LENGTH(Phone) < 10
        OR LENGTH(Phone) > 12
    );

-- Run the final profile.

SELECT
    COUNT(*) AS Total,
    COUNT(DISTINCT Email) AS UniqueEmails,
    SUM(
        CASE
            WHEN City IS NULL THEN 1
            ELSE 0
        END
    ) AS NullCities
FROM Customers;

-- Submission Requirements
-- Submit 4 clear screenshots:
-- 1. Original Data – Show the Customers table after inserting the sample data.
-- 2. Profiling Results – Show the results for NULL/blank values, duplicates, or inconsistent values.
-- 3. Cleaned Data – Show the Customers table after applying the cleansing steps.
-- 4. Final Validation – Show the final profiling or validation query results after cleaning.
-- Also submit your SQL script containing the profiling and cleansing queries.


-- Evaluation Rubric – 10 Marks

-- 1. Table and Sample Data – 2 Marks
-- The Customers table and sample data are created correctly.

-- 2. Data Profiling – 2 Marks
-- NULLs, blanks, duplicates, or inconsistent values are identified correctly.

-- 3. Data Cleansing – 3 Marks
-- Spaces, casing, blanks, missing values, and duplicates are cleaned correctly.

-- 4. Final Validation – 2 Marks
-- The cleaned data is checked and the final results are correct.

-- 5. SQL Script – 1 Mark
-- The submitted SQL script contains the required profiling and cleansing queries.

-- Total: 10 Marks
-- Evaluation Note
-- Marks should be given only for work clearly visible in the screenshots and SQL script. If a required result cannot be seen or verified, marks should not be awarded for that part.
