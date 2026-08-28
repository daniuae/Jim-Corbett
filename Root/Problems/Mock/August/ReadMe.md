SQL Test – Pattern, Approach & Preparation Guide

Purpose: This guide gives you a glimpse of the SQL test pattern without giving you the exact test questions. The aim is to help you understand how to think about a problem, identify the SQL pattern, and build the query step by step.

1. Test Overview

The test uses realistic business scenarios based on databases such as:

Inventory

SmartMart

AdventureWorks

Student

The questions are not designed simply to test whether you remember SQL syntax. They test whether you can:

Understand a business requirement.

Identify the relevant table(s).

Identify the required columns.

Translate words such as previous, change, monthly, low, high, specific, etc. into SQL operations.

Choose the correct SQL technique.

Build the query logically.

Produce exactly the required output.

The attached question patterns range from straightforward filtering/sorting problems to more analytical questions involving aggregation and LAG().

2. What Kind of Questions Should You Expect?

Pattern A – Filtering + Sorting

A business team wants to identify records satisfying a condition.

Typical wording:

products with low stock

products above a particular price

students scoring above a particular mark

records belonging to a particular category

records matching a particular status

SQL pattern

SELECT column1, column2, column3
FROM table_name
WHERE condition
ORDER BY column_name ASC/DESC;

Key concepts

SELECT

FROM

WHERE

Comparison operators: >, <, >=, <=, =

ORDER BY

ASC

DESC

Example thinking

If the question says:

Find products whose stock is less than 10 and display the lowest stock first.

Think:

"products"       → Products table
"less than 10"   → WHERE stock_quantity < 10
"display fields" → SELECT required columns
"lowest first"   → ORDER BY stock_quantity ASC

Do not start writing SQL immediately. First translate the sentence into operations.

3. Pattern B – JOIN + Filtering

Some questions require information from more than one table.

For example:

Product
   │
   └── Supplier

or:

Customer
   │
   └── Orders

or:

Student
   │
   └── Enrollment
          │
          └── Course

The question may ask you to display information belonging to different tables.

SQL pattern

SELECT
    a.column1,
    a.column2,
    b.column3
FROM table_a a
JOIN table_b b
    ON a.key = b.key
WHERE condition;

Key concepts

JOIN

Primary key

Foreign key

Table aliases

ON

WHERE

Important clue

When a question asks for columns that clearly belong to different tables, think:

"I probably need a JOIN."

Do not assume everything comes from one table.

4. Pattern C – Multiple JOINs

Some scenarios require information from three or more related tables.

A typical structure may look like:

Products
    │
    ▼
ProductSubcategory
    │
    ▼
ProductCategory

or:

Students
    │
    ▼
Enrollments
    │
    ▼
Courses

SQL pattern

SELECT
    a.column1,
    b.column2,
    c.column3
FROM table_a a
JOIN table_b b
    ON a.key = b.key
JOIN table_c c
    ON b.key = c.key
WHERE condition;

Key skill

Before writing the query, draw a small relationship map:

TABLE A
   │
   │ JOIN KEY
   ▼
TABLE B
   │
   │ JOIN KEY
   ▼
TABLE C

Then decide which columns come from which table.

5. Pattern D – Aggregation + Monthly Analysis

The more analytical questions follow a different pattern.

The attached test examples ask you to compare a current month's value with the previous month's value.

Examples of business metrics include:

monthly inventory/stock

monthly sales revenue

monthly sales amount

monthly student enrollments

The common requirement is:

Current Month Value
        ↓
Previous Month Value
        ↓
Difference

The source questions explicitly use LAG() across ordered months and calculate the difference between the current and previous period.

6. The Most Important Pattern: LAG()

What does LAG() do?

LAG() allows you to access a value from a previous row.

For example:

Month

Revenue

Jan

125000

Feb

138500

Mar

131000

Using:

LAG(total_revenue) OVER (ORDER BY month_start)

gives:

Month

Revenue

Previous Revenue

Jan

125000

NULL

Feb

138500

125000

Mar

131000

138500

Then:

Revenue Change = Current Revenue - Previous Revenue

So:

Feb → 138500 - 125000 = 13500
Mar → 131000 - 138500 = -7500

A negative value means the metric decreased compared with the previous period.

7. The Core Pattern You Should Memorize

The attached analytical questions follow this common structure:

RAW DATA
   ↓
GROUP BY MONTH
   ↓
MONTHLY METRIC
   ↓
LAG()
   ↓
PREVIOUS MONTH VALUE
   ↓
CURRENT - PREVIOUS
   ↓
FINAL RESULT

The four examples use different business metrics, but the underlying logic is essentially the same:

Scenario

Metric

Previous Value

Change

Inventory

Closing stock

Previous month's stock

Current − Previous

SmartMart

Sales revenue

Previous month's revenue

Current − Previous

AdventureWorks

Sales amount

Previous month's sales

Current − Previous

Student

Enrollments

Previous month's enrollments

Current − Previous

This is an important test-taking insight:

The database and business story may change, but the SQL pattern can remain the same.

8. SQL Problem-Solving Framework

Use the following framework for every question.

S – Study the Question

Read the question slowly.

Ask:

What is the business asking for?

What exactly must be returned?

Is there a condition?

Is there a calculation?

Is there a time component?

Is comparison with another row/period required?

Do not write SQL yet.

Q – Identify the Required Output

Underline or list every requested column.

Example:

Required:
- month_start
- total_revenue
- previous_month_revenue
- revenue_change

This immediately tells you what your final SELECT needs to produce.

L – Locate the Data

Find:

Database

Table

Relevant columns

Relationships between tables

Create a quick map if necessary:

Students
   ↓
Enrollments
   ↓
Courses

or:

MonthlySales

P – Pick the SQL Pattern

Ask:

Is it a simple filter?

WHERE

Is it sorting?

ORDER BY

Are columns coming from multiple tables?

JOIN

Is the question asking for totals/averages/counts?

SUM / AVG / COUNT
GROUP BY

Is it comparing current and previous rows?

LAG()

Is it comparing against a calculated aggregate?

You may need:

Subquery / CTE

S – Solve Step by Step

Build the query in small pieces.

Do not try to write a complicated query in one attempt.

For a monthly comparison problem:

Step 1 → Get the date/month
Step 2 → Calculate monthly metric
Step 3 → Order by month
Step 4 → Use LAG()
Step 5 → Calculate difference
Step 6 → Select final columns

T – Test the Result

Before submitting, check:

Are all requested columns present?

Are the columns in the requested order?

Is the filtering correct?

Is the sorting correct?

Are the JOIN conditions correct?

Is the date ordering correct?

Is the first LAG() value correctly NULL?

Does the arithmetic make sense?

Did the query accidentally duplicate rows?

9. Framework Template

Use this template on rough paper or mentally during the test.

==================================================
SQL PROBLEM-SOLVING TEMPLATE
==================================================

1. BUSINESS REQUIREMENT
What does the question want?
→ ___________________________________________

2. REQUIRED OUTPUT
Columns required:
→ ___________________________________________
→ ___________________________________________
→ ___________________________________________

3. TABLE(S)
Main table:
→ ___________________________________________

Other tables:
→ ___________________________________________

4. RELATIONSHIPS
How are the tables connected?
→ ___________________________________________

5. CONDITIONS
What must be filtered?
→ ___________________________________________

6. CALCULATIONS
What must be calculated?
→ ___________________________________________

7. GROUPING
Do I need GROUP BY?
→ YES / NO

If YES, group by:
→ ___________________________________________

8. ORDERING
Do I need ORDER BY?
→ YES / NO

Order by:
→ ___________________________________________
Direction:
→ ASC / DESC

9. WINDOW FUNCTION
Do I need a previous/next/ranking value?
→ YES / NO

Function:
→ ___________________________________________

10. QUERY PLAN
SELECT
    ______________________

FROM
    ______________________

JOIN
    ______________________

WHERE
    ______________________

GROUP BY
    ______________________

WINDOW FUNCTION
    ______________________

ORDER BY
    ______________________

11. VALIDATION
Does the output match the question?
→ YES / NO

==================================================

10. Special Framework for LAG() Questions

When you see words such as:

previous month

previous period

previous value

month-over-month

change from previous month

compared with last month

current vs previous

Immediately think:

LAG()

Then use this mental template:

1. What is the period?
        ↓
2. What is the metric?
        ↓
3. Do I need aggregation?
        ↓
4. Order by the period
        ↓
5. LAG(metric)
        ↓
6. Current - Previous

Generic structure:

WITH monthly_data AS (
    SELECT
        month_start,
        <aggregation> AS current_value
    FROM <table>
    GROUP BY month_start
)

SELECT
    month_start,
    current_value,
    LAG(current_value) OVER (
        ORDER BY month_start
    ) AS previous_value,
    current_value -
    LAG(current_value) OVER (
        ORDER BY month_start
    ) AS change
FROM monthly_data
ORDER BY month_start;

Important: When the source data is transactional and the question asks for a monthly comparison, you generally need to aggregate to the month first, then apply the window calculation. The AdventureWorks and Student patterns specifically demonstrate this idea.

11. How to Recognize the SQL from the English

Train yourself to translate keywords.

Question wording

Think SQL

all products

SELECT

whose / where

WHERE

greater than

>

less than

<

equal to

=

between

BETWEEN

either/or

OR

both conditions

AND

highest first

DESC

lowest first

ASC

sorted by

ORDER BY

total

SUM()

average

AVG()

number of

COUNT()

for each category

GROUP BY category

for each month

GROUP BY month

previous month

LAG()

current minus previous

arithmetic difference

information from another table

JOIN

only matching records

WHERE

top result

ORDER BY ... DESC + LIMIT

12. Tips & Tricks

Tip 1 – Don't Start With SELECT

Many students immediately type:

SELECT *

Instead, first ask:

What is the question actually asking me to find?

Then build the query.

Tip 2 – Circle the Important Words

When reading the question, identify words such as:

LOW
HIGH
MORE THAN
LESS THAN
PREVIOUS
MONTH
TOTAL
AVERAGE
EACH
SORT
DESCENDING

These words are often direct clues to the SQL operation.

Tip 3 – Match Every Requirement to SQL

If the question says:

Display product name and price for products above ₹2,000, sorted from highest to lowest.

Translate:

product name + price → SELECT
above ₹2,000         → WHERE price > 2000
highest to lowest    → ORDER BY price DESC

Tip 4 – Don't Use JOINs Automatically

First ask:

Are the required columns in one table?

If yes, you may not need a JOIN.

Use a JOIN when the required information is distributed across related tables.

Tip 5 – Check the JOIN Path

For multiple JOIN questions, don't guess.

Write:

Table A
  ↓
Table B
  ↓
Table C

Then identify the key used at each connection.

Tip 6 – For LAG(), Always Check the ORDER BY

This is critical:

LAG(value) OVER (
    ORDER BY month_start
)

Without the correct ordering, "previous" has no meaningful business interpretation.

Tip 7 – First Month = NULL

In a previous-month comparison, the first month has no previous month.

Therefore:

Previous value = NULL
Change = NULL

Do not assume the first month's previous value is zero unless the question explicitly says so.

Tip 8 – Validate the Arithmetic

If:

Current = 150
Previous = 125

then:

Change = 150 - 125
       = 25

If:

Current = 120
Previous = 150

then:

Change = 120 - 150
       = -30

A negative result is not automatically an error.

Tip 9 – Read the Output Requirement Carefully

If the question requests:

student_id
student_name
marks

don't return:

SELECT *

Return the requested columns.

Also check the requested order.

Tip 10 – Test Small Pieces

If a complex query isn't working, don't panic.

Test:

SELECT ...
FROM ...

Then add:

WHERE

Then:

GROUP BY

Then:

LAG()

Then the final calculation.

13. Common Mistakes to Avoid

Mistake 1 – Confusing WHERE and HAVING

Use:

WHERE → filter rows before grouping
HAVING → filter groups after GROUP BY

Mistake 2 – Forgetting GROUP BY

If you use:

SUM(...)

with a non-aggregated column, consider whether you need:

GROUP BY

Mistake 3 – Applying LAG() Before Aggregating

For transactional data, if the question asks for monthly totals, first create the monthly totals.

Think:

Transactions
      ↓
Monthly totals
      ↓
LAG()

not:

Transactions
      ↓
LAG()

Mistake 4 – Wrong JOIN Condition

Never join tables simply because their names look related.

Find the actual key relationship.

Mistake 5 – Wrong Sort Direction

Remember:

ASC  → small → large
DESC → large → small

So:

highest price first → DESC
lowest stock first  → ASC
highest marks first → DESC

Mistake 6 – Overcomplicating a Simple Question

If the answer requires only:

SELECT
FROM
WHERE
ORDER BY

don't introduce:

CTE
subquery
window function

unless they are actually necessary.

14. Difficulty Progression You Should Expect

The question patterns can be viewed as a progression:

LEVEL 1
SELECT + WHERE
        ↓
LEVEL 2
WHERE + ORDER BY
        ↓
LEVEL 3
AND / OR + multiple conditions
        ↓
LEVEL 4
GROUP BY + aggregate functions
        ↓
LEVEL 5
JOIN
        ↓
LEVEL 6
Multiple JOINs
        ↓
LEVEL 7
Subqueries / CTEs
        ↓
LEVEL 8
Window functions
        ↓
LEVEL 9
Business-oriented analysis

The attached materials demonstrate both the basic filtering/sorting pattern and the monthly analytical/window-function pattern.

15. Final Exam Strategy

When you receive a question:

                 READ
                   ↓
        What is being asked?
                   ↓
        Identify the OUTPUT
                   ↓
        Identify TABLE(S)
                   ↓
       Identify CONDITIONS
                   ↓
      Identify CALCULATIONS
                   ↓
        Identify SQL PATTERN
                   ↓
         Build query in steps
                   ↓
           RUN THE QUERY
                   ↓
        CHECK THE RESULT
                   ↓
              SUBMIT

The Golden Rule

Don't think: "Which SQL query do I remember?"

Think:

"What is the question asking me to do, and which SQL operation represents each part of that requirement?"

16. Quick Revision Card

Before the test, remember:

FILTER       → WHERE
SORT         → ORDER BY
TOTAL        → SUM()
AVERAGE      → AVG()
COUNT        → COUNT()
GROUP        → GROUP BY
MULTI-TABLE  → JOIN
PREVIOUS     → LAG()
CURRENT-PREV → DIFFERENCE
TOP          → ORDER BY DESC + LIMIT
MONTHLY      → DATE/MONTH + GROUP BY

And for analytical questions:

TRANSACTION DATA
       ↓
AGGREGATE
       ↓
ORDER BY TIME
       ↓
LAG()
       ↓
PREVIOUS VALUE
       ↓
CURRENT - PREVIOUS

Final Message to Trainees

You are not expected to memorize complete queries.

You are expected to recognize patterns.

A question may talk about:

inventory,

sales,

products,

students,

enrollments,

customers,

but the underlying SQL logic may be exactly the same.

Focus on the problem-solving process, not the story.

Read → Break down → Identify pattern → Build → Test → Validate.
