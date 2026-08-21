SQL Problem-Solving Framework

Purpose

This document is designed to help SQL learners move beyond memorizing
SQL syntax and develop a structured approach to solving SQL
problems.

The central idea is:

Question → Pattern → Grain → Technique → Layers → SQL → Validation

Instead of immediately asking "Which SQL command should I use?",
learners are encouraged to ask:

"What transformation does the business question require?"

What the Document Covers

The trainee material brings together the key stages of SQL problem
solving:

Output Grain --- determine what one row in the final result
represents.

Tables --- identify the tables required to answer the question.

Columns --- determine the information that must appear in the
output.

Calculations --- identify aggregations and business
calculations.

Pattern Recognition --- map business wording to SQL techniques.

Layering --- break complex problems into smaller intermediate
steps.

SQL Construction --- build the query from the identified layers.

Validation --- check intermediate and final results.

Key Learning Principle: Output Grain

One of the most important ideas in the document is:

"What does one row in my final output represent?"

For example:

Total sales for each customer → one row represents one customer.

Monthly sales for each customer → one row represents one
customer + one month.

Top 3 products in each category → one row represents one product
within one category.

Understanding the output grain helps learners make better decisions
about GROUP BY, PARTITION BY, joins, and window functions.

Pattern Recognition

The document provides a practical pattern dictionary that connects
common business phrases with likely SQL techniques.

Examples:

Business wording    Think about                     Likely technique

Total sales         Aggregation                     SUM()
Number of records   Counting                        COUNT()
More than X         Filter groups                   GROUP BY + HAVING
Above average       Compare with calculated value   Subquery / CTE
Top N per group     Ranking within a group          Window function
Previous record     Previous row                    LAG()
Running total       Cumulative calculation          SUM() OVER()
Latest record       Most recent row                 ROW_NUMBER()
Month-over-month    Previous period                 LAG()

The goal is not to memorize the mapping mechanically, but to recognize
the type of transformation required by the question.

Progressive SQL Learning

The material follows a progression from simple concepts to complex
business problems:

SELECT, WHERE

JOIN

GROUP BY and aggregates

HAVING

Subqueries

CTEs

Window functions

Date/time operations

Combination problems

Real-world SQL problems

Each stage builds on the previous one so that learners gradually develop
the ability to combine multiple SQL techniques.

Practice Environment

The document uses a consistent E-Commerce Sales Database containing:

customers → orders → order_items → products → categories

This common business domain allows learners to practice filtering,
joins, aggregation, subqueries, CTEs, window functions, date/time
analysis, and multi-stage problems without repeatedly learning a new
schema.

From Simple Problems to Real-World Problems

The document progresses from individual SQL concepts to combination
problems such as:

JOIN + GROUP BY

JOIN + GROUP BY + HAVING

JOIN + SUBQUERY

JOIN + CTE

JOIN + WINDOW FUNCTION

It then introduces more advanced problems involving ranking,
categories, months, previous-period comparisons, and percentage
calculations.

A representative advanced pattern is:

Top 2 products by revenue for every category for each month, compare
with the previous month, and calculate percentage change.

This is decomposed into logical stages rather than being treated as one
large SQL query.

Practice and Assessment

The trainee material also includes:

Output-grain exercises

Pattern-recognition exercises

A reusable SQL problem-solving worksheet

Easy, medium, hard, and milestone-level problems

An eight-week learning progression

Combination and real-world SQL practice

The worksheet encourages learners to record:

What the question is asking

Output grain

Required tables

Required columns

Required calculations

Recognized SQL pattern

Problem layers

SQL query

Intermediate validation

Final validation

Expected Learning Outcome

By working through this framework, a learner should progress from:

"I know SQL commands."

to:

"I can look at an unfamiliar business question, identify the output
grain, recognize the required SQL pattern, break the problem into
logical layers, construct the query, and validate the result."

Central Rule

Business Question → Output Grain → Required Transformation → SQL
Pattern → Query Layers → SQL → Validation

This is the core problem-solving mindset the trainee document is
intended to develop.
