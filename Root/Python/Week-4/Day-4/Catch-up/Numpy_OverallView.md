# NumPy Practical Training

## 5-Session Practical-First Learning Module

---

# Overall Learning Objective

By the end of these five sessions, trainees should be able to:

* Create and inspect NumPy arrays
* Access and extract data
* Perform mathematical and statistical operations
* Filter data using conditions
* Count and locate matching values
* Replace data based on conditions
* Find unique values and frequencies
* Sort data
* Find maximum/minimum positions
* Work with 2-D arrays
* Understand `axis=0` and `axis=1`
* Reshape and flatten arrays
* Transpose arrays
* Stack and combine arrays
* Read an assessment problem and identify the correct NumPy functionality
* Solve practical data-analysis problems without relying on loops unnecessarily

---

# SESSION 1

# Arrays, arange, linspace, Indexing, Slicing and Array Properties

## Session Objective

By the end of this session, trainees should be able to:

* Create NumPy arrays
* Generate sequences
* Create equally spaced values
* Access individual values
* Extract portions of arrays
* Understand:

  * `shape`
  * `size`
  * `ndim`
  * `dtype`

---

# 1. Introduction to NumPy

```python
import numpy as np
```

The most important NumPy object is:

```python
np.ndarray
```

Think of an array as a more powerful numerical version of a Python list.

Python:

```python
marks = [70, 80, 90]
```

NumPy:

```python
marks = np.array([70, 80, 90])
```

---

# 2. Practical 1 — Creating an Array

## Problem

Create a NumPy array containing:

```text
10, 20, 30, 40, 50
```

## Solution

```python
import numpy as np

arr = np.array([10, 20, 30, 40, 50])

print(arr)
```

Output:

```text
[10 20 30 40 50]
```

---

# 3. Practical 2 — Creating an Array from a Variable

```python
marks = [75, 82, 91, 68, 88]

marks_array = np.array(marks)

print(marks_array)
```

### Pattern

```python
np.array(data)
```

Whenever the question says:

> "Convert the given list into a NumPy array"

Think:

```python
np.array()
```

---

# 4. Practical 3 — arange()

## Problem

Generate numbers from 1 to 10.

```python
arr = np.arange(1, 11)

print(arr)
```

Output:

```text
[ 1  2  3  4  5  6  7  8  9 10]
```

### Syntax

```python
np.arange(start, stop, step)
```

Important:

> `stop` is excluded.

---

# 5. Practical 4 — Generate Even Numbers

## Problem

Generate even numbers from 2 to 20.

```python
arr = np.arange(2, 21, 2)

print(arr)
```

Output:

```text
[ 2  4  6  8 10 12 14 16 18 20]
```

### Question clue

If the problem says:

> "Generate numbers with a fixed interval/step"

Think:

```python
np.arange()
```

---

# 6. Practical 5 — arange with Negative Step

```python
arr = np.arange(10, 0, -1)

print(arr)
```

Output:

```text
[10 9 8 7 6 5 4 3 2 1]
```

---

# 7. Practical 6 — linspace()

## Problem

Generate 5 equally spaced values between 0 and 10.

```python
arr = np.linspace(0, 10, 5)

print(arr)
```

Output:

```text
[ 0.   2.5  5.   7.5 10. ]
```

### Syntax

```python
np.linspace(start, stop, number_of_values)
```

Unlike `arange()`, the focus is:

> **How many values do I want?**

---

# 8. arange vs linspace

| Requirement              | Use          |
| ------------------------ | ------------ |
| Specify step             | `arange()`   |
| Specify number of values | `linspace()` |

### Example

> Generate numbers from 0 to 100 with a step of 10.

```python
np.arange(0, 101, 10)
```

### Example

> Generate 11 equally spaced values between 0 and 100.

```python
np.linspace(0, 100, 11)
```

---

# 9. Indexing

```python
arr = np.array([10, 20, 30, 40, 50])
```

Index:

```text
10 → 0
20 → 1
30 → 2
40 → 3
50 → 4
```

Get first value:

```python
print(arr[0])
```

Get third value:

```python
print(arr[2])
```

Get last value:

```python
print(arr[-1])
```

---

# 10. Practical Indexing Exercise

Given:

```python
marks = np.array([72, 85, 91, 64, 78])
```

Find:

1. First mark
2. Third mark
3. Last mark
4. Second-last mark

### Solution

```python
print(marks[0])
print(marks[2])
print(marks[-1])
print(marks[-2])
```

---

# 11. Slicing

Suppose:

```python
arr = np.array([10, 20, 30, 40, 50])
```

First three:

```python
arr[:3]
```

Output:

```text
[10 20 30]
```

From third element:

```python
arr[2:]
```

Output:

```text
[30 40 50]
```

Last two:

```python
arr[-2:]
```

Output:

```text
[40 50]
```

---

# 12. Slicing with Step

```python
arr = np.array([10, 20, 30, 40, 50, 60])
```

Every second element:

```python
arr[::2]
```

Output:

```text
[10 30 50]
```

Reverse:

```python
arr[::-1]
```

Output:

```text
[60 50 40 30 20 10]
```

---

# 13. shape

```python
arr = np.array([10, 20, 30, 40])
```

```python
print(arr.shape)
```

Output:

```text
(4,)
```

Meaning:

> 4 elements in one dimension.

---

# 14. size

```python
print(arr.size)
```

Output:

```text
4
```

`size` = total number of elements.

---

# 15. ndim

```python
print(arr.ndim)
```

Output:

```text
1
```

`ndim` = number of dimensions.

---

# 16. dtype

```python
print(arr.dtype)
```

Example:

```text
int64
```

It tells us the data type stored in the array.

---

# 17. The Four Properties

Always remember:

```text
ndim  → How many dimensions?
shape → Structure/dimensions
size  → How many elements?
dtype → What data type?
```

---

# 18. Session 1 Guided Practical

## Problem

Create an array:

```text
15, 25, 35, 45, 55, 65
```

Display:

* Array
* First element
* Last element
* First three elements
* Last two elements
* Shape
* Size
* Dimensions
* Data type

## Expected approach

```python
import numpy as np

arr = np.array([15, 25, 35, 45, 55, 65])

print(arr)
print(arr[0])
print(arr[-1])
print(arr[:3])
print(arr[-2:])
print(arr.shape)
print(arr.size)
print(arr.ndim)
print(arr.dtype)
```

---

# 19. Session 1 Independent Practicals

### Q1

Create a NumPy array containing:

```text
5, 10, 15, 20, 25, 30
```

Display:

* first element
* last element
* middle elements

---

### Q2

Generate integers from 10 to 50.

---

### Q3

Generate odd numbers from 1 to 25.

---

### Q4

Generate 10 equally spaced values between 0 and 1.

---

### Q5

Given:

```python
sales = np.array([1200, 1500, 900, 2200, 1800])
```

Display:

* first sale
* highest-index-position value
* first three sales
* last two sales
* shape
* size
* ndim

---

# SESSION 2

# Mathematical/Statistical Operations + Boolean Filtering

## Session Objective

Trainees should learn to translate:

```text
total
average
highest
lowest
median
standard deviation
greater than
less than
between
```

into NumPy operations.

---

# 1. Basic Mathematical Operations

```python
arr = np.array([10, 20, 30, 40])
```

Addition:

```python
arr + 5
```

Multiplication:

```python
arr * 2
```

Subtraction:

```python
arr - 5
```

Division:

```python
arr / 2
```

---

# 2. Array-to-Array Operations

```python
a = np.array([10, 20, 30])
b = np.array([1, 2, 3])
```

Addition:

```python
a + b
```

Output:

```text
[11 22 33]
```

Multiplication:

```python
a * b
```

Output:

```text
[10 40 90]
```

---

# 3. Statistical Functions

```python
marks = np.array([70, 80, 90, 60, 85])
```

Total:

```python
np.sum(marks)
```

Average:

```python
np.mean(marks)
```

Highest:

```python
np.max(marks)
```

Lowest:

```python
np.min(marks)
```

Median:

```python
np.median(marks)
```

Standard deviation:

```python
np.std(marks)
```

---

# 4. Question → Function Mapping

| Question says      | Think         |
| ------------------ | ------------- |
| Total              | `np.sum()`    |
| Average            | `np.mean()`   |
| Highest            | `np.max()`    |
| Lowest             | `np.min()`    |
| Median             | `np.median()` |
| Standard deviation | `np.std()`    |

---

# 5. Practical — Student Marks

```python
marks = np.array([72, 85, 91, 65, 78, 88])
```

Find:

* Total
* Average
* Highest
* Lowest

Solution:

```python
print("Total:", np.sum(marks))
print("Average:", np.mean(marks))
print("Highest:", np.max(marks))
print("Lowest:", np.min(marks))
```

---

# 6. Boolean Filtering

Suppose:

```python
marks = np.array([45, 78, 92, 34, 88, 61])
```

Problem:

> Find marks greater than 60.

```python
marks[marks > 60]
```

Output:

```text
[78 92 88 61]
```

This is one of the most important NumPy patterns.

---

# 7. How Boolean Filtering Works

Expression:

```python
marks > 60
```

produces:

```text
False True True False True True
```

NumPy then uses this Boolean array to select matching values.

---

# 8. Filtering Examples

Greater than 80:

```python
marks[marks > 80]
```

Less than 50:

```python
marks[marks < 50]
```

Greater than or equal to 75:

```python
marks[marks >= 75]
```

Less than or equal to 50:

```python
marks[marks <= 50]
```

---

# 9. Multiple Conditions

Problem:

> Find marks between 50 and 80.

```python
marks[(marks >= 50) & (marks <= 80)]
```

For OR:

```python
marks[(marks < 40) | (marks > 90)]
```

Important:

```text
AND → &
OR  → |
```

Do not use:

```python
and
or
```

for NumPy array conditions.

---

# 10. Practical — Salary Analysis

```python
salary = np.array([
    35000, 45000, 55000,
    62000, 48000, 75000
])
```

Find salaries above 50,000:

```python
salary[salary > 50000]
```

Find salaries between 40,000 and 60,000:

```python
salary[(salary >= 40000) & (salary <= 60000)]
```

---

# 11. Session 2 Guided Practical

## Employee Salary Analysis

Given:

```python
salary = np.array([
    28000, 35000, 42000,
    50000, 58000, 62000,
    75000, 90000
])
```

Find:

1. Total salary
2. Average salary
3. Highest salary
4. Lowest salary
5. Salaries above 50,000
6. Salaries below 40,000
7. Salaries between 40,000 and 70,000

---

# 12. Session 2 Independent Practicals

## Q1 — Temperature

```python
temperature = np.array([
    28, 31, 35, 29, 33, 38, 25
])
```

Find:

* average
* maximum
* minimum
* temperatures above 30
* temperatures below 30

---

## Q2 — Sales

```python
sales = np.array([
    1200, 1500, 900,
    2200, 1800, 2750,
    800, 3100
])
```

Find:

* total sales
* average sales
* sales above 2000
* sales below 1000
* sales between 1000 and 2500

---

## Q3 — Marks

```python
marks = np.array([
    45, 67, 89, 32,
    76, 91, 55, 48
])
```

Find:

* average
* highest
* lowest
* marks above 75
* marks below 50
* marks between 50 and 80

---

# SESSION 3

# where, Counting, Replacement, Unique, Sorting, argmax/argmin

## Session Objective

Trainees should learn to solve:

```text
Where?
How many?
Replace?
Distinct?
Frequency?
Sorted?
Which position?
```

---

# 1. np.where()

Use `np.where()` when the question asks:

> At which positions/indices does the condition occur?

Example:

```python
marks = np.array([45, 78, 92, 34, 88, 61])

np.where(marks > 80)
```

Output:

```text
(array([2, 4]),)
```

---

# 2. Values vs Positions

This distinction is extremely important.

### Find values:

```python
marks[marks > 80]
```

Result:

```text
[92 88]
```

### Find positions:

```python
np.where(marks > 80)
```

Result:

```text
[2 4]
```

Remember:

```text
VALUES → Boolean filtering

POSITIONS → np.where()
```

---

# 3. Counting

Problem:

> How many students scored above 80?

Use:

```python
np.sum(marks > 80)
```

Why?

Because:

```text
True = 1
False = 0
```

Therefore:

```python
np.sum([False, False, True, False, True, False])
```

gives:

```text
2
```

---

# 4. Practical — Count Employees

```python
salary = np.array([
    30000, 45000, 60000,
    75000, 42000, 90000
])
```

Count employees earning more than 50,000:

```python
count = np.sum(salary > 50000)

print(count)
```

---

# 5. Replacement

Problem:

> Replace all marks below 40 with 40.

```python
marks = np.array([
    45, 78, 32, 34, 88
])

marks[marks < 40] = 40

print(marks)
```

Output:

```text
[45 78 40 40 88]
```

---

# 6. np.where() for Replacement

Problem:

> Convert marks into Pass/Fail.

```python
marks = np.array([45, 78, 32, 88])

result = np.where(
    marks >= 50,
    "Pass",
    "Fail"
)
```

Output:

```text
['Fail' 'Pass' 'Fail' 'Pass']
```

---

# 7. Sorting

```python
marks = np.array([
    78, 45, 91, 62, 88
])
```

Ascending:

```python
np.sort(marks)
```

Output:

```text
[45 62 78 88 91]
```

Descending:

```python
np.sort(marks)[::-1]
```

---

# 8. Unique Values

Given:

```python
departments = np.array([
    "IT", "HR", "IT",
    "Finance", "HR", "IT"
])
```

Find unique departments:

```python
np.unique(departments)
```

Output:

```text
['Finance' 'HR' 'IT']
```

---

# 9. Frequency Analysis

```python
values, counts = np.unique(
    departments,
    return_counts=True
)
```

Output conceptually:

```text
Finance → 1
HR      → 2
IT      → 3
```

This pattern is extremely useful in practical assessments.

---

# 10. argmax()

Problem:

> Find the position of the highest mark.

```python
marks = np.array([
    72, 91, 85, 95, 78
])

np.argmax(marks)
```

Output:

```text
3
```

Highest value:

```python
np.max(marks)
```

Position:

```python
np.argmax(marks)
```

---

# 11. argmin()

```python
np.argmin(marks)
```

returns the position of the smallest value.

---

# 12. max vs argmax

This is another common assessment mistake.

```python
np.max(arr)
```

means:

> Give me the **value**.

```python
np.argmax(arr)
```

means:

> Give me the **position**.

---

# 13. Session 3 Guided Practical

## Sales Analysis

```python
sales = np.array([
    1200, 2500, 800,
    3200, 1800, 4500,
    900
])
```

Find:

1. Sales greater than 2000
2. Positions of sales greater than 2000
3. Number of sales greater than 2000
4. Highest sale
5. Position of highest sale
6. Lowest sale
7. Position of lowest sale
8. Sorted sales
9. Sales in descending order

---

# 14. Session 3 Independent Practical

## Customer Rating Analysis

```python
ratings = np.array([
    5, 4, 3, 5,
    2, 4, 5, 3,
    5, 4
])
```

Find:

1. Unique ratings
2. Frequency of each rating
3. Number of ratings equal to 5
4. Positions where rating is 5
5. Highest rating
6. Position of highest rating
7. Lowest rating
8. Sorted ratings

---

# SESSION 4

# 2-D Arrays, Axis, Reshape, Flatten, Transpose and Stacking

## Session Objective

This is the session where trainees move from simple arrays to **real-world tabular numerical data**.

---

# 1. 2-D Arrays

Example:

```python
marks = np.array([
    [70, 80, 90],
    [65, 75, 85],
    [88, 92, 95]
])
```

Think:

```text
             Subject
          S1   S2   S3

Student 1 70   80   90
Student 2 65   75   85
Student 3 88   92   95
```

---

# 2. shape

```python
marks.shape
```

Output:

```text
(3, 3)
```

Meaning:

```text
3 rows
3 columns
```

---

# 3. 2-D Indexing

Get first student's first mark:

```python
marks[0, 0]
```

Get second student's third mark:

```python
marks[1, 2]
```

General pattern:

```python
array[row, column]
```

---

# 4. Extract a Row

First row:

```python
marks[0]
```

Second row:

```python
marks[1]
```

Or:

```python
marks[1, :]
```

---

# 5. Extract a Column

First column:

```python
marks[:, 0]
```

Second column:

```python
marks[:, 1]
```

Third column:

```python
marks[:, 2]
```

Remember:

```text
: → all
```

---

# 6. Axis

Suppose:

```python
marks = np.array([
    [70, 80, 90],
    [65, 75, 85],
    [88, 92, 95]
])
```

## axis=1

```python
np.sum(marks, axis=1)
```

Output:

```text
[240 225 275]
```

One result for each row/student.

---

## axis=0

```python
np.sum(marks, axis=0)
```

Output:

```text
[223 247 270]
```

One result for each column/subject.

---

# 7. Golden Rule for axis

```text
Need one result per ROW?
→ axis=1

Need one result per COLUMN?
→ axis=0

Need one result for entire array?
→ no axis
```

---

# 8. Practical Axis Example

## Problem

Find the average mark of each student.

Students are rows.

Therefore:

```python
np.mean(marks, axis=1)
```

---

## Problem

Find average marks for each subject.

Subjects are columns.

Therefore:

```python
np.mean(marks, axis=0)
```

---

# 9. Reshape

Suppose:

```python
arr = np.arange(1, 13)
```

Current:

```text
[1 2 3 4 5 6 7 8 9 10 11 12]
```

Convert to 3 × 4:

```python
arr.reshape(3, 4)
```

Result:

```text
[[ 1  2  3  4]
 [ 5  6  7  8]
 [ 9 10 11 12]]
```

---

# 10. Reshape Rule

Number of elements must remain the same.

For 12 elements:

Valid:

```python
reshape(3, 4)
reshape(2, 6)
reshape(4, 3)
reshape(1, 12)
```

Invalid:

```python
reshape(3, 5)
```

---

# 11. Using -1

```python
arr.reshape(3, -1)
```

NumPy calculates the missing dimension.

For 12 elements:

```text
3 × 4
```

So NumPy determines `4`.

---

# 12. Flatten

Convert:

```text
[[1 2 3]
 [4 5 6]]
```

to:

```text
[1 2 3 4 5 6]
```

Use:

```python
arr.flatten()
```

---

# 13. Transpose

Original:

```text
1 2 3
4 5 6
```

Transpose:

```text
1 4
2 5
3 6
```

Use:

```python
arr.T
```

---

# 14. Stacking

## vstack()

Vertical:

```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

np.vstack((a, b))
```

Result:

```text
[[1 2 3]
 [4 5 6]]
```

---

## hstack()

Horizontal:

```python
np.hstack((a, b))
```

Result:

```text
[1 2 3 4 5 6]
```

---

# 15. concatenate()

```python
np.concatenate((a, b))
```

Combines arrays.

For 2-D arrays, the `axis` determines how they are combined.

---

# 16. Session 4 Guided Practical

## Student Performance Matrix

```python
marks = np.array([
    [78, 85, 90],
    [65, 70, 72],
    [88, 92, 95],
    [55, 60, 58]
])
```

Find:

1. Shape
2. Total marks for each student
3. Average marks for each student
4. Highest mark in each subject
5. Average mark in each subject
6. Overall average
7. First student's marks
8. Second subject's marks

---

# 17. Session 4 Independent Practicals

## Q1 — Monthly Sales

```python
sales = np.array([
    [100, 120, 150],
    [80, 90, 110],
    [200, 180, 220],
    [150, 170, 190]
])
```

Rows = products

Columns = months.

Find:

* total sales for each product
* average sales for each product
* total sales for each month
* average sales for each month
* highest sale
* product/month value of highest sale
* shape

---

## Q2 — Reshape

Create:

```python
arr = np.arange(1, 25)
```

Convert it into:

```text
4 × 6
```

Then:

* flatten it
* transpose it

---

## Q3 — Stacking

Given:

```python
q1 = np.array([100, 200, 300])
q2 = np.array([150, 250, 350])
```

Perform:

* vertical stacking
* horizontal stacking
* concatenation

---

# SESSION 5

# Assessment-Style Problem Solving

## Main Objective

This is the most important session.

Trainees should now stop thinking:

> "Which function did the trainer teach?"

Instead, they should think:

> **"What is the problem asking me to produce?"**

---

# 1. The Five-Step Assessment Method

For every question:

### Step 1 — Identify the data

Is it:

```text
1-D?
2-D?
Numerical?
Categorical?
```

---

### Step 2 — Identify the required output

Does the question ask for:

```text
Value?
Position?
Count?
Filtered values?
Replacement?
Summary?
Reshaped data?
```

---

### Step 3 — Translate keywords

Example:

```text
average → mean()
highest → max()
position → argmax()/where()
count → sum(condition)
unique → unique()
```

---

### Step 4 — Determine axis

For 2-D data:

```text
per row    → axis=1
per column → axis=0
```

---

### Step 5 — Build the solution

Don't write unnecessary loops.

---

# 2. Assessment Problem 1 — Employee Salaries

## Problem

Given:

```python
salary = np.array([
    35000, 42000, 58000,
    62000, 48000, 75000,
    39000
])
```

Perform:

1. Calculate average salary.
2. Find employees earning above 50,000.
3. Count employees earning above 50,000.
4. Find the highest salary.
5. Find the position of the highest salary.

---

## Think Before Coding

Question says:

```text
average
above 50000
count
highest
position
```

Translate:

```text
average → np.mean()
above → filtering
count → np.sum(condition)
highest → np.max()
position → np.argmax()
```

---

# 3. Assessment Problem 2 — Student Marks

```python
marks = np.array([
    45, 78, 92, 34,
    88, 61, 73, 39
])
```

Find:

1. Average marks
2. Marks above 75
3. Number of students scoring above 75
4. Positions of students scoring above 75
5. Highest mark
6. Position of highest mark
7. Replace all marks below 40 with 40

---

# 4. Assessment Problem 3 — Customer Ratings

```python
ratings = np.array([
    5, 4, 3, 5, 2,
    4, 5, 3, 5, 4
])
```

Find:

1. Unique ratings
2. Frequency of each rating
3. Number of 5-star ratings
4. Positions of 5-star ratings
5. Highest rating
6. Lowest rating
7. Sorted ratings

---

# 5. Assessment Problem 4 — Sales Matrix

```python
sales = np.array([
    [1000, 1200, 1500],
    [800, 900, 1100],
    [2000, 1800, 2200],
    [1500, 1700, 1900]
])
```

Rows = products.

Columns = months.

Find:

1. Total sales for each product
2. Average sales for each product
3. Total sales for each month
4. Average sales for each month
5. Highest sale
6. Product row containing highest sale
7. Number of sales above 1500

---

# 6. Assessment Problem 5 — Temperature

```python
temperature = np.array([
    28, 31, 35, 29,
    33, 38, 25, 36
])
```

Find:

1. Average temperature
2. Maximum temperature
3. Minimum temperature
4. Temperatures above 30
5. Number of temperatures above 30
6. Positions where temperature exceeds 30
7. Hottest day's position

---

# 7. Assessment Problem 6 — Transaction Analysis

```python
transactions = np.array([
    1200, 3500, 800,
    4200, 1500, 6000,
    2500, 900
])
```

Find:

1. Total transaction amount
2. Average transaction
3. Transactions above 2000
4. Count transactions above 2000
5. Positions of transactions above 2000
6. Highest transaction
7. Position of highest transaction
8. Sort transactions in descending order

---

# 8. Assessment Problem 7 — Complete 2-D Problem

Given:

```python
marks = np.array([
    [78, 85, 90, 88],
    [65, 70, 72, 68],
    [88, 92, 95, 91],
    [55, 60, 58, 62],
    [90, 85, 88, 94]
])
```

Rows = students.

Columns = subjects.

Find:

1. Shape of the array
2. Total marks for each student
3. Average marks for each student
4. Highest mark for each student
5. Total marks for each subject
6. Average marks for each subject
7. Highest mark in the complete dataset
8. Student index having the highest total
9. Number of marks above 90
10. All marks above 90

---

# 9. Assessment Problem 8 — Data Cleaning

Given:

```python
data = np.array([
    10, 20, np.nan,
    40, np.nan, 60,
    70
])
```

Find:

1. Which values are missing?
2. Number of missing values
3. Average excluding missing values
4. Replace missing values with the average

Useful functions:

```python
np.isnan()
np.sum()
np.nanmean()
```

---

# 10. Assessment Problem 9 — Product Inventory

```python
stock = np.array([
    25, 40, 10, 5,
    60, 15, 8, 50
])
```

Find:

1. Average stock
2. Products with stock below 20
3. Number of products below 20
4. Positions of products below 20
5. Replace stock below 10 with 10
6. Highest stock
7. Position of highest stock
8. Sort stock

---

# 11. Assessment Problem 10 — Mixed Challenge

Given:

```python
sales = np.array([
    [120, 150, 180],
    [90, 110, 130],
    [200, 220, 250],
    [160, 140, 170]
])
```

Rows = salespeople.

Columns = months.

Find:

1. Total sales for every salesperson
2. Average sales for every salesperson
3. Highest monthly sale for every salesperson
4. Total sales for every month
5. Average sales for every month
6. Highest sale overall
7. Number of sales greater than 150
8. All sales greater than 150
9. Reshape the data into 2 × 6
10. Flatten the original data

---

# 12. Assessment Challenge — No Function Hints

This is the **final practical test**.

Do NOT tell trainees which functions to use.

## Problem

A company records the monthly performance of five employees across four months.

```python
performance = np.array([
    [72, 85, 90, 88],
    [65, 70, 75, 68],
    [91, 95, 89, 94],
    [55, 62, 58, 60],
    [80, 85, 82, 88]
])
```

Rows represent employees.

Columns represent months.

### Requirements

1. Display the dimensions of the dataset.
2. Display the number of employees and months.
3. Calculate total performance for each employee.
4. Calculate average performance for each employee.
5. Identify employees whose average performance is greater than 80.
6. Count how many employees have average performance greater than 80.
7. Find the highest performance recorded.
8. Find the lowest performance recorded.
9. Find the position of the highest performance.
10. Find all performance values above 90.
11. Count all performance values above 90.
12. Sort all performance values.
13. Find the unique performance values.
14. Convert the dataset into a 2 × 10 array.
15. Flatten the original array.

---

# 13. Trainer Evaluation Method

Do not evaluate trainees only on whether the final answer is correct.

Evaluate their ability to identify the operation.

For every question, ask:

> **What is the question asking you to find?**

Then ask:

> **Which NumPy operation represents that requirement?**

For example:

### Question

"Find all salaries greater than 50000."

Trainee should say:

```text
This asks for values satisfying a condition.

Therefore:
Boolean filtering.
```

Then:

```python
salary[salary > 50000]
```

---

### Question

"Find the positions where salary is greater than 50000."

Trainee should say:

```text
This asks for positions.

Therefore:
np.where()
```

---

### Question

"How many salaries are greater than 50000?"

Trainee should say:

```text
This asks for a count.

Therefore:
np.sum(condition)
```

---

# 14. The Most Important Assessment Distinction

Teach these three questions together.

Given:

```python
arr = np.array([10, 50, 80, 30, 90])
```

### Question A

Find values greater than 50.

```python
arr[arr > 50]
```

Answer:

```text
[80 90]
```

---

### Question B

Find positions greater than 50.

```python
np.where(arr > 50)
```

Answer:

```text
[2 4]
```

---

### Question C

Count values greater than 50.

```python
np.sum(arr > 50)
```

Answer:

```text
2
```

### Mental Model

```text
WHAT VALUES?
→ filtering

WHERE?
→ np.where()

HOW MANY?
→ np.sum(condition)
```

This single distinction eliminates many assessment mistakes.

---

# 15. Second Important Distinction

Given:

```python
arr = np.array([10, 80, 30, 95, 40])
```

### Highest value

```python
np.max(arr)
```

### Position of highest value

```python
np.argmax(arr)
```

Remember:

```text
MAX   → VALUE
ARGMAX → POSITION
```

Similarly:

```text
MIN   → VALUE
ARGMIN → POSITION
```

---

# 16. Third Important Distinction — axis

Given:

```python
data = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])
```

Question:

> Total for each row.

```python
np.sum(data, axis=1)
```

Question:

> Total for each column.

```python
np.sum(data, axis=0)
```

Question:

> Total of everything.

```python
np.sum(data)
```

---

# 17. Complete NumPy Decision Tree

When solving an assessment problem, ask:

```text
                 START
                   |
                   ↓
             What is required?
                   |
       ┌───────────┼────────────┐
       ↓           ↓            ↓
     CREATE     CALCULATE     SELECT
       |           |            |
       ↓           ↓            ↓
   array/range   sum/mean      condition?
       |           |            |
       |           |       ┌────┴─────┐
       |           |       ↓          ↓
       |           |      YES         NO
       |           |       |          |
       |           |       ↓          ↓
       |           |    filter      where?
       |           |       |          |
       |           |       |       np.where
       |           |
       ↓           ↓
   arange/      axis?
   linspace       |
                  ↓
           ┌──────┴──────┐
           ↓             ↓
         rows          columns
           ↓             ↓
        axis=1         axis=0
```

---

# 18. Complete Keyword → NumPy Map

| Assessment wording             | Think                                |
| ------------------------------ | ------------------------------------ |
| Create array                   | `np.array()`                         |
| Generate range                 | `np.arange()`                        |
| Equally spaced                 | `np.linspace()`                      |
| First value                    | `arr[0]`                             |
| Last value                     | `arr[-1]`                            |
| Extract portion                | slicing                              |
| Dimensions                     | `ndim`                               |
| Structure                      | `shape`                              |
| Number of elements             | `size`                               |
| Data type                      | `dtype`                              |
| Total                          | `np.sum()`                           |
| Average                        | `np.mean()`                          |
| Highest                        | `np.max()`                           |
| Lowest                         | `np.min()`                           |
| Median                         | `np.median()`                        |
| Standard deviation             | `np.std()`                           |
| Values satisfying condition    | Boolean filtering                    |
| Positions satisfying condition | `np.where()`                         |
| Number satisfying condition    | `np.sum(condition)`                  |
| Replace values                 | Boolean assignment                   |
| Conditional labels             | `np.where()`                         |
| Distinct values                | `np.unique()`                        |
| Frequency                      | `np.unique(..., return_counts=True)` |
| Sorted                         | `np.sort()`                          |
| Highest position               | `np.argmax()`                        |
| Lowest position                | `np.argmin()`                        |
| Per row                        | `axis=1`                             |
| Per column                     | `axis=0`                             |
| Change dimensions              | `reshape()`                          |
| Flatten                        | `flatten()`                          |
| Rows → columns                 | `.T`                                 |
| Vertical combination           | `vstack()`                           |
| Horizontal combination         | `hstack()`                           |
| Combine                        | `concatenate()`                      |

---

# 19. Final Trainee Cheat Sheet

```python
import numpy as np

# CREATE
arr = np.array([1, 2, 3])
np.arange(1, 10)
np.linspace(0, 1, 5)

# INSPECT
arr.shape
arr.size
arr.ndim
arr.dtype

# INDEX
arr[0]
arr[-1]

# SLICE
arr[:3]
arr[2:]
arr[-2:]
arr[::2]
arr[::-1]

# CALCULATE
np.sum(arr)
np.mean(arr)
np.max(arr)
np.min(arr)
np.median(arr)
np.std(arr)

# FILTER
arr[arr > 50]
arr[arr < 20]
arr[(arr >= 20) & (arr <= 50)]

# WHERE
np.where(arr > 50)

# COUNT
np.sum(arr > 50)

# REPLACE
arr[arr < 20] = 20

# CONDITIONAL OUTPUT
np.where(arr >= 50, "Pass", "Fail")

# UNIQUE
np.unique(arr)

# FREQUENCY
np.unique(arr, return_counts=True)

# SORT
np.sort(arr)
np.sort(arr)[::-1]

# POSITION
np.argmax(arr)
np.argmin(arr)

# 2-D
arr[row, column]
arr[0]
arr[:, 0]

# AXIS
np.sum(arr, axis=0)
np.sum(arr, axis=1)

# RESHAPE
arr.reshape(3, 4)

# FLATTEN
arr.flatten()

# TRANSPOSE
arr.T

# STACK
np.vstack((a, b))
np.hstack((a, b))
np.concatenate((a, b))
```

---

# 20. Five-Session Progression

## Session 1

### Learn

```text
array
arange
linspace
indexing
slicing
shape
size
ndim
dtype
```

### Trainee should be able to answer:

> "How do I create and inspect numerical data?"

---

## Session 2

### Learn

```text
sum
mean
min
max
median
std
Boolean filtering
multiple conditions
```

### Trainee should be able to answer:

> "How do I calculate and filter data?"

---

## Session 3

### Learn

```text
where
counting
replacement
unique
frequency
sort
argmax
argmin
```

### Trainee should be able to answer:

> "How do I find positions, count, replace, sort and identify special values?"

---

## Session 4

### Learn

```text
2-D arrays
axis
reshape
flatten
transpose
stacking
```

### Trainee should be able to answer:

> "How do I work with tabular/matrix data?"

---

## Session 5

### No new major functions

Instead:

```text
READ
 ↓
IDENTIFY
 ↓
TRANSLATE
 ↓
IMPLEMENT
 ↓
VERIFY
```

### Trainee should be able to answer:

> **"Which NumPy functionality should I use for this problem?"**

---

# Final Teaching Principle

The goal is NOT:

> "Trainee should memorize 30 NumPy functions."

The goal is:

> **Trainee should read a problem and immediately convert its requirements into NumPy operations.**

For example:

```text
"Find all values above 80"
        ↓
Filtering
        ↓
arr[arr > 80]


"Find where values are above 80"
        ↓
Positions
        ↓
np.where(arr > 80)


"Count values above 80"
        ↓
Count condition
        ↓
np.sum(arr > 80)


"Find highest value"
        ↓
Maximum
        ↓
np.max(arr)


"Find position of highest value"
        ↓
Argument maximum
        ↓
np.argmax(arr)


"Calculate total for each student"
        ↓
Rows
        ↓
axis=1


"Calculate total for each subject"
        ↓
Columns
        ↓
axis=0
```

This **question → requirement → NumPy functionality → code pattern** approach should be reinforced in every session.
