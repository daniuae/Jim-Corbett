# Snowflake Lab: Create, Load & Query

**Goal:** Create your first database & table, insert data, and learn basic querying – all inside the Snowflake web UI

###

### Step 1 – Log In & Open a Worksheet

1\. Go to https://app.snowflake.com and log in with your free trial account

2\. You are now in Snowsight (the web interface)

3\. Left sidebar → \*\*Worksheets\*\* → \*\*+ Worksheet\*\* (or “New Worksheet”)

→ You now have a blank SQL editor ready

### Step 2 – Your Very First Snowflake Commands

Run these one by one (highlight \+ Ctrl+Enter or click the blue Run button):

SELECT 'Hello Snowflake\! I am ready\!' AS my_first_message;

SELECT  
 CURRENT_WAREHOUSE(),  
 CURRENT_DATABASE(),  
 CURRENT_SCHEMA(),  
 CURRENT_USER(),  
 CURRENT_TIMESTAMP();

You just ran real SQL in the cloud\!

### Step 3 – Create Your Own Database & Table

\-- Create a database just for this lab  
CREATE OR REPLACE DATABASE BEGINNER_LAB;

\-- Create a schema inside it  
CREATE OR REPLACE SCHEMA MY_DATA;

\-- Switch to your new database and schema  
USE DATABASE BEGINNER_LAB;  
USE SCHEMA MY_DATA;

\-- Create a simple table  
CREATE OR REPLACE TABLE TRAINEES (  
 ID INT,  
 FIRST_NAME STRING,  
 FAVORITE_COLOR STRING,  
 JOIN_DATE DATE  
);

### Step 4 – Insert 5 Rows Manually

INSERT INTO TRAINEES VALUES  
(1, 'Alice', 'Blue', '2025-01-15'),  
(2, 'Bob', 'Green', '2025-02-20'),  
(3, 'Carol', 'Purple', '2025-03-10'),  
(4, 'David', 'Red', '2025-04-05'),  
(5, 'Eve', 'Yellow', '2025-05-01');

###

### Step 5 – Query Your Data

Run each query one at a time and look at the results below the editor.

\-- 5.1 See everything  
SELECT \* FROM TRAINEES;

\-- 5.2 Only names and favorite colors  
SELECT FIRST_NAME, FAVORITE_COLOR FROM TRAINEES;

\-- 5.3 Who likes warm colors? (Red, Yellow, Orange)  
SELECT FIRST_NAME, FAVORITE_COLOR  
FROM TRAINEES  
WHERE FAVORITE_COLOR IN ('Red', 'Yellow', 'Orange');

\-- 5.4 Create a nice badge  
SELECT  
 FIRST_NAME,  
 'Trainee \#' || ID AS BADGE,  
 FAVORITE_COLOR  
FROM TRAINEES;

\-- 5.5 How many trainees do we have?  
SELECT COUNT(\*) AS TOTAL_TRAINEES FROM TRAINEES;

\-- 5.6 Who joined in 2025? Order by date  
SELECT FIRST_NAME, JOIN_DATE  
FROM TRAINEES  
WHERE YEAR(JOIN_DATE) \= 2025  
ORDER BY JOIN_DATE;

\-- 5.7 Top 3 earliest joiners  
SELECT FIRST_NAME, JOIN_DATE  
FROM TRAINEES  
ORDER BY JOIN_DATE  
LIMIT 3;

### Step 6

- Created a database, schema, and table
- Inserted real data
- Written 7 different SELECT queries with WHERE, ORDER BY, LIMIT, calculations, and more.

###

### Optional Clean-Up

DROP DATABASE IF EXISTS BEGINNER_LAB;
