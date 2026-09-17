# NumPy Problem-Solving Framework

## How to Identify Which NumPy Function or Technique to Use

> **Core Rule:**
>
> **WHAT → DATA SHAPE → OPERATION → AXIS → FUNCTION → VALIDATE**

The goal is not to memorize 100+ NumPy functions.

The goal is to look at a problem and quickly identify:

> **What does the problem want me to do with the array?**

---

# 1. WHAT — What exactly is the problem asking?

First, identify the action words.

| Problem Statement            | Think About                                |
| ---------------------------- | ------------------------------------------ |
| create an array              | `np.array()`                               |
| generate numbers             | `np.arange()` / `np.linspace()`            |
| create zeros                 | `np.zeros()`                               |
| create ones                  | `np.ones()`                                |
| create random values         | `np.random`                                |
| find shape                   | `.shape`                                   |
| find dimensions              | `.ndim`                                    |
| find number of elements      | `.size`                                    |
| access element               | Indexing                                   |
| extract elements             | Slicing                                    |
| change shape                 | `.reshape()`                               |
| flatten                      | `.flatten()` / `.ravel()`                  |
| transpose                    | `.T` / `np.transpose()`                    |
| combine arrays               | `concatenate`, `stack`, `hstack`, `vstack` |
| split arrays                 | `split`, `hsplit`, `vsplit`                |
| total                        | `np.sum()`                                 |
| average                      | `np.mean()`                                |
| highest                      | `np.max()`                                 |
| lowest                       | `np.min()`                                 |
| position of highest          | `np.argmax()`                              |
| position of lowest           | `np.argmin()`                              |
| standard deviation           | `np.std()`                                 |
| variance                     | `np.var()`                                 |
| find condition               | Boolean indexing                           |
| replace values conditionally | `np.where()`                               |
| find unique values           | `np.unique()`                              |
| count values                 | `np.unique(..., return_counts=True)`       |
| sort                         | `np.sort()`                                |
| sort indices                 | `np.argsort()`                             |
| search value                 | `np.where()` / `np.isin()`                 |
| check condition              | `np.any()` / `np.all()`                    |
| matrix multiplication        | `@` / `np.matmul()`                        |
| element-wise multiplication  | `*`                                        |
| random sample                | `np.random`                                |
| missing numerical values     | `np.isnan()`                               |
| round numbers                | `np.round()`                               |

---

# 2. DATA SHAPE — What kind of array are you working with?

Before choosing a function, identify the array dimensions.

## 1-D Array

```python
arr = np.array([10, 20, 30, 40])
```

Shape:

```text
(4,)
```

---

## 2-D Array

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

Shape:

```text
(2, 3)
```

Meaning:

```text
2 rows
3 columns
```

---

## 3-D Array

Think:

```text
layers × rows × columns
```

Example:

```python
arr.shape
# (2, 3, 4)
```

---

# 3. THE FIRST NUMPY QUESTION

Whenever you see an array problem, ask:

> **"What is the shape of my data?"**

Check:

```python
arr.shape
```

Then:

```python
arr.ndim
```

And:

```python
arr.size
```

### Remember

```text
shape → structure
ndim  → number of dimensions
size  → total number of elements
```

---

# 4. CREATE — How do I create the data?

Look for keywords such as:

* create an array
* generate numbers
* initialize
* create zeros
* create ones
* create identity matrix
* generate random numbers

## Create from Python data

```python
np.array([1, 2, 3, 4])
```

---

## Generate a sequence

> "Generate numbers from 0 to 9"

```python
np.arange(10)
```

---

## Generate numbers with a step

> "Generate even numbers from 0 to 10"

```python
np.arange(0, 11, 2)
```

---

## Generate a fixed number of evenly spaced values

> "Generate 5 equally spaced values between 0 and 1"

```python
np.linspace(0, 1, 5)
```

### Important distinction

```text
arange   → I care about the STEP

linspace → I care about the NUMBER OF VALUES
```

This is an excellent shortcut for trainees.

---

# 5. INITIALIZE — Zeros, Ones, Empty, Identity

## All zeros

```python
np.zeros((3, 4))
```

## All ones

```python
np.ones((3, 4))
```

## Identity matrix

```python
np.eye(3)
```

Mental mapping:

```text
zeros → initialize with 0
ones  → initialize with 1
eye   → identity matrix
```

---

# 6. INDEXING — Which element do I need?

Look for:

* first element
* second element
* last element
* element at position
* row 2
* column 3

Example:

```python
arr[0]
```

For a 2-D array:

```python
arr[1, 2]
```

Mental translation:

```text
arr[row, column]
```

---

# 7. SLICING — Do I need a portion of the array?

Look for:

* first 5 elements
* last 3 elements
* rows 2 to 5
* columns 1 to 3
* every second element

Think:

```python
arr[start:stop:step]
```

Example:

```python
arr[1:5]
```

Every second element:

```python
arr[::2]
```

2-D:

```python
arr[0:2, 1:3]
```

Mental translation:

```text
ROWS first
  ↓
COLUMNS second
```

---

# 8. CONDITION — Do I need to find values based on a condition?

Look for:

* values greater than 50
* values less than 10
* positive values
* negative values
* values equal to 100

Think:

> **Boolean indexing**

Example:

```python
arr[arr > 50]
```

This is one of the most important NumPy techniques.

---

# 9. WHERE — Do I need conditional selection or replacement?

Look for:

* replace values if condition is true
* find positions where condition is true
* if value is greater than X, replace it
* select A otherwise B

Think:

```python
np.where()
```

Example:

```python
np.where(arr > 50, 1, 0)
```

Mental translation:

```text
IF condition
    → value A
ELSE
    → value B
```

---

# 10. FILTERING vs WHERE

This distinction is important.

## Filtering

> "Give me values greater than 50."

```python
arr[arr > 50]
```

Result:

```text
Only matching values
```

---

## Conditional replacement

> "Replace values greater than 50 with 1, otherwise 0."

```python
np.where(arr > 50, 1, 0)
```

Result:

```text
Same number of positions
Different values
```

### Golden Rule

```text
Want matching VALUES?
→ Boolean indexing

Want conditional replacement?
→ np.where()
```

---

# 11. AGGREGATION — Do I need a summary?

Look for:

* total
* average
* maximum
* minimum
* standard deviation
* variance
* count

## Total

```python
np.sum(arr)
```

## Average

```python
np.mean(arr)
```

## Maximum

```python
np.max(arr)
```

## Minimum

```python
np.min(arr)
```

## Standard deviation

```python
np.std(arr)
```

## Variance

```python
np.var(arr)
```

---

# 12. ARGMAX / ARGMIN

This is a very common interview/test question.

Look carefully at the wording.

### "What is the maximum value?"

Use:

```python
np.max(arr)
```

### "Where is the maximum value?"

Use:

```python
np.argmax(arr)
```

Similarly:

```python
np.min(arr)
np.argmin(arr)
```

### Golden Rule

```text
MAX     → VALUE
ARGMAX  → POSITION

MIN     → VALUE
ARGMIN  → POSITION
```

---

# 13. AXIS — The Most Important NumPy Concept

When working with 2-D arrays, ask:

> **"Am I calculating across rows or columns?"**

Example:

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

Shape:

```text
(2, 3)
```

---

## axis=0

Think:

> **Down the rows**

```python
np.sum(arr, axis=0)
```

Result:

```text
[50, 70, 90]
```

You get one result for each column.

---

## axis=1

Think:

> **Across the columns**

```python
np.sum(arr, axis=1)
```

Result:

```text
[60, 150]
```

You get one result for each row.

---

# 14. EASY AXIS RULE

Instead of memorizing:

> axis 0 = columns
> axis 1 = rows

Think:

```text
axis = direction being collapsed
```

For:

```python
np.sum(arr, axis=0)
```

you collapse the row dimension.

For:

```python
np.sum(arr, axis=1)
```

you collapse the column dimension.

### Memory trick

```text
axis=0
↓
collapse DOWN
↓
one result per COLUMN


axis=1
→
collapse ACROSS
→
one result per ROW
```

---

# 15. RESHAPE — Does the problem ask me to change the structure?

Look for:

* convert 1-D to 2-D
* change rows and columns
* reshape
* convert into matrix

Think:

```python
reshape()
```

Example:

```python
arr.reshape(2, 3)
```

### Critical rule

The number of elements must remain the same.

```text
2 × 3 = 6
```

So an array with 6 elements can become:

```text
(2, 3)
(3, 2)
(1, 6)
(6, 1)
```

---

# 16. FLATTEN — Convert to 1-D

Look for:

* flatten
* convert to one-dimensional
* make a single array

Think:

```python
arr.flatten()
```

Example:

```python
arr.flatten()
```

Mental translation:

```text
2-D
 ↓
1-D
```

---

# 17. TRANSPOSE

Look for:

* transpose
* swap rows and columns
* interchange dimensions

Think:

```python
arr.T
```

or:

```python
np.transpose(arr)
```

For a 2-D array:

```text
Rows ↔ Columns
```

---

# 18. SORTING

Look for:

* sort values
* ascending order
* descending order
* sorted array
* position of sorted values

## Sort values

```python
np.sort(arr)
```

## Sort in descending order

```python
np.sort(arr)[::-1]
```

## Get sorting positions

```python
np.argsort(arr)
```

### Golden Rule

```text
sort values
→ np.sort()

sort positions/indices
→ np.argsort()
```

---

# 19. UNIQUE

Look for:

* unique values
* remove duplicates
* distinct values

Think:

```python
np.unique(arr)
```

Example:

```python
np.unique(arr)
```

---

# 20. COUNT UNIQUE VALUES

Problem:

> Find each unique value and how many times it occurs.

Think:

```python
np.unique(
    arr,
    return_counts=True
)
```

Mental translation:

```text
UNIQUE
   +
COUNT
```

---

# 21. FIND POSITIONS

Look for:

* position
* index
* location
* where
* indices where condition is true

Think:

```python
np.where()
```

Example:

```python
np.where(arr > 50)
```

---

# 22. ANY vs ALL

Look carefully at the wording.

## ANY

> "Does at least one value satisfy the condition?"

```python
np.any(arr > 100)
```

Meaning:

```text
ONE OR MORE → True
```

---

## ALL

> "Do all values satisfy the condition?"

```python
np.all(arr > 0)
```

Meaning:

```text
EVERY VALUE → True
```

### Golden Rule

```text
at least one → any()

every value   → all()
```

---

# 23. COMBINING ARRAYS

Look for:

* combine
* merge
* join arrays
* stack
* append rows
* append columns

Think:

```text
concatenate
stack
hstack
vstack
```

## Join along an existing axis

```python
np.concatenate()
```

## Stack arrays

```python
np.stack()
```

## Horizontal

```python
np.hstack()
```

## Vertical

```python
np.vstack()
```

### Mental Model

```text
horizontal → side by side
vertical   → one below another
```

---

# 24. MATRIX OPERATIONS

Look for:

* matrix multiplication
* dot product
* multiply matrices

Be careful:

### Element-wise multiplication

```python
a * b
```

### Matrix multiplication

```python
a @ b
```

or:

```python
np.matmul(a, b)
```

### Golden Rule

```text
*  → element by element

@  → matrix multiplication
```

---

# 25. RANDOM DATA

Look for:

* random numbers
* random integer
* random sample
* random matrix
* simulation

Think:

```python
np.random
```

Examples:

```python
np.random.rand()
```

```python
np.random.randint()
```

```python
np.random.choice()
```

---

# 26. NaN / MISSING VALUES

Look for:

* missing numerical values
* NaN
* check for NaN
* ignore NaN during calculation

Think:

```python
np.isnan()
```

For calculations ignoring NaN:

```python
np.nanmean()
np.nansum()
np.nanmax()
np.nanmin()
```

Mental translation:

```text
NaN exists?
→ isnan()

Calculate while ignoring NaN?
→ nanXXX()
```

---

# 27. NUMPY DECISION TREE

```text
                         NUMPY PROBLEM
                              |
                              v
                       WHAT IS ASKED?
                              |
          +-------------------+-------------------+
          |                   |                   |
       CREATE               ACCESS             CALCULATE
          |                   |                   |
    +-----+-----+       +-----+-----+       +-----+------+
    |     |     |       |           |       |            |
  array arange linspace INDEX     SLICE   SUM/AVG     MAX/MIN
    |     |     |                           COUNT       STD
 zeros ones random
                          
                          
          +--------------------------------------------+
          |
          v
                 CONDITION / FILTER?
                          |
                 +--------+--------+
                 |                 |
              FILTER             REPLACE
                 |                 |
        Boolean indexing       np.where()
        
        
          +--------------------------------------------+
          |
          v
                  CHANGE SHAPE?
                          |
              +-----------+-----------+
              |           |           |
           reshape      flatten    transpose
              
              
          +--------------------------------------------+
          |
          v
                     SORT?
                       |
                +------+------+
                |             |
             values        positions
                |             |
           np.sort()      np.argsort()
           
           
          +--------------------------------------------+
          |
          v
                    UNIQUE?
                       |
                  np.unique()
                  
                  
          +--------------------------------------------+
          |
          v
                 POSITION?
                       |
                  np.argmax()
                  np.argmin()
                  np.where()
                  
                  
          +--------------------------------------------+
          |
          v
                  2-D ARRAY?
                       |
                       v
                     AXIS
                       |
               +-------+-------+
               |               |
            axis=0          axis=1
               |               |
          per column       per row
```

---

# 28. THE 10 GOLDEN NUMPY RULES

## Rule 1

> Need to create an array → `np.array()`

---

## Rule 2

> Need a sequence with a step → `np.arange()`

---

## Rule 3

> Need a fixed number of equally spaced values → `np.linspace()`

---

## Rule 4

> Need to filter values → Boolean indexing

```python
arr[arr > 50]
```

---

## Rule 5

> Need conditional replacement → `np.where()`

```python
np.where(condition, value_if_true, value_if_false)
```

---

## Rule 6

> Need total/average/count → Aggregation functions

```python
np.sum()
np.mean()
np.count_nonzero()
```

---

## Rule 7

> Need the position of maximum/minimum → `argmax()` / `argmin()`

---

## Rule 8

> Need to calculate per row/column → `axis`

```text
axis=0 → one result per column
axis=1 → one result per row
```

---

## Rule 9

> Need to change structure → `reshape()`

---

## Rule 10

> Need to remove duplicates → `np.unique()`

---

# 29. THE 30-SECOND NUMPY PROBLEM SOLVER

Before writing NumPy code, ask:

```text
1. WHAT?
   What exactly is the problem asking?

2. DATA?
   What does the array contain?

3. SHAPE?
   Is it 1-D, 2-D or 3-D?

4. SIZE?
   How many elements are there?

5. OPERATION?
   Create / Access / Filter / Calculate / Transform?

6. CONDITION?
   Is there a condition?

7. AXIS?
   If 2-D, am I working per row or per column?

8. OUTPUT?
   Do I need values, positions, shape or a boolean?

9. FUNCTION?
   Which NumPy function maps to the requirement?

10. VALIDATE?
    Is the shape correct?
    Is the result the expected size?
    Did I apply the correct axis?
```

---

# 30. COMPLETE EXAMPLE

## Problem

> Given a 2-D array of student marks, find the average mark for each student and identify the student with the highest average.

---

## Step 1 — WHAT?

We need:

```text
Average
Highest average
Student position
```

---

## Step 2 — DATA SHAPE

Suppose:

```python
marks.shape
```

returns:

```text
(5, 4)
```

Meaning:

```text
5 students
4 subjects
```

---

## Step 3 — AVERAGE

We want the average **for each student**.

Student = row.

Therefore:

```python
np.mean(marks, axis=1)
```

Why `axis=1`?

Because we collapse the subject columns.

Result:

```text
Student 1 → average
Student 2 → average
Student 3 → average
Student 4 → average
Student 5 → average
```

---

## Step 4 — HIGHEST AVERAGE

We need the position of the highest average.

Therefore:

```python
np.argmax(student_average)
```

Not:

```python
np.max(student_average)
```

because we need the **student position**, not just the value.

---

## Function Chain

```text
2-D Array
   ↓
Identify Shape
   ↓
Average
   ↓
np.mean()
   ↓
Per Student
   ↓
axis=1
   ↓
Highest Position
   ↓
np.argmax()
```

---

# 31. ANOTHER EXAMPLE

## Problem

> Replace all marks below 40 with 0 and marks 40 or above with 1.

### Identify the requirement

```text
Condition
   ↓
Conditional replacement
   ↓
np.where()
```

Solution:

```python
result = np.where(marks < 40, 0, 1)
```

Function chain:

```text
Condition
   ↓
np.where()
   ↓
True  → 0
False → 1
```

---

# 32. ANOTHER EXAMPLE

## Problem

> Find the three largest values in an array.

Identify:

```text
largest
   ↓
sort
   ↓
descending
   ↓
take first 3
```

Possible approach:

```python
result = np.sort(arr)[-3:][::-1]
```

Function chain:

```text
SORT
 ↓
LAST 3
 ↓
REVERSE
```

---

# 33. NUMPY FUNCTION IDENTIFICATION MATRIX

| Problem Pattern                  | NumPy Function / Technique           |
| -------------------------------- | ------------------------------------ |
| Create array                     | `np.array()`                         |
| Generate sequence                | `np.arange()`                        |
| Fixed number of intervals        | `np.linspace()`                      |
| Initialize zeros                 | `np.zeros()`                         |
| Initialize ones                  | `np.ones()`                          |
| Identity matrix                  | `np.eye()`                           |
| Random values                    | `np.random`                          |
| Check structure                  | `.shape`                             |
| Number of dimensions             | `.ndim`                              |
| Number of elements               | `.size`                              |
| Access element                   | Indexing                             |
| Extract range                    | Slicing                              |
| Filter values                    | Boolean indexing                     |
| Conditional replacement          | `np.where()`                         |
| Total                            | `np.sum()`                           |
| Average                          | `np.mean()`                          |
| Count                            | `np.count_nonzero()`                 |
| Maximum value                    | `np.max()`                           |
| Minimum value                    | `np.min()`                           |
| Position of maximum              | `np.argmax()`                        |
| Position of minimum              | `np.argmin()`                        |
| Standard deviation               | `np.std()`                           |
| Variance                         | `np.var()`                           |
| Unique values                    | `np.unique()`                        |
| Count unique values              | `np.unique(..., return_counts=True)` |
| Sort values                      | `np.sort()`                          |
| Sort positions                   | `np.argsort()`                       |
| Find positions                   | `np.where()`                         |
| At least one satisfies condition | `np.any()`                           |
| Every value satisfies condition  | `np.all()`                           |
| Change shape                     | `.reshape()`                         |
| Flatten                          | `.flatten()`                         |
| Transpose                        | `.T` / `np.transpose()`              |
| Combine arrays                   | `np.concatenate()`                   |
| Stack arrays                     | `np.stack()`                         |
| Horizontal stack                 | `np.hstack()`                        |
| Vertical stack                   | `np.vstack()`                        |
| Matrix multiplication            | `@` / `np.matmul()`                  |
| Element-wise multiplication      | `*`                                  |
| Check NaN                        | `np.isnan()`                         |
| Average ignoring NaN             | `np.nanmean()`                       |
| Sum ignoring NaN                 | `np.nansum()`                        |
| Round values                     | `np.round()`                         |

---

# 34. NUMPY MINDSET

Don't think:

> "Which NumPy function do I remember?"

Instead think:

> **"What operation does the problem require?"**

Then translate:

```text
Problem
   ↓
Operation
   ↓
NumPy Function
```

Example:

```text
"Find the average marks of each student"
        ↓
Aggregation
        ↓
Mean
        ↓
np.mean()
        ↓
Per student
        ↓
axis=1
```

Another:

```text
"Find where marks are greater than 80"
        ↓
Condition
        ↓
Find positions
        ↓
np.where()
```

Another:

```text
"Replace marks below 40 with 0"
        ↓
Condition + replacement
        ↓
np.where()
```

Another:

```text
"Find the student with highest marks"
        ↓
Maximum position
        ↓
np.argmax()
```

---

# 35. FINAL MASTER FORMULA

Whenever you receive a NumPy problem:

```text
                 READ THE PROBLEM
                        ↓
                    WHAT?
                        ↓
                    DATA
                        ↓
                    SHAPE
                        ↓
                  OPERATION
                        ↓
                   CONDITION?
                        ↓
                     AXIS?
                        ↓
                VALUE or POSITION?
                        ↓
                  FUNCTION
                        ↓
                  WRITE CODE
                        ↓
                   VALIDATE
```

## 🏆 One-Line Formula

> **WHAT → DATA → SHAPE → OPERATION → CONDITION → AXIS → FUNCTION → VALIDATE**

---

# SQL vs NumPy — Same Thinking Pattern

The beautiful part is that the **problem-solving framework is almost identical**.

| SQL             | NumPy                             |
| --------------- | --------------------------------- |
| WHAT            | WHAT                              |
| Output Grain    | Data Shape                        |
| Tables          | Arrays                            |
| JOIN            | Combine/Stack                     |
| WHERE           | Boolean Filtering                 |
| HAVING          | Conditional aggregation/filtering |
| GROUP BY        | Aggregation + Axis                |
| Window Function | Array operations along dimensions |
| SUM/AVG/COUNT   | `np.sum/mean/count`               |
| ORDER BY        | `np.sort()`                       |
| RANK            | Sorting/argsort-based logic       |
| Subquery        | Intermediate array/result         |
| Validate grain  | Validate shape                    |

## The ultimate learning principle

```text
              PROBLEM STATEMENT
                     ↓
              UNDERSTAND THE DATA
                     ↓
             IDENTIFY THE OPERATION
                     ↓
              IDENTIFY THE FUNCTION
                     ↓
                 WRITE CODE
                     ↓
                  VALIDATE
```

### SQL

> **WHAT → GRAIN → TABLE → JOIN → FILTER → CALCULATE → GROUP/WINDOW → VALIDATE**

### NumPy

> **WHAT → DATA → SHAPE → OPERATION → CONDITION → AXIS → FUNCTION → VALIDATE**

**Don't memorize the solution. Learn to identify the operation.**
