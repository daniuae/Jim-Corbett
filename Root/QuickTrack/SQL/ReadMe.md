# **SQL Learning & Problem-Solving Repository**

> **From SQL Syntax → Logic → Scenarios → Problem Decomposition → Optimization → Professional SQL Thinking**

## **📌 About This Repository**

This repository is designed as a structured SQL learning and practice environment for progressing from **SQL fundamentals to real-world problem solving**.

The goal is not simply to memorize SQL syntax or individual queries.

The primary objective is to develop the ability to:

* Understand a business requirement  
* Identify the required tables and columns  
* Understand relationships between tables  
* Determine the correct level of detail, or **grain**  
* Decide whether filtering, grouping, joining, subqueries, CTEs, or window functions are required  
* Break complex SQL problems into smaller steps  
* Validate whether the result is logically correct  
* Consider duplicates, `NULL` values, edge cases, readability, and performance  
* Explain a SQL solution clearly in plain English

The overall learning journey follows:

SQL Fundamentals  
       ↓  
Query Building  
       ↓  
Problem Decomposition  
       ↓  
Scenario-Based SQL  
       ↓  
Multi-Table Problems  
       ↓  
Advanced SQL  
       ↓  
Performance & Optimization  
       ↓  
Professional SQL Developer

This progression is explicitly designed to move learners from **syntax-oriented learning toward professional SQL thinking**. 

---

# **🎯 Learning Philosophy**

The core learning cycle used throughout this repository is:

Understand  
    ↓  
Copy a Pattern  
    ↓  
Modify the Pattern  
    ↓  
Solve Independently  
    ↓  
Explain the Solution

For each concept, the recommended practice cycle is:

CONCEPT  
   ↓  
ONE SIMPLE EXAMPLE  
   ↓  
GUIDED QUERY  
   ↓  
MODIFY THE QUERY  
   ↓  
NEW PROBLEM  
   ↓  
EXPLAIN WHY IT WORKS

The focus is deliberately on **practice and reasoning rather than lengthy theoretical lectures**. 

---

# **🧭 SQL Learning Roadmap**

## **Phase 1 — SQL Fundamentals**

Build confidence with:

* `SELECT`  
* `FROM`  
* `WHERE`  
* `DISTINCT`  
* `ORDER BY`  
* `LIMIT` / `TOP` / `FETCH`  
* Aliases  
* Arithmetic expressions  
* Logical operators  
* `IN`  
* `BETWEEN`  
* `LIKE`  
* `NULL`  
* `IS NULL`  
* `IS NOT NULL`

The SQL SELECT syllabus intentionally introduces these concepts progressively rather than presenting them all at once. 

---

## **Phase 2 — SQL Functions**

Learn how SQL can transform and calculate data.

### **String Functions**

* `UPPER`  
* `LOWER`  
* `LENGTH`  
* `TRIM`  
* `SUBSTRING`  
* `CONCAT`  
* `REPLACE`  
* `LEFT`  
* `RIGHT`

### **Numeric Functions**

* `ROUND`  
* `CEIL`  
* `FLOOR`  
* `ABS`  
* `MOD`  
* `POWER`  
* `SQRT`

### **Date Functions**

* Current date  
* Current timestamp  
* Extracting year/month/day  
* Date arithmetic  
* Date difference  
* Date filtering

The syllabus treats string, numeric, and date functions as part of the progression from basic querying toward practical SQL. 

---

# **📊 Phase 3 — Aggregation Thinking**

Move from retrieving individual records to answering questions about groups of records.

Core functions:

COUNT()  
SUM()  
AVG()  
MIN()  
MAX()

Then progress to:

GROUP BY  
    ↓  
HAVING  
    ↓  
WHERE \+ GROUP BY \+ HAVING

A key distinction to master:

WHERE  
→ Filters rows before aggregation

HAVING  
→ Filters groups after aggregation

This distinction is treated as an important milestone in the learning plan. 

---

# **🔗 Phase 4 — JOIN Mastery**

JOINs represent the transition from beginner SQL toward multi-table reasoning.

Instead of learning JOINs only as syntax, this repository approaches them through **relationships and business questions**.

Example relationship:

CUSTOMERS  
    │  
    │ 1  
    │  
    │ many  
    ↓  
ORDERS  
    │  
    │ 1  
    │  
    │ many  
    ↓  
ORDER\_ITEMS  
    │  
    │ many  
    ↓  
PRODUCTS

Topics include:

* `INNER JOIN`  
* `LEFT JOIN`  
* `RIGHT JOIN`  
* `FULL OUTER JOIN`  
* `CROSS JOIN`  
* `SELF JOIN`  
* Multiple JOINs

The recommended emphasis is:

INNER JOIN  
    ↓  
LEFT JOIN  
    ↓  
SELF JOIN  
    ↓  
CROSS JOIN

The repository uses scenarios such as:

* Customers and their orders  
* Customers who never ordered  
* Customers with more than five orders  
* Customers whose spending exceeds ₹50,000  
* Customers who purchased Product A but not Product B

This shifts the learner from **syntax practice to relationship-based reasoning**. 

---

# **🧠 Phase 5 — SQL Problem Decomposition**

This is one of the most important skills in this repository.

Before writing SQL, **do not immediately start typing `SELECT`**.

Use the:

## **D → T → R → F → G → W → V Framework**

| Step | Meaning | Question |
| ----- | ----- | ----- |
| **D** | Define | What exactly is being asked? |
| **T** | Tables | Which tables contain the information? |
| **R** | Relationships | How are the tables connected? |
| **F** | Filter | Which records should be included? |
| **G** | Group | At what level should calculations happen? |
| **W** | Window | Do ranking/previous/next/running calculations apply? |
| **V** | Validate | Does the result make business sense? |

This framework is explicitly recommended as the SQL problem-solving framework in the roadmap. 

### **The "Don't Touch SQL Yet" Rule**

For difficult problems, spend the first **2–5 minutes without writing SQL**.

Document:

Required Output:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Tables:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Relationships:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Filters:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Grouping:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Special Logic:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Only after this analysis should SQL be written. 

---

# **🧩 Phase 6 — Intermediate SQL**

Once basic scenarios are comfortable, introduce:

### **Subqueries**

* Scalar subqueries  
* `IN` subqueries  
* Correlated subqueries  
* `EXISTS`  
* `NOT EXISTS`

### **Conditional Logic**

* `CASE`  
* Conditional aggregation  
* `COALESCE`  
* `NULLIF`

### **CTEs**

* Single CTE  
* Multiple CTEs  
* Recursive CTEs

CTEs should be viewed primarily as a **problem-decomposition and readability tool**:

Complex Problem  
      ↓  
Intermediate Result  
      ↓  
Next Step  
      ↓  
Final Result

The key mindset is:

> **"I can break a complicated problem into steps."**

rather than simply memorizing what CTE stands for. 

---

# **📈 Phase 7 — Window Functions**

Window functions are introduced through **problems rather than syntax memorization**.

Core topics:

SUM() OVER()  
AVG() OVER()  
COUNT() OVER()

ROW\_NUMBER()  
RANK()  
DENSE\_RANK()

LAG()  
LEAD()

Then progress to:

* Ranking  
* Ranking within groups  
* Running totals  
* Moving averages  
* Previous/next records  
* Top-N per group  
* Comparing rows  
* Time-series analysis

For example:

Rank employees  
      ↓  
Rank employees by department  
      ↓  
Find highest-paid employee per department  
      ↓  
Find second-highest salary  
      ↓  
Compare salary with department average  
      ↓  
Find previous customer order

The roadmap specifically recommends this problem-driven progression. 

---

# **🔥 Phase 8 — Multi-Step SQL Problems**

Complex SQL should be understood as **multiple simple problems connected together**.

Example:

> Find the top 3 customers by revenue in each region.

Instead of immediately writing SQL:

TOP 3 CUSTOMERS  
       ↓  
CUSTOMER REVENUE  
       ↓  
GROUP BY CUSTOMER  
       ↓  
REGION  
       ↓  
RANK CUSTOMERS  
       ↓  
KEEP RANK \<= 3

The required SQL concepts then become apparent:

GROUP BY  
   \+  
SUM()  
   \+  
WINDOW FUNCTION  
   \+  
PARTITION BY  
   \+  
ORDER BY

This is the central idea of SQL problem decomposition. 

---

# **🌎 Phase 9 — Real-World SQL Scenarios**

The repository moves progressively from isolated syntax exercises toward business problems.

Example scenarios include:

### **E-Commerce**

> Find customers who haven't purchased in the last 90 days.

### **Banking**

> Identify customers whose transaction volume increased by more than 50% compared with the previous month.

### **HR**

> Find employees earning above their department average.

### **Retail**

> Find the best-selling product in each store.

### **Finance**

> Calculate month-over-month revenue growth.

### **Manufacturing**

> Find machines whose downtime increased for three consecutive months.

The objective is for learners to determine independently:

What tables?  
      ↓  
What columns?  
      ↓  
What relationships?  
      ↓  
What filters?  
      ↓  
What aggregation?  
      ↓  
What window?  
      ↓  
What intermediate result?  
      ↓  
What final result?  
---

# **🧪 Practice Method**

Each practice session should progressively increase difficulty.

## **Level 1 — Recall**

Basic SQL syntax.

SELECT  
WHERE  
ORDER BY

Example:

> Find customers from Mumbai.

## **Level 2 — Combine**

WHERE \+ ORDER BY

## **Level 3 — Aggregate**

GROUP BY \+ Aggregate

## **Level 4 — Multi-table**

JOIN \+ GROUP BY

## **Level 5 — Conditional Logic**

CASE

## **Level 6 — Subquery**

Above average

## **Level 7 — CTE**

Break complex logic into stages

## **Level 8 — Window Function**

Ranking  
Running totals  
LAG / LEAD

## **Level 9 — Multi-step Scenario**

Several concepts combined.

## **Level 10 — Real-world Case Study**

No indication of which SQL concept to use.

The learner must decide how to solve the problem. 

---

# **🛠️ Daily Practice Model**

A typical practice session follows:

1\. Warm-up Problem  
        ↓  
2\. Combine Problem  
        ↓  
3\. Scenario Problem  
        ↓  
4\. Challenge Problem  
        ↓  
5\. Debugging Problem  
        ↓  
6\. Explain the Solution

For example:

### **Warm-up**

> Find all active customers.

### **Combine**

> Find active customers with orders above ₹10,000.

### **Scenario**

> Identify customers whose spending exceeds average customer spending.

### **Challenge**

> Find the top 3 customers by revenue in each region.

### **Debug**

> Find and fix the errors in a broken SQL query.

### **Explain**

> Explain your SQL solution in plain English.

The final explanation step is important: if a learner cannot explain a query without simply reading it line by line, the solution may not yet be fully understood. 

---

# **🐛 Debugging & "What's Wrong With This Query?"**

SQL learning should not only involve writing correct queries.

Learners should also practice identifying incorrect queries.

Questions to ask:

* Is the `WHERE` condition correct?  
* Should this condition be in `HAVING`?  
* Is the `GROUP BY` at the correct grain?  
* Did the JOIN multiply rows?  
* Are duplicates affecting the result?  
* Are `NULL` values handled correctly?  
* Are all selected columns valid?  
* Can the query be simplified?  
* Is the result logically correct?

Broken-query exercises are specifically recommended to develop debugging ability. 

---

# **🔍 Predict the Output**

Before executing SQL, learners should sometimes predict the result.

Read Query  
    ↓  
Understand Data  
    ↓  
Predict Result  
    ↓  
Execute Query  
    ↓  
Compare  
    ↓  
Explain Difference

This develops a mental execution model and SQL intuition. 

---

# **⚠️ Edge Cases**

Professional SQL thinking requires asking:

> **"When could this query fail or produce a misleading result?"**

Practice should deliberately include:

* `NULL`  
* Duplicate records  
* Missing records  
* Zero values  
* Negative values  
* Multiple orders  
* Duplicate keys  
* Same timestamps  
* Ties  
* Empty tables

For ranking problems, learners should understand how ties affect:

ROW\_NUMBER()  
RANK()  
DENSE\_RANK()  
---

# **📓 SQL Problem-Solving Journal**

Every difficult problem should ideally be documented.

Problem:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Requirement:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

What should one row represent?  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Tables:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Relationships:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Filters:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Aggregation:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

SQL Concepts Used:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

My First Mistake:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Final Solution:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Alternative Solution:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

What I Learned:  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

Over time, this becomes a personal SQL problem-solving knowledge base. The roadmap recommends maintaining such a journal across roughly 50–100 problems. 

---

# **🏆 Professional SQL Thinking**

The final goal is not:

> **"I know SQL syntax."**

The goal is:

> **"I can understand a business problem, decompose it, write SQL, validate the result, and explain why my solution works."**

Before considering a query complete, ask:

DATA  
→ What is the grain?

RELATIONSHIP  
→ Can this JOIN multiply rows?

LOGIC  
→ What exactly am I measuring?

NULL  
→ How will NULL affect the result?

PERFORMANCE  
→ How much data is being processed?

MAINTAINABILITY  
→ Will another developer understand this query?

VALIDATION  
→ How do I know the result is correct?

These questions represent the transition from **SQL learner to professional SQL developer**. 

---

# **🔎 SQL Code Review**

Towards the advanced stage, SQL solutions should also be reviewed for:

* Correctness  
* Readability  
* Performance  
* Maintainability  
* Edge cases  
* Naming  
* Duplicates  
* `NULL` handling

Instead of asking:

> "Is this query correct?"

ask:

> **"Would I approve this query in production?"**

This introduces a professional engineering mindset. 

---

# **🛒 Capstone Project — Customer Sales Analytics**

The repository uses an online-retailer scenario as a practical capstone.

### **Core tables**

customers  
orders  
order\_items  
products

### **Basic SQL**

* List customers  
* Filter customers by region  
* Find large orders  
* Find the largest orders

### **Aggregation**

* Calculate total sales  
* Sales by customer  
* Sales by product  
* Customers exceeding a sales threshold

### **JOINs**

* Customer \+ order information  
* Customer \+ product \+ sales  
* Customers without orders

### **Subqueries / CTEs**

* Customers spending above average  
* Products priced above average

### **Window Functions**

* Rank customers  
* Rank customers within regions  
* Top 3 customers per region  
* Previous order amount

### **Final Challenge**

Produce:

Region  
Customer  
Total Sales  
Regional Rank  
Previous Order  
Sales Category

The final challenge deliberately requires multiple SQL concepts to work together. 

---

# **📅 Suggested 10-Week Progression**

| Week | Focus | Main Skill |
| ----- | ----- | ----- |
| 1 | `SELECT`, `WHERE`, expressions | Query basics |
| 2 | Aggregation, `GROUP BY`, `HAVING` | Thinking in groups |
| 3 | JOINs | Relationships |
| 4 | JOIN \+ aggregation | Multi-table reasoning |
| 5 | `CASE`, subqueries, `EXISTS` | Conditional logic |
| 6 | CTEs | Problem decomposition |
| 7 | Window functions | Analytical thinking |
| 8 | Dates \+ advanced scenarios | Business problems |
| 9 | Complex case studies | Problem solving |
| 10 | Optimization \+ code review | Professional SQL |

This progression is based on the roadmap's suggested curriculum. 

---

# **🚀 The End Goal**

The learner should progress from:

"I don't know how to start this SQL problem."

to:

"What exactly is being asked?

What tables do I need?

How are they related?

What should one row represent?

Do I need filtering?

Do I need aggregation?

Do I need a subquery or CTE?

Do I need a window function?

How can I validate the result?

Let me break the problem into steps."

That is the real measure of SQL progress.

The objective is **not to memorize hundreds of queries**.

The objective is to develop a repeatable problem-solving process that allows a learner to approach unfamiliar SQL problems with confidence. 

---

## **⭐ Repository Principle**

> **Think first. Write SQL second. Validate always.**

BUSINESS REQUIREMENT  
        ↓  
UNDERSTAND THE DATA  
        ↓  
IDENTIFY THE GRAIN  
        ↓  
IDENTIFY TABLE RELATIONSHIPS  
        ↓  
DECOMPOSE THE PROBLEM  
        ↓  
SELECT THE SQL PATTERN  
        ↓  
WRITE THE QUERY  
        ↓  
VALIDATE THE RESULT  
        ↓  
CHECK EDGE CASES  
        ↓  
REVIEW PERFORMANCE  
        ↓  
EXPLAIN THE SOLUTION  
        ↓  
IMPROVE

**SQL is not just a language to query data.**  
**It is a way of thinking about data.**

