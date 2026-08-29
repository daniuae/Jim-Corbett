# 🐍 Python / Pandas Problem-Solving Framework

## Data Engineering Problem Breakdown Sheet

> **Don't start coding immediately.**
>
> First break the business problem into **WHAT → FROM WHERE → HOW → OUTPUT**.

---

# 1. The 7-Step Python Problem Breakdown Framework

Use this framework before writing any Pandas code.

| Step                   | Question to Ask                         | What to Identify                             |
| ---------------------- | --------------------------------------- | -------------------------------------------- |
| **1. UNDERSTAND**      | What is the business asking?            | Business requirement                         |
| **2. IDENTIFY INPUT**  | What data do I have?                    | DataFrame, columns, data types               |
| **3. IDENTIFY OUTPUT** | What should I produce?                  | Required columns / result                    |
| **4. BREAK DOWN**      | What operations are required?           | Filter, GroupBy, Merge, Calculate, Transform |
| **5. BUILD**           | What Pandas operations solve each step? | Pandas functions                             |
| **6. VALIDATE**        | Is my result correct?                   | Row counts, values, edge cases               |
| **7. OPTIMIZE**        | Can I make it cleaner/better?           | Reusability, performance, maintainability    |

---

# 2. The Core Mental Model

Whenever you receive a Pandas problem, convert:

```text
BUSINESS QUESTION
       ↓
WHAT DATA DO I NEED?
       ↓
WHAT TRANSFORMATION?
       ↓
WHAT FILTER?
       ↓
WHAT GROUPING?
       ↓
WHAT CALCULATION?
       ↓
WHAT OUTPUT?
```

Think of Pandas as a sequence of **data transformations**.

```text
INPUT
  ↓
FILTER
  ↓
TRANSFORM
  ↓
GROUP
  ↓
AGGREGATE
  ↓
MERGE
  ↓
CALCULATE
  ↓
OUTPUT
```

---

# 3. The WHAT → WHERE → HOW → OUTPUT Framework

This is the quickest approach during coding challenges.

| Question    | Meaning                                         | Example                                  |
| ----------- | ----------------------------------------------- | ---------------------------------------- |
| **WHAT?**   | What does the problem ask?                      | Delivery Rate                            |
| **WHERE?**  | Which columns contain the required information? | `CustomerID`, `OrderDate`, `OrderStatus` |
| **HOW?**    | What operations are needed?                     | GroupBy + Count + Merge + Calculation    |
| **OUTPUT?** | What should the final result contain?           | CustomerID, Month, Delivery Rate         |

### Example

**Problem:**

> Find monthly delivery rate for every customer.

Break it down:

```text
WHAT?
→ Delivery Rate

WHERE?
→ CustomerID
→ OrderDate
→ OrderStatus

HOW?
→ Extract Month
→ Group by Customer + Month
→ Count Total Orders
→ Filter Delivered
→ Count Delivered Orders
→ Merge results
→ Calculate Rate

OUTPUT?
→ CustomerID
→ Month
→ Delivery Rate
```

---

# 4. Identify the DataFrame First

Before solving the problem, understand your data.

Ask:

### What is the DataFrame?

```python
df
```

### What are the columns?

```python
df.columns
```

### What are the data types?

```python
df.dtypes
```

### How many rows?

```python
df.shape
```

### What does the data look like?

```python
df.head()
```

### What are the unique values?

```python
df["OrderStatus"].unique()
```

---

# 5. Identify the Relevant Columns

Don't use every column.

Identify only the columns required for the problem.

For the e-commerce problem:

```text
CustomerID
Category
OrderDate
OrderStatus
```

Create a mental mapping:

| Business Requirement | Data Column   |
| -------------------- | ------------- |
| Customer             | `CustomerID`  |
| Product category     | `Category`    |
| Order month          | `OrderDate`   |
| Delivery status      | `OrderStatus` |
| Return status        | `OrderStatus` |

---

# 6. Identify the Operation Type

Most Pandas problems can be broken into a small number of operations.

| Requirement           | Pandas Operation                  |
| --------------------- | --------------------------------- |
| Select columns        | `df[[]]`                          |
| Filter rows           | `df[condition]`                   |
| Create column         | `df["new"] = ...`                 |
| Convert data          | `.astype()`                       |
| Replace values        | `.replace()`                      |
| Handle missing values | `.fillna()`                       |
| Remove duplicates     | `.drop_duplicates()`              |
| Sort                  | `.sort_values()`                  |
| Count records         | `.size()` / `.count()`            |
| Group data            | `.groupby()`                      |
| Aggregate             | `.sum()` / `.mean()` / `.count()` |
| Reshape categories    | `pd.crosstab()`                   |
| Combine DataFrames    | `.merge()`                        |
| Combine rows          | `pd.concat()`                     |
| Calculate KPI         | Vectorized calculation            |
| Rename columns        | `.rename()`                       |
| Reset index           | `.reset_index()`                  |

---

# 7. Operation Identification Trick

Look for **keywords in the problem statement**.

| Problem Keyword    | Think                       |
| ------------------ | --------------------------- |
| Find               | Filter                      |
| Only               | Filter                      |
| Where              | Boolean condition           |
| For each           | `groupby()`                 |
| Per customer       | `groupby("CustomerID")`     |
| Per month          | Extract month + `groupby()` |
| Count              | `.size()` / `.count()`      |
| Total              | `.sum()`                    |
| Average            | `.mean()`                   |
| Highest            | `.max()` / sort             |
| Lowest             | `.min()` / sort             |
| Percentage         | Calculation                 |
| Rate               | Numerator / Denominator     |
| Flag               | Boolean → integer           |
| Status by category | `crosstab()`                |
| Combine results    | `merge()`                   |
| Missing            | `.fillna()`                 |
| Create column      | Transformation              |
| Compare            | Boolean condition           |

---

# 8. The Pandas Decision Tree

When you read a question, ask:

```text
Does the problem require selecting specific rows?
             │
             ├── YES → FILTER
             │
             ↓
Does it ask "for each" customer/category/month?
             │
             ├── YES → GROUPBY
             │
             ↓
Does it ask for total/count/average?
             │
             ├── YES → AGGREGATION
             │
             ↓
Does it require a new calculated column?
             │
             ├── YES → TRANSFORMATION
             │
             ↓
Does it require two separate results?
             │
             ├── YES → MERGE
             │
             ↓
Does it compare categories/statuses?
             │
             ├── YES → CROSSTAB / PIVOT
             │
             ↓
Does it require a percentage/rate?
             │
             ├── YES → KPI CALCULATION
```

---

# 9. Problem Breakdown Template

Use this template for every coding problem.

```text
==================================================
PYTHON / PANDAS PROBLEM BREAKDOWN
==================================================

1. BUSINESS REQUIREMENT
--------------------------------
What is the problem asking?

→


2. INPUT
--------------------------------
What DataFrame/data do I have?

→


3. RELEVANT COLUMNS
--------------------------------
Which columns are required?

→


4. OUTPUT
--------------------------------
What should the final result contain?

→


5. FILTER
--------------------------------
Do I need to filter rows?

Condition:

→


6. TRANSFORMATION
--------------------------------
Do I need to create/modify a column?

Column:

→


7. GROUPING
--------------------------------
Do I need "for each" analysis?

Group By:

→


8. AGGREGATION
--------------------------------
What calculation is required?

Count / Sum / Mean / Min / Max:

→


9. MERGE / JOIN
--------------------------------
Do I need to combine multiple results?

Join Keys:

→


10. KPI / CALCULATION
--------------------------------
What formula is required?

→


11. EDGE CASES
--------------------------------
What can go wrong?

→


12. VALIDATION
--------------------------------
How will I verify the answer?

→


13. FINAL OUTPUT
--------------------------------
Required columns:

→
```

---

# 10. Worked Example — Monthly Delivery Rate

## Business Requirement

> Find the delivery rate for every customer for every month.

---

## Step 1 — WHAT?

```text
Delivery Rate
```

Formula:

```text
Delivered Orders
---------------- × 100
Total Orders
```

---

## Step 2 — WHERE?

Required columns:

```text
CustomerID
OrderDate
OrderStatus
```

---

## Step 3 — WHAT IS THE GRAIN?

This is one of the most important questions.

Ask:

> **At what level should the result be produced?**

Answer:

```text
Customer + Month
```

Therefore:

```python
groupby(["CustomerID", "Month"])
```

---

# 11. Determine the Data Grain

Always identify the **grain** before using `groupby()`.

| Problem                   | Grain             |
| ------------------------- | ----------------- |
| Total sales               | Entire dataset    |
| Sales by customer         | Customer          |
| Sales by category         | Category          |
| Sales by customer/month   | Customer + Month  |
| Orders by category/status | Category + Status |
| Returns by customer       | Customer          |

### Golden Rule

> **"For every X" usually tells you the GroupBy columns.**

Example:

> For every customer and month

means:

```python
groupby(["CustomerID", "Month"])
```

---

# 12. Step 4 — Create Required Features

The problem requires monthly analysis.

Input:

```text
2025-01-10
2025-01-15
```

Required:

```text
2025-01
2025-01
```

Therefore:

```python
temp["Month"] = temp["OrderDate"].str[:7]
```

Mental model:

```text
OrderDate
   ↓
Extract Month
   ↓
Month
```

---

# 13. Step 5 — Find the Denominator

For a rate or percentage, identify the **denominator first**.

Delivery Rate:

```text
Delivered Orders
-----------------
Total Orders
```

Therefore:

```text
Denominator = Total Orders
Numerator   = Delivered Orders
```

Total orders:

```python
temp.groupby(["CustomerID", "Month"]).size()
```

---

# 14. Step 6 — Find the Numerator

Now identify the condition:

```text
OrderStatus = Delivered
```

Therefore:

```python
temp[temp["OrderStatus"] == "Delivered"]
```

Then group:

```python
.groupby(["CustomerID", "Month"])
.size()
```

Mental model:

```text
All Orders
    │
    ├── Delivered
    │
    └── Not Delivered
```

---

# 15. Step 7 — Why Do We Need MERGE?

We now have two separate results.

### Result 1

```text
CustomerID
Month
TotalOrders
```

### Result 2

```text
CustomerID
Month
DeliveredOrders
```

We need:

```text
CustomerID
Month
TotalOrders
DeliveredOrders
```

Therefore:

> **MERGE**

```python
total_orders.merge(
    delivered_orders,
    on=["CustomerID", "Month"],
    how="left"
)
```

---

# 16. Step 8 — Handle Missing Values

A customer may have:

```text
TotalOrders = 5
DeliveredOrders = NaN
```

What does this mean?

No delivered orders were found.

Therefore:

```text
NaN → 0
```

Use:

```python
.fillna(0)
```

Then:

```python
.astype(int)
```

---

# 17. Step 9 — Calculate the KPI

Now everything required is available.

```python
Delivery Rate =
DeliveredOrders / TotalOrders × 100
```

Pandas:

```python
result["Delivery Rate"] = (
    result["DeliveredOrders"]
    / result["TotalOrders"]
    * 100
)
```

---

# 18. Step 10 — Return Only Required Columns

The business does not require all intermediate columns.

Final output:

```text
CustomerID
Month
Delivery Rate
```

Therefore:

```python
return result[
    ["CustomerID", "Month", "Delivery Rate"]
]
```

---

# 19. Complete Problem Map

The entire problem can now be represented as:

```text
BUSINESS REQUIREMENT
        │
        ▼
Delivery Rate by Customer + Month
        │
        ▼
IDENTIFY COLUMNS
        │
        ├── CustomerID
        ├── OrderDate
        └── OrderStatus
        │
        ▼
CREATE MONTH
        │
        ▼
GROUP BY
CustomerID + Month
        │
        ├───────────────┐
        ▼               ▼
 Total Orders      Delivered Orders
        │               │
        └───────┬───────┘
                ▼
              MERGE
                │
                ▼
          HANDLE NaN
                │
                ▼
         CALCULATE RATE
                │
                ▼
          SELECT OUTPUT
```

---

# 20. Example — Return Flag

## Business Requirement

> Create a binary column where Returned = 1 and everything else = 0.

### Breakdown

| Question        | Answer                      |
| --------------- | --------------------------- |
| What?           | Return flag                 |
| Input column?   | `OrderStatus`               |
| Condition?      | `OrderStatus == "Returned"` |
| Transformation? | Boolean → Integer           |
| Output column?  | `IsReturned`                |

Solution:

```python
result["IsReturned"] = (
    result["OrderStatus"] == "Returned"
).astype(int)
```

Mental model:

```text
OrderStatus
     ↓
Is it Returned?
     ↓
 ┌───────┬───────┐
 YES     NO
  ↓       ↓
  1       0
```

---

# 21. Example — Frequent Returners

## Business Requirement

> Find customers who return products more than a specified threshold.

### Breakdown

```text
WHAT?
→ Frequent returners

WHERE?
→ CustomerID
→ OrderStatus

FILTER?
→ OrderStatus == Returned

GROUP?
→ CustomerID

COUNT?
→ Number of returns

FILTER RESULT?
→ ReturnCount > threshold

OUTPUT?
→ CustomerID
→ ReturnCount
```

Pandas pipeline:

```text
FILTER
   ↓
GROUPBY
   ↓
SIZE
   ↓
RESET_INDEX
   ↓
FILTER THRESHOLD
```

---

# 22. Example — Category Order Summary

## Business Requirement

> Show order-status counts for each category.

### Breakdown

```text
WHAT?
→ Status counts

GROUP DIMENSION?
→ Category

STATUS DIMENSION?
→ OrderStatus

OPERATION?
→ Crosstab

OUTPUT?
→ Category
→ Delivered
→ Cancelled
→ Returned
```

Think:

```text
Category × Status
```

Therefore:

```python
pd.crosstab(
    df["Category"],
    df["OrderStatus"]
)
```

---

# 23. Why Reindex?

The expected output requires:

```text
Delivered
Cancelled
Returned
```

But the dataset may not contain every status.

For example:

```text
Delivered
Returned
```

There may be no `Cancelled` records.

Therefore, explicitly create the expected structure:

```python
summary = summary.reindex(
    columns=[
        "Delivered",
        "Cancelled",
        "Returned"
    ],
    fill_value=0
)
```

Mental model:

```text
ACTUAL DATA
Delivered | Returned

        ↓

EXPECTED OUTPUT
Delivered | Cancelled | Returned

        ↓

MISSING CATEGORY
Cancelled = 0
```

This is an important **production-data mindset**.

---

# 24. The "Pandas Verb" Method

When reading a problem, translate English into Pandas verbs.

Example:

> Find customers who returned products more than once.

Translate:

```text
Find
 ↓
FILTER

customers
 ↓
GROUPBY CustomerID

returned products
 ↓
FILTER OrderStatus == Returned

more than once
 ↓
COUNT > 1
```

Another example:

> Calculate monthly delivery rate for each customer.

Translate:

```text
monthly
 ↓
CREATE MONTH

for each customer
 ↓
GROUPBY CustomerID

delivery rate
 ↓
COUNT + FILTER + CALCULATION
```

---

# 25. Pandas Problem-Solving Cheat Sheet

| English Requirement     | Pandas Thinking               |
| ----------------------- | ----------------------------- |
| Find records            | Filter                        |
| Only records where      | Boolean filter                |
| For each customer       | GroupBy CustomerID            |
| For each category       | GroupBy Category              |
| For each month          | Extract Month + GroupBy       |
| Number of records       | `size()`                      |
| Total                   | `sum()`                       |
| Average                 | `mean()`                      |
| Percentage              | Numerator / Denominator       |
| Rate                    | Numerator / Denominator × 100 |
| Create flag             | Boolean + `astype(int)`       |
| Combine results         | `merge()`                     |
| Status summary          | `crosstab()`                  |
| Missing values          | `fillna()`                    |
| Fixed output categories | `reindex()`                   |
| Convert index to column | `reset_index()`               |
| Create derived column   | Assignment                    |
| Sort result             | `sort_values()`               |
| Remove duplicates       | `drop_duplicates()`           |

---

# 26. The 5 Questions to Ask Before Coding

When you are under time pressure, ask only these five questions:

### 1️⃣ WHAT?

> What exactly is the business requirement?

### 2️⃣ GRAIN?

> At what level should I produce the result?

```text
Customer?
Category?
Month?
Customer + Month?
```

### 3️⃣ COLUMNS?

> Which columns contain the required information?

### 4️⃣ OPERATIONS?

> Which Pandas operations are required?

```text
Filter?
Transform?
GroupBy?
Aggregate?
Merge?
Crosstab?
Calculate?
```

### 5️⃣ OUTPUT?

> What exact columns should my final DataFrame contain?

---

# 27. The FAST Framework

For coding assessments, use:

## F — Find the Requirement

What is being asked?

## A — Analyze the Data

Which columns and grain are required?

## S — Select Operations

Filter → Transform → Group → Aggregate → Merge → Calculate

## T — Test the Result

Validate values, shape, missing data and edge cases.

```text
F → A → S → T
```

---

# 28. Production Validation Checklist

Before submitting your solution, check:

```text
☐ Did I understand the business requirement?

☐ Did I identify the correct columns?

☐ Did I identify the correct grain?

☐ Did I apply the correct filter?

☐ Did I use the correct GroupBy columns?

☐ Did I choose the correct aggregation?

☐ Did I handle missing values?

☐ Did I avoid modifying the original DataFrame unnecessarily?

☐ Did I use the correct merge keys?

☐ Did I calculate the KPI correctly?

☐ Does the final output contain only required columns?

☐ Did I test edge cases?

☐ Is the solution readable and reusable?
```

---

# 29. Golden Rule

## ❌ Don't think:

> "Which Pandas function should I use?"

## ✅ Think:

> "What transformation does the business requirement require?"

Then translate the transformation into Pandas.

```text
Business Requirement
        ↓
Data Grain
        ↓
Required Columns
        ↓
Transformation
        ↓
Pandas Operations
        ↓
Validation
        ↓
Final DataFrame
```

---

# 🎯 One-Page Memory Sheet

```text
========================================================
       PYTHON / PANDAS PROBLEM APPROACH
========================================================

1. WHAT?
   → Understand the business requirement

2. GRAIN?
   → Customer / Category / Month / Customer + Month

3. COLUMNS?
   → Identify required columns

4. FILTER?
   → df[condition]

5. TRANSFORM?
   → Create derived columns

6. GROUP?
   → groupby()

7. AGGREGATE?
   → size / count / sum / mean / min / max

8. MULTIPLE RESULTS?
   → merge()

9. CATEGORY × STATUS?
   → crosstab()

10. MISSING VALUES?
    → fillna()

11. FIXED OUTPUT?
    → reindex()

12. KPI?
    → Numerator / Denominator × 100

13. OUTPUT?
    → Select required columns

14. VALIDATE?
    → Shape + Values + Edge Cases

15. IMPROVE?
    → Readability + Reusability + Performance

========================================================
MENTAL MODEL
========================================================

BUSINESS QUESTION
       ↓
DATA GRAIN
       ↓
COLUMNS
       ↓
FILTER
       ↓
TRANSFORM
       ↓
GROUPBY
       ↓
AGGREGATE
       ↓
MERGE / CROSSTAB
       ↓
KPI
       ↓
VALIDATE
       ↓
FINAL OUTPUT

========================================================
```

# 🚀 Remember

> **Don't code the problem. Break down the problem first.**

A strong Data Engineer can take a business requirement and convert it into a sequence of simple data transformations.

**Business Problem → Data Problem → Pandas Operations → Validated Result**
