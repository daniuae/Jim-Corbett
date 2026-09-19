# Milestone 1 Databricks Assessment -- Failure Analysis & Recovery Strategy

## 1. Executive Summary

The assessment data shows that **47 out of 52 trainees cleared the
test**, while **5 trainees did not clear**.

  Metric                         Result
  --------------------------- ---------
  Total Trainees                     52
  Cleared                            47
  Not Cleared                         5
  Cleared Percentage              90.4%
  Not-Cleared Percentage           9.6%
  Overall Average               \~79.1%
  Not-Cleared Group Average     \~47.0%

### Key Finding

The primary weakness of the five trainees is not simply theoretical
knowledge. The major gap is the ability to convert a problem statement
into a working SQL/Python solution under test conditions.

The biggest gaps are: - Coding - Python Medium - SQL Medium - Basic
SQL/Python implementation for selected trainees - Problem decomposition
and time management

Therefore, the next preparation should be **targeted and
individualized**, rather than repeating the entire syllabus for
everyone.

------------------------------------------------------------------------

## 2. Not-Cleared Trainees

  -------------------------------------------------------------------------------------
  Trainee        MCQ /40 SQL Easy   Python      SQL   Python   Coding    Total   Gap to
                              /10 Easy /10   Medium   Medium      /60     /100       65
                                                /20      /20                   
  ------------- -------- -------- -------- -------- -------- -------- -------- --------
  Sreeja              29        0      1.6        0      2.2      3.8     32.8     32.2
  Thanuku                                                                      

  Chaithrika          25       10       10        0      5.6     25.6     50.6     14.4
  Dommaraju                                                                    

  Abubakar            30        0        0       20        0     20.0     50.0     15.0
  Sayyad                                                                       

  Mageshwaran         35        0      4.8       20      4.4     29.2     64.2      0.8
  D.R                                                                          

  Chaitanya           29       10        8        0      3.3     21.3     50.3     14.7
  Bhamere                                                                      
  -------------------------------------------------------------------------------------

------------------------------------------------------------------------

## 3. Individual Diagnosis

### Sreeja Thanuku --- Foundation Recovery

**Score: 32.8%**

Performance: - MCQ: 29/40 - SQL Easy: 0/10 - Python Easy: 1.6/10 - SQL
Medium: 0/20 - Python Medium: 2.2/20 - Coding: 3.8/60

**Diagnosis:** Significant difficulty converting a problem statement
into executable SQL/Python logic.

**Strategy:** Start with fundamentals and problem decomposition before
medium-level questions.

``` text
Problem Statement
        ↓
Identify Input
        ↓
Identify Expected Output
        ↓
Break Problem into Steps
        ↓
Write Pseudocode
        ↓
Select SQL/Python Functionality
        ↓
Write Code
        ↓
Validate Result
```

Focus on Python fundamentals, Pandas basics, SQL SELECT/WHERE/GROUP
BY/HAVING, JOINs, and simple coding problems.

------------------------------------------------------------------------

### Chaithrika Dommaraju --- Easy-to-Medium Transition

**Score: 50.6%**

Performance: - MCQ: 25/40 - SQL Easy: 10/10 - Python Easy: 10/10 - SQL
Medium: 0/20 - Python Medium: 5.6/20

**Diagnosis:** Strong basic performance but difficulty combining
concepts.

**Strategy:** Train the progression:

``` text
Easy
→ Easy + JOIN
→ JOIN + GROUP BY
→ GROUP BY + HAVING
→ Subquery
→ CTE
→ Window Function
→ Real-World Multi-Step Problem
```

Focus on SQL JOIN + aggregation, subqueries, CTEs, window functions,
ranking, and multi-step Pandas problems.

------------------------------------------------------------------------

### Abubakar Sayyad --- Python Intensive

**Score: 50.0%**

Performance: - MCQ: 30/40 - SQL Easy: 0/10 - Python Easy: 0/10 - SQL
Medium: 20/20 - Python Medium: 0/20

**Diagnosis:** Strong SQL Medium capability but a major Python
implementation gap.

**Strategy:** Use SQL knowledge as the bridge to Python/Pandas.

  SQL          Python/Pandas
  ------------ ------------------------------
  WHERE        Boolean filtering
  GROUP BY     `groupby()`
  SUM          `.sum()`
  COUNT        `.count()` / `.size()`
  ORDER BY     `sort_values()`
  DISTINCT     `unique()`
  CASE WHEN    `np.where()` / `np.select()`
  JOIN         `merge()`
  ROW_NUMBER   Ranking / sorting + grouping

Give the same business problem in SQL and then ask the trainee to solve
the equivalent problem in Pandas.

------------------------------------------------------------------------

### Mageshwaran D.R --- Borderline / Quick Win

**Score: 64.2%**

The trainee is only **0.8 marks below 65%**.

Performance: - MCQ: 35/40 - SQL Easy: 0/10 - Python Easy: 4.8/10 - SQL
Medium: 20/20 - Python Medium: 4.4/20

**Diagnosis:** Strong theoretical knowledge and SQL Medium performance.
Main opportunity is easy-level scoring and Python implementation.

**Strategy:** Do not repeat the full syllabus.

Target: - SQL SELECT, WHERE, ORDER BY, DISTINCT - Aggregations and GROUP
BY - Basic JOIN - Python loops, lists, dictionaries, functions - Basic
Pandas

This should be treated as a **targeted scoring recovery**.

------------------------------------------------------------------------

### Chaitanya Bhamere --- Medium SQL/Python Recovery

**Score: 50.3%**

Performance: - MCQ: 29/40 - SQL Easy: 10/10 - Python Easy: 8/10 - SQL
Medium: 0/20 - Python Medium: 3.3/20

**Diagnosis:** Easy problems are manageable, but multi-concept problems
are difficult.

The clearest signal is:

``` text
SQL Easy   = 10/10
SQL Medium = 0/20
```

**Strategy:** Progressively build medium-level SQL:

``` text
GROUP BY
→ GROUP BY + JOIN
→ JOIN + GROUP BY
→ JOIN + HAVING
→ Subquery
→ CTE
→ Window Function
→ Multiple Concepts
```

For Python:

``` text
Basic Logic
→ Lists
→ Dictionaries
→ Functions
→ Pandas Filtering
→ groupby()
→ Aggregation
→ Multi-Step Pandas Problem
```

------------------------------------------------------------------------

## 4. Recommended Training Batches

### Batch A --- Foundation Recovery

**Trainee:** Sreeja

Focus: \> Python + SQL fundamentals + problem-solving methodology

### Batch B --- Medium Problem Recovery

**Trainees:** Chaithrika, Chaitanya

Focus: \> Easy → Medium transition

### Batch C --- Targeted Recovery

**Trainees:** Abubakar, Mageshwaran

-   Abubakar → Python/Pandas intensive
-   Mageshwaran → Targeted scoring correction

------------------------------------------------------------------------

## 5. Problem-Solving Framework

Teach every trainee to ask:

1.  What is the question asking?
2.  What should the final output look like?
3.  What is the input?
4.  What operation is required?
5.  Which functionality solves it?
6.  Can I solve a smaller version first?
7.  Can I validate the result?

The objective is to move from:

> "I understand the concept"

to:

> "I can solve the problem independently under time pressure."

------------------------------------------------------------------------

## 6. Function Selection Cheat Sheet

### SQL

  Problem                       Think About
  ----------------------------- ---------------------------
  Filter records                `WHERE`
  Unique values                 `DISTINCT`
  Total                         `SUM()`
  Average                       `AVG()`
  Number of records             `COUNT()`
  Create groups                 `GROUP BY`
  Filter groups                 `HAVING`
  Combine tables                `JOIN`
  Highest/lowest                `MAX()` / `MIN()`
  Top N per group               `ROW_NUMBER()` / `RANK()`
  Previous/next                 `LAG()` / `LEAD()`
  Compare within group          Window Function
  Complex intermediate result   CTE / Subquery

### Pandas

  Problem               Think About
  --------------------- ----------------------
  Select columns        `df[]`
  Filter rows           `loc`
  Unique values         `unique()`
  Count                 `count()` / `size()`
  Group data            `groupby()`
  Total                 `sum()`
  Average               `mean()`
  Sort                  `sort_values()`
  Join                  `merge()`
  Create column         Assignment
  Conditional column    `np.where()`
  Multiple conditions   `np.select()`
  Ranking               `rank()`
  Remove duplicates     `drop_duplicates()`

------------------------------------------------------------------------

## 7. Three-Mock Recovery Strategy

### Mock 1 --- Foundation

-   10 MCQs
-   2 SQL Easy
-   2 Python Easy

**Target: 80%+**

### Mock 2 --- Concept Combination

SQL: - JOIN - GROUP BY - HAVING - Subquery

Python: - Lists - Dictionaries - Pandas - groupby - Aggregation

**Target: 70%+**

### Mock 3 --- Full Exam Simulation

Replicate the actual assessment structure and time pressure.

**Training target: 75%+**

The purpose is to create a safety margin rather than preparing only to
reach the minimum passing score.

------------------------------------------------------------------------

## 8. Time Management

Suggested time-boxing:

  Question Type      Suggested Time
  ---------------- ----------------
  SQL Easy             3--5 minutes
  Python Easy          4--6 minutes
  Medium Problem      8--12 minutes

### Golden Rule

``` text
Read
 ↓
Attempt
 ↓
If stuck → Skip
 ↓
Solve easier problem
 ↓
Return later
```

One difficult question should not consume the time needed to solve
several easier questions.

------------------------------------------------------------------------

## 9. Error Classification

After every mock, classify mistakes instead of simply recording "Wrong
Answer".

  Code   Error Type         Meaning
  ------ ------------------ ----------------------------------------------
  K      Knowledge Gap      Concept not understood
  L      Logic Gap          Concept understood but solution logic failed
  S      Syntax Error       Coding/syntax mistake
  T      Time Issue         Could not complete within time
  Q      Question Misread   Requirement misunderstood
  D      Debugging Issue    Could not identify/fix error

This distinction is important because each error type requires a
different remediation approach.

------------------------------------------------------------------------

## 10. Recommended 7-Day Recovery Program

### Day 1 --- Diagnostic + Fundamentals

-   Analyze failed questions
-   Identify error type
-   SQL fundamentals
-   Python fundamentals

### Day 2 --- SQL Scoring

-   SELECT
-   WHERE
-   GROUP BY
-   HAVING
-   JOIN

**Practice: 20 problems**

### Day 3 --- Python Scoring

-   Lists
-   Dictionaries
-   Loops
-   Functions
-   Basic Pandas

**Practice: 20 problems**

### Day 4 --- Medium SQL

-   JOIN + GROUP BY
-   HAVING
-   Subqueries
-   CTE
-   Window Functions

**Practice: 10 problems**

### Day 5 --- Medium Python

-   Pandas
-   Filtering
-   groupby
-   Aggregation
-   Sorting
-   merge
-   Multi-step problems

**Practice: 10 problems**

### Day 6 --- Timed Mock

Conduct a complete exam simulation.

Analyze every mistake using:

``` text
K = Knowledge
L = Logic
S = Syntax
T = Time
Q = Question interpretation
D = Debugging
```

### Day 7 --- Personalized Remediation

Give each trainee only the topics where they lost marks.

------------------------------------------------------------------------

## 11. Trainer Time Allocation

Recommended recovery-phase allocation:

``` text
70% → Hands-on problem solving
20% → Error analysis
10% → Theory revision
```

The key objective is **application**, not simply knowledge retention.

------------------------------------------------------------------------

## 12. Priority Matrix

  Trainee                Primary Issue         Intervention
  ---------------------- --------------------- --------------------------
  Sreeja Thanuku         Foundation + Coding   Intensive foundation
  Chaithrika Dommaraju   Medium SQL/Python     Easy → Medium transition
  Abubakar Sayyad        Python                Python/Pandas intensive
  Mageshwaran D.R        Small scoring gap     Targeted correction
  Chaitanya Bhamere      Medium SQL/Python     Multi-concept practice

------------------------------------------------------------------------

## 13. Final Trainer Strategy

The five trainees should **not** be treated as one homogeneous failure
group.

``` text
Sreeja
→ Foundation Recovery

Chaithrika
→ Medium Problem Solving

Abubakar
→ Python/Pandas Intensive

Mageshwaran
→ Targeted Scoring Recovery

Chaitanya
→ Medium SQL + Python
```

### Overall Recovery Model

``` text
DIAGNOSE
   ↓
CLASSIFY ERROR
   ↓
ASSIGN TRAINEE TO INTERVENTION
   ↓
PRACTICE TARGETED PROBLEMS
   ↓
TIMED MINI MOCK
   ↓
ANALYZE ERRORS
   ↓
REMEDIATE
   ↓
FULL MOCK
   ↓
FINAL REVISION
```

## Core Principle

> **Don't teach more. Teach exactly what each trainee is failing to
> apply.**

The assessment indicates that the next improvement should focus
primarily on **targeted coding practice, medium-level problem solving,
error analysis, and timed execution**, rather than repeating the
complete syllabus.

### Recommended Success Target

``` text
Minimum Target → 65%
Training Target → 75%+
```

This creates a practical safety margin for exam-day pressure, unfamiliar
questions, syntax errors, and time constraints.
