Snowflake ETL Lab
Dataset: employees.csv
(u can use ur own employee.csv datasets)

Total Marks: 10
Objective
By the end of this lab, you will be able to:
* Create a database and table in Snowflake.
* Load a 1,000-row CSV file using the Snowflake Load Wizard.
* Validate the loaded data using SQL.

Dataset Description
The employees.csv file contains 1,000 employee records with the following columns:
* EMPLOYEE_ID
* FIRST_NAME
* LAST_NAME
* DEPARTMENT
* LOCATION
* SALARY
* JOIN_DATE

Step 1: Log In to Snowflake
1. Open Snowflake.
2. Log in using your trainee credentials.
3. Go to Worksheets → + Worksheet.

Step 2: Create the Database, Schema, and Table
Run the following SQL commands.
Create Database and Select Schema
CREATE OR REPLACE DATABASE STUDENT_ETL_LAB;

USE DATABASE STUDENT_ETL_LAB;

USE SCHEMA PUBLIC;

Create the Target Table
CREATE OR REPLACE TABLE EMPLOYEES_1K (
    EMPLOYEE_ID INT,
    FIRST_NAME STRING,
    LAST_NAME STRING,
    DEPARTMENT STRING,
    LOCATION STRING,
    SALARY NUMBER,
    JOIN_DATE DATE
);

The table should appear under:
STUDENT_ETL_LAB → PUBLIC → TABLES

Step 3: Load the employees.csv File
1. In the left sidebar, open:
2. STUDENT_ETL_LAB → PUBLIC → Tables
3. Select the EMPLOYEES_1K table.
4. Click Load Data.
5. Upload employees.csv.
6. Create/select a CSV file format with:
* Type: CSV
* Field Delimiter: ,
* Header row skipped
1. Select a warehouse, for example COMPUTE_WH.
2. Click Load.
Confirm that the file loads successfully and that 1000 rows are loaded.

Step 4: Validate the Loaded Data
Preview the First 20 Rows
SELECT *
FROM EMPLOYEES_1K
ORDER BY EMPLOYEE_ID
LIMIT 20;

Check the Total Row Count
SELECT COUNT(*)
FROM EMPLOYEES_1K;

Expected result: 1000
List the Departments
SELECT DISTINCT DEPARTMENT
FROM EMPLOYEES_1K;

Find the Highest Salary
SELECT MAX(SALARY)
FROM EMPLOYEES_1K;


Submission Requirements
Submit exactly 4 clear screenshots:
1. Created Table – Show the EMPLOYEES_1K table inside STUDENT_ETL_LAB → PUBLIC.
2. Data Load – Show that employees.csv was loaded successfully with 1000 rows loaded.
3. Employee Data – Show the output of the query displaying the first 20 employee records.
4. Validation Results – Show the row count, departments, and highest salary query results.

Evaluation Rubric – 10 Marks

1. Database and Table Creation – 2 Marks
The database and EMPLOYEES_1K table are created correctly.

2. CSV Data Load – 3 Marks
The employees.csv file is loaded successfully with 1000 rows.

3. Employee Data Preview – 2 Marks
The first 20 employee records are displayed correctly.

4. Validation Queries – 2 Marks
The row count, department list, and highest salary queries are executed correctly.

5. Submission – 1 Mark
All 4 required screenshots are submitted clearly.

Total: 10 Marks
Evaluation Note
Marks should be given only for work clearly visible in the submitted screenshots. If a required result is missing, unclear, or cannot be verified, marks should not be awarded for that part.
