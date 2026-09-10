# NumPy Basics — Practical-Oriented Tutorial

## 1. What is NumPy?

**NumPy = Numerical Python**

It is mainly used for:

* Working with numerical data
* Creating arrays
* Performing mathematical calculations
* Filtering data
* Sorting data
* Finding statistics
* Reshaping data
* Performing matrix operations
* Efficient numerical processing

The most important NumPy object is:

```python
numpy.ndarray
```

Import NumPy:

```python
import numpy as np
```

---

# 2. The Most Important Idea

When solving a NumPy practical, first identify the **operation**.

| Problem requirement           | NumPy functionality             |
| ----------------------------- | ------------------------------- |
| Create numerical data         | `np.array()`                    |
| Generate sequence             | `np.arange()`                   |
| Generate evenly spaced values | `np.linspace()`                 |
| Create zeros                  | `np.zeros()`                    |
| Create ones                   | `np.ones()`                     |
| Create random numbers         | `np.random`                     |
| Find dimensions               | `.ndim`                         |
| Find shape                    | `.shape`                        |
| Find number of elements       | `.size`                         |
| Find data type                | `.dtype`                        |
| Change data type              | `.astype()`                     |
| Access element                | Indexing                        |
| Access multiple elements      | Slicing                         |
| Filter values                 | Boolean indexing                |
| Change array shape            | `.reshape()`                    |
| Flatten array                 | `.flatten()`                    |
| Transpose                     | `.T`                            |
| Sort                          | `np.sort()`                     |
| Unique values                 | `np.unique()`                   |
| Minimum                       | `np.min()`                      |
| Maximum                       | `np.max()`                      |
| Sum                           | `np.sum()`                      |
| Average                       | `np.mean()`                     |
| Median                        | `np.median()`                   |
| Standard deviation            | `np.std()`                      |
| Count condition               | `np.sum(condition)`             |
| Find positions                | `np.where()`                    |
| Replace values                | Boolean indexing / `np.where()` |
| Combine arrays                | `np.concatenate()`              |
| Stack arrays                  | `np.vstack()`, `np.hstack()`    |
| Matrix multiplication         | `@` / `np.matmul()`             |

---

# 3. Creating a NumPy Array

## Practical 1: Convert a List into an Array

### Problem

Given:

```python
marks = [75, 82, 91, 68, 88]
```

Convert it into a NumPy array.

### Solution

```python
import numpy as np

marks = [75, 82, 91, 68, 88]

arr = np.array(marks)

print(arr)
```

Output:

```text
[75 82 91 68 88]
```

### Key pattern

```python
np.array(list)
```

---

# 4. One-Dimensional and Two-Dimensional Arrays

## 1-D Array

```python
arr = np.array([10, 20, 30, 40])
```

Conceptually:

```text
[10 20 30 40]
```

## 2-D Array

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

Conceptually:

```text
10 20 30
40 50 60
```

---

# 5. Understanding ndim, shape, size and dtype

These four are extremely important in practical questions.

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

## Number of dimensions

```python
print(arr.ndim)
```

Output:

```text
2
```

## Shape

```python
print(arr.shape)
```

Output:

```text
(2, 3)
```

Meaning:

```text
2 rows
3 columns
```

## Number of elements

```python
print(arr.size)
```

Output:

```text
6
```

## Data type

```python
print(arr.dtype)
```

Possible output:

```text
int64
```

---

# 6. Practical Question Pattern

### Problem

Given an array, display:

1. Number of dimensions
2. Shape
3. Number of elements
4. Data type

### Solution

```python
import numpy as np

arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])

print("Dimensions:", arr.ndim)
print("Shape:", arr.shape)
print("Size:", arr.size)
print("Data type:", arr.dtype)
```

### Remember

```text
ndim  → How many dimensions?
shape → How many rows/columns?
size  → How many values?
dtype → What type of data?
```

---

# 7. Creating Arrays with arange()

Suppose the problem says:

> Generate numbers from 1 to 10.

Use:

```python
np.arange()
```

```python
arr = np.arange(1, 11)

print(arr)
```

Output:

```text
[ 1  2  3  4  5  6  7  8  9 10]
```

## Important

The ending value is **excluded**.

```python
np.arange(start, stop)
```

Example:

```python
np.arange(1, 5)
```

Output:

```text
[1 2 3 4]
```

---

# 8. arange() with Step

### Problem

Generate even numbers from 2 to 20.

```python
arr = np.arange(2, 21, 2)

print(arr)
```

Output:

```text
[ 2  4  6  8 10 12 14 16 18 20]
```

Pattern:

```python
np.arange(start, stop, step)
```

---

# 9. linspace()

Use `linspace()` when the problem says:

> Generate a fixed number of equally spaced values.

Example:

```python
arr = np.linspace(0, 10, 5)

print(arr)
```

Output:

```text
[ 0.   2.5  5.   7.5 10. ]
```

Here:

```text
start = 0
end = 10
number of values = 5
```

### Difference

```python
np.arange()
```

is generally based on **step size**.

```python
np.linspace()
```

is based on **number of values**.

---

# 10. zeros() and ones()

## Problem

Create an array containing five zeros.

```python
arr = np.zeros(5)

print(arr)
```

Output:

```text
[0. 0. 0. 0. 0.]
```

## Two-dimensional zeros

```python
arr = np.zeros((3, 4))
```

Creates:

```text
3 rows × 4 columns
```

---

## ones()

```python
arr = np.ones(5)

print(arr)
```

Output:

```text
[1. 1. 1. 1. 1.]
```

Two-dimensional:

```python
arr = np.ones((2, 3))
```

---

# 11. Identity Matrix

A common matrix practical:

> Create a 3 × 3 identity matrix.

```python
arr = np.eye(3)

print(arr)
```

Output:

```text
[[1. 0. 0.]
 [0. 1. 0.]
 [0. 0. 1.]]
```

---

# 12. Random Numbers

NumPy provides random-number functionality through:

```python
np.random
```

## Random numbers between 0 and 1

```python
arr = np.random.rand(5)

print(arr)
```

---

## Random integers

```python
arr = np.random.randint(1, 100, 5)

print(arr)
```

Meaning:

```text
1       → minimum
100     → upper limit
5       → number of values
```

---

## 2-D random array

```python
arr = np.random.randint(1, 100, (3, 4))
```

Creates:

```text
3 × 4
```

array.

---

# 13. Indexing

Suppose:

```python
arr = np.array([10, 20, 30, 40, 50])
```

Python/NumPy indexing starts from **0**.

```python
print(arr[0])
```

Output:

```text
10
```

```python
print(arr[2])
```

Output:

```text
30
```

Last element:

```python
print(arr[-1])
```

Output:

```text
50
```

---

# 14. 2-D Array Indexing

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

Access `50`:

```python
print(arr[1, 1])
```

Access `30`:

```python
print(arr[0, 2])
```

General pattern:

```python
arr[row, column]
```

---

# 15. Slicing

Suppose:

```python
arr = np.array([10, 20, 30, 40, 50])
```

Get first three elements:

```python
print(arr[0:3])
```

Output:

```text
[10 20 30]
```

Get elements from index 2 onward:

```python
print(arr[2:])
```

Output:

```text
[30 40 50]
```

Get first three:

```python
arr[:3]
```

Get last two:

```python
arr[-2:]
```

---

# 16. 2-D Slicing

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])
```

Get first two rows:

```python
arr[:2]
```

Get first two columns:

```python
arr[:, :2]
```

Get second column:

```python
arr[:, 1]
```

Get second row:

```python
arr[1, :]
```

### Important pattern

```python
arr[rows, columns]
```

---

# 17. Boolean Filtering

This is one of the **most important NumPy practical concepts**.

Suppose:

```python
marks = np.array([45, 78, 92, 34, 88, 61])
```

Problem:

> Find marks greater than 60.

```python
result = marks[marks > 60]

print(result)
```

Output:

```text
[78 92 88 61]
```

The expression:

```python
marks > 60
```

creates a Boolean array.

Conceptually:

```text
False True True False True True
```

Then NumPy uses it to filter the original array.

---

# 18. Practical: Find Failed Students

```python
marks = np.array([45, 78, 92, 34, 88, 61])

failed = marks[marks < 50]

print(failed)
```

Output:

```text
[45 34]
```

---

# 19. Multiple Conditions

Problem:

> Find marks between 50 and 80.

Use:

```python
result = marks[(marks >= 50) & (marks <= 80)]
```

Important:

Use:

```python
&
```

instead of Python's:

```python
and
```

For OR:

```python
|
```

Example:

```python
result = marks[(marks < 40) | (marks > 90)]
```

---

# 20. np.where()

`np.where()` is extremely useful when a question says:

> Find positions/indices where a condition is true.

Example:

```python
marks = np.array([45, 78, 92, 34, 88, 61])

positions = np.where(marks > 80)

print(positions)
```

Output:

```text
(array([2, 4]),)
```

This means values greater than 80 occur at indices:

```text
2
4
```

---

# 21. Replace Values Using Boolean Conditions

Problem:

> Replace all marks below 40 with 40.

```python
marks = np.array([45, 78, 32, 34, 88, 61])

marks[marks < 40] = 40

print(marks)
```

Output:

```text
[45 78 40 40 88 61]
```

This is a very common practical pattern.

---

# 22. np.where() for Conditional Replacement

Example:

> If mark is >= 50, label it Pass, otherwise Fail.

```python
marks = np.array([45, 78, 32, 88])

result = np.where(marks >= 50, "Pass", "Fail")

print(result)
```

Output:

```text
['Fail' 'Pass' 'Fail' 'Pass']
```

Pattern:

```python
np.where(condition, value_if_true, value_if_false)
```

---

# 23. Mathematical Operations

NumPy allows calculations directly on arrays.

```python
arr = np.array([10, 20, 30, 40])
```

Add 5:

```python
print(arr + 5)
```

Multiply by 2:

```python
print(arr * 2)
```

Subtract 3:

```python
print(arr - 3)
```

Divide by 2:

```python
print(arr / 2)
```

This is called **vectorized operation**.

---

# 24. Array-to-Array Operations

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

# 25. Statistical Functions

Suppose:

```python
marks = np.array([70, 80, 90, 60, 85])
```

## Minimum

```python
np.min(marks)
```

## Maximum

```python
np.max(marks)
```

## Sum

```python
np.sum(marks)
```

## Mean

```python
np.mean(marks)
```

## Median

```python
np.median(marks)
```

## Standard deviation

```python
np.std(marks)
```

---

# 26. Practical: Student Marks Analysis

### Problem

Given marks:

```python
marks = np.array([72, 85, 91, 65, 78, 88])
```

Find:

* Total
* Average
* Highest
* Lowest
* Median

### Solution

```python
import numpy as np

marks = np.array([72, 85, 91, 65, 78, 88])

print("Total:", np.sum(marks))
print("Average:", np.mean(marks))
print("Highest:", np.max(marks))
print("Lowest:", np.min(marks))
print("Median:", np.median(marks))
```

---

# 27. Axis — Extremely Important

Consider:

```python
marks = np.array([
    [70, 80, 90],
    [60, 75, 85],
    [88, 92, 95]
])
```

Shape:

```text
3 rows × 3 columns
```

## Sum of everything

```python
np.sum(marks)
```

## Sum row-wise

```python
np.sum(marks, axis=1)
```

Output:

```text
[240 220 275]
```

Each row is summed.

## Sum column-wise

```python
np.sum(marks, axis=0)
```

Output:

```text
[218 247 270]
```

### Remember

```text
axis=0 → operate DOWN the rows → column result

axis=1 → operate ACROSS columns → row result
```

A useful mental model:

```text
axis=0
   ↓
70  80  90
60  75  85
88  92  95

axis=1
→ → →
```

---

# 28. Practical: Total Marks for Each Student

```python
marks = np.array([
    [70, 80, 90],
    [60, 75, 85],
    [88, 92, 95]
])

student_totals = np.sum(marks, axis=1)

print(student_totals)
```

Output:

```text
[240 220 275]
```

---

# 29. Practical: Average Marks in Each Subject

```python
subject_average = np.mean(marks, axis=0)

print(subject_average)
```

This calculates the average for each column/subject.

---

# 30. Reshape

Suppose:

```python
arr = np.arange(1, 13)
```

Output:

```text
[1 2 3 4 5 6 7 8 9 10 11 12]
```

Problem:

> Convert it into a 3 × 4 matrix.

```python
result = arr.reshape(3, 4)

print(result)
```

Output:

```text
[[ 1  2  3  4]
 [ 5  6  7  8]
 [ 9 10 11 12]]
```

---

# 31. Important Reshape Rule

The total number of elements must remain the same.

This works:

```python
arr.reshape(3, 4)
```

because:

```text
3 × 4 = 12
```

This also works:

```python
arr.reshape(2, 6)
```

But this does not:

```python
arr.reshape(3, 5)
```

because:

```text
3 × 5 = 15
```

while the original has only 12 elements.

---

# 32. Automatic Dimension with -1

You can allow NumPy to calculate one dimension.

```python
arr.reshape(3, -1)
```

For 12 elements:

```text
3 × 4
```

NumPy calculates `4`.

Another example:

```python
arr.reshape(-1, 4)
```

NumPy calculates the number of rows.

---

# 33. Flatten

Problem:

> Convert a 2-D array into a 1-D array.

```python
arr = np.array([
    [1, 2, 3],
    [4, 5, 6]
])

result = arr.flatten()

print(result)
```

Output:

```text
[1 2 3 4 5 6]
```

---

# 34. Transpose

Transpose changes rows into columns.

```python
arr = np.array([
    [1, 2, 3],
    [4, 5, 6]
])

print(arr.T)
```

Output:

```text
[[1 4]
 [2 5]
 [3 6]]
```

---

# 35. Sorting

```python
marks = np.array([78, 45, 91, 62, 88])

result = np.sort(marks)

print(result)
```

Output:

```text
[45 62 78 88 91]
```

Descending:

```python
result = np.sort(marks)[::-1]
```

---

# 36. Unique Values

Problem:

> Find distinct values.

```python
arr = np.array([10, 20, 10, 30, 20, 40, 10])

result = np.unique(arr)

print(result)
```

Output:

```text
[10 20 30 40]
```

---

# 37. Count Unique Values

```python
values, counts = np.unique(arr, return_counts=True)

print(values)
print(counts)
```

Example output:

```text
[10 20 30 40]
[3 2 1 1]
```

This is useful for:

* Frequency analysis
* Category counting
* Repeated values
* Survey data
* Transaction analysis

---

# 38. Finding Maximum/Minimum Position

Problem:

> Find the index of the highest mark.

Use:

```python
marks = np.array([72, 91, 85, 95, 78])

index = np.argmax(marks)

print(index)
```

Output:

```text
3
```

Because:

```text
95
```

is at index `3`.

Similarly:

```python
np.argmin(marks)
```

finds the position of the minimum.

---

# 39. Data Type Conversion

Suppose:

```python
arr = np.array([10, 20, 30])
```

Convert to float:

```python
result = arr.astype(float)

print(result)
```

Output:

```text
[10. 20. 30.]
```

Convert to integer:

```python
arr.astype(int)
```

---

# 40. Rounding

```python
arr = np.array([10.234, 20.678, 30.456])

result = np.round(arr, 2)

print(result)
```

Output:

```text
[10.23 20.68 30.46]
```

---

# 41. Combining Arrays

## concatenate()

```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

result = np.concatenate((a, b))

print(result)
```

Output:

```text
[1 2 3 4 5 6]
```

---

# 42. vstack()

Vertical stacking:

```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

result = np.vstack((a, b))

print(result)
```

Output:

```text
[[1 2 3]
 [4 5 6]]
```

---

# 43. hstack()

Horizontal stacking:

```python
result = np.hstack((a, b))

print(result)
```

Output:

```text
[1 2 3 4 5 6]
```

---

# 44. Matrix Multiplication

Suppose:

```python
A = np.array([
    [1, 2],
    [3, 4]
])

B = np.array([
    [5, 6],
    [7, 8]
])
```

Matrix multiplication:

```python
result = A @ B
```

or:

```python
result = np.matmul(A, B)
```

Do not confuse this with:

```python
A * B
```

`*` performs element-wise multiplication.

`@` performs matrix multiplication.

---

# 45. Practical: Sales Data

Consider:

```python
sales = np.array([
    [100, 120, 150],
    [80, 90, 110],
    [200, 180, 220]
])
```

Suppose rows represent products and columns represent months.

## Total sales of each product

```python
np.sum(sales, axis=1)
```

## Total sales for each month

```python
np.sum(sales, axis=0)
```

## Average sales of each product

```python
np.mean(sales, axis=1)
```

## Highest sales

```python
np.max(sales)
```

## Position of highest sales

```python
np.argmax(sales)
```

---

# 46. Practical: Find Products Above a Threshold

```python
sales = np.array([120, 450, 230, 780, 340, 900])

result = sales[sales > 500]

print(result)
```

Output:

```text
[780 900]
```

---

# 47. Practical: Count Values Above a Threshold

Problem:

> Count how many sales values are greater than 500.

```python
count = np.sum(sales > 500)

print(count)
```

Why does this work?

Boolean values behave numerically:

```text
True  → 1
False → 0
```

Therefore:

```python
np.sum(sales > 500)
```

counts the number of `True` values.

---

# 48. Practical: Percentage Calculation

Suppose:

```python
marks = np.array([70, 80, 90])
```

Maximum marks are 100.

Percentage:

```python
percentage = marks / 100 * 100
```

For a different maximum:

```python
percentage = marks / 150 * 100
```

---

# 49. Practical: Normalization

A common data-analysis requirement is to scale values between 0 and 1.

Formula:

```text
(value - minimum) / (maximum - minimum)
```

NumPy:

```python
data = np.array([10, 20, 30, 40, 50])

normalized = (
    data - np.min(data)
) / (
    np.max(data) - np.min(data)
)

print(normalized)
```

---

# 50. Handling Missing Values

NumPy represents missing numerical values using:

```python
np.nan
```

Example:

```python
data = np.array([10, 20, np.nan, 40])
```

Normal mean:

```python
np.mean(data)
```

will return:

```text
nan
```

Use:

```python
np.nanmean(data)
```

Output:

```text
23.333...
```

Other useful functions:

```python
np.nansum()
np.nanmin()
np.nanmax()
np.nanmedian()
```

---

# 51. Detect Missing Values

```python
data = np.array([10, 20, np.nan, 40])

print(np.isnan(data))
```

Output:

```text
[False False True False]
```

Find missing values:

```python
data[np.isnan(data)]
```

---

# 52. Replace Missing Values

Problem:

> Replace missing values with the average.

```python
data = np.array([10, 20, np.nan, 40])

mean_value = np.nanmean(data)

data[np.isnan(data)] = mean_value

print(data)
```

---

# 53. Practical Decision Guide

When you see a problem, identify the requirement.

## "Create an array"

Think:

```python
np.array()
```

---

## "Generate numbers from X to Y"

Think:

```python
np.arange()
```

---

## "Generate N equally spaced numbers"

Think:

```python
np.linspace()
```

---

## "Create matrix of zeros"

Think:

```python
np.zeros()
```

---

## "Create matrix of ones"

Think:

```python
np.ones()
```

---

## "Find highest/lowest"

Think:

```python
np.max()
np.min()
```

---

## "Find average"

Think:

```python
np.mean()
```

---

## "Find median"

Think:

```python
np.median()
```

---

## "Find total"

Think:

```python
np.sum()
```

---

## "Find position of maximum"

Think:

```python
np.argmax()
```

---

## "Find values satisfying a condition"

Think:

```python
arr[condition]
```

Example:

```python
arr[arr > 50]
```

---

## "Find positions satisfying a condition"

Think:

```python
np.where()
```

---

## "Count values satisfying a condition"

Think:

```python
np.sum(condition)
```

---

## "Replace values satisfying a condition"

Think:

```python
arr[condition] = value
```

or:

```python
np.where()
```

---

## "Change dimensions"

Think:

```python
reshape()
```

---

## "Convert 2-D to 1-D"

Think:

```python
flatten()
```

---

## "Convert rows to columns"

Think:

```python
.T
```

---

## "Remove duplicate values"

Think:

```python
np.unique()
```

---

## "Sort values"

Think:

```python
np.sort()
```

---

# 54. The Most Important Practical Patterns

These patterns should become automatic for trainees.

## Pattern 1 — Filter

```python
result = arr[arr > threshold]
```

---

## Pattern 2 — Multiple Conditions

```python
result = arr[(arr >= low) & (arr <= high)]
```

---

## Pattern 3 — Count Condition

```python
count = np.sum(arr > threshold)
```

---

## Pattern 4 — Find Positions

```python
positions = np.where(arr > threshold)
```

---

## Pattern 5 — Conditional Replacement

```python
arr[arr < threshold] = replacement
```

---

## Pattern 6 — Conditional Label

```python
result = np.where(
    arr >= threshold,
    "Pass",
    "Fail"
)
```

---

## Pattern 7 — Row-wise Calculation

```python
np.sum(arr, axis=1)
```

---

## Pattern 8 — Column-wise Calculation

```python
np.sum(arr, axis=0)
```

---

## Pattern 9 — Normalize

```python
normalized = (
    arr - np.min(arr)
) / (
    np.max(arr) - np.min(arr)
)
```

---

## Pattern 10 — Frequency

```python
values, counts = np.unique(
    arr,
    return_counts=True
)
```

---

# 55. Practical Question: Employee Salaries

### Problem

Given:

```python
salary = np.array([
    35000,
    45000,
    55000,
    28000,
    75000,
    62000
])
```

Find:

1. Average salary
2. Highest salary
3. Lowest salary
4. Employees earning more than 50,000
5. Number of employees earning more than 50,000

### Solution

```python
import numpy as np

salary = np.array([
    35000,
    45000,
    55000,
    28000,
    75000,
    62000
])

print("Average:", np.mean(salary))
print("Highest:", np.max(salary))
print("Lowest:", np.min(salary))

high_salary = salary[salary > 50000]

print("Above 50000:", high_salary)

count = np.sum(salary > 50000)

print("Count:", count)
```

---

# 56. Practical Question: Temperature Analysis

### Problem

Given temperatures:

```python
temperature = np.array([
    28, 31, 35, 29, 33, 38, 25
])
```

Find:

* Average temperature
* Highest temperature
* Lowest temperature
* Temperatures above 30
* Number of days above 30
* Index of hottest day

### Solution

```python
import numpy as np

temperature = np.array([
    28, 31, 35, 29, 33, 38, 25
])

print("Average:", np.mean(temperature))
print("Highest:", np.max(temperature))
print("Lowest:", np.min(temperature))

above_30 = temperature[temperature > 30]

print("Above 30:", above_30)

count = np.sum(temperature > 30)

print("Number of days:", count)

hottest_day = np.argmax(temperature)

print("Hottest day index:", hottest_day)
```

---

# 57. Practical Question: Student Performance

Given:

```python
marks = np.array([
    [78, 85, 90],
    [65, 70, 72],
    [88, 92, 95],
    [55, 60, 58]
])
```

Rows = students

Columns = subjects.

Find:

1. Total marks of each student
2. Average marks of each student
3. Highest mark in each subject
4. Average mark in each subject
5. Overall average

### Solution

```python
import numpy as np

marks = np.array([
    [78, 85, 90],
    [65, 70, 72],
    [88, 92, 95],
    [55, 60, 58]
])

student_total = np.sum(marks, axis=1)

student_average = np.mean(marks, axis=1)

subject_highest = np.max(marks, axis=0)

subject_average = np.mean(marks, axis=0)

overall_average = np.mean(marks)

print("Student totals:", student_total)
print("Student averages:", student_average)
print("Subject highest:", subject_highest)
print("Subject averages:", subject_average)
print("Overall average:", overall_average)
```

---

# 58. How to Think About axis

This causes many mistakes in practical exams.

Suppose:

```python
data = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])
```

If asked:

> Calculate total for each student.

Students are rows.

Therefore:

```python
np.sum(data, axis=1)
```

If asked:

> Calculate total for each subject.

Subjects are columns.

Therefore:

```python
np.sum(data, axis=0)
```

### Golden Rule

```text
Need one result for every ROW?
→ axis=1

Need one result for every COLUMN?
→ axis=0
```

---

# 59. NumPy vs Python List

Python list:

```python
marks = [10, 20, 30]

result = []

for x in marks:
    result.append(x * 2)
```

NumPy:

```python
marks = np.array([10, 20, 30])

result = marks * 2
```

This is one of NumPy's biggest advantages.

---

# 60. Vectorization

Instead of:

```python
result = []

for x in arr:
    result.append(x * 10)
```

Use:

```python
result = arr * 10
```

Instead of:

```python
result = []

for x in arr:
    if x > 50:
        result.append(x)
```

Use:

```python
result = arr[arr > 50]
```

The NumPy approach is called **vectorization**.

---

# 61. A Practical Problem-Solving Framework

For every NumPy question, follow these five steps.

## Step 1 — Identify the input

Ask:

```text
Is it a list?
1-D array?
2-D array?
```

---

## Step 2 — Identify the required operation

Ask:

```text
Create?
Filter?
Calculate?
Count?
Sort?
Reshape?
Replace?
Aggregate?
```

---

## Step 3 — Identify whether axis is required

If it is a 2-D array:

```text
One result per row → axis=1

One result per column → axis=0

One result for everything → no axis
```

---

## Step 4 — Write the simplest NumPy expression

Prefer:

```python
np.mean()
np.sum()
np.max()
np.min()
```

over unnecessary loops.

---

## Step 5 — Check the expected output shape

For example:

```python
np.sum(data, axis=1)
```

If `data.shape` is:

```text
(4, 3)
```

then the result should have:

```text
4 values
```

because there are four rows.

---

# 62. NumPy Practical Cheat Sheet

| Requirement             | Function / Pattern                   |   |
| ----------------------- | ------------------------------------ | - |
| Create array            | `np.array()`                         |   |
| Range                   | `np.arange()`                        |   |
| Fixed number of values  | `np.linspace()`                      |   |
| Zeros                   | `np.zeros()`                         |   |
| Ones                    | `np.ones()`                          |   |
| Identity matrix         | `np.eye()`                           |   |
| Random values           | `np.random.rand()`                   |   |
| Random integers         | `np.random.randint()`                |   |
| Dimensions              | `.ndim`                              |   |
| Shape                   | `.shape`                             |   |
| Elements                | `.size`                              |   |
| Data type               | `.dtype`                             |   |
| Convert type            | `.astype()`                          |   |
| First element           | `arr[0]`                             |   |
| Last element            | `arr[-1]`                            |   |
| Slice                   | `arr[start:end]`                     |   |
| Filter                  | `arr[arr > x]`                       |   |
| Multiple conditions     | `&`, `                               | ` |
| Conditional positions   | `np.where()`                         |   |
| Conditional replacement | `arr[condition] = value`             |   |
| Conditional output      | `np.where()`                         |   |
| Total                   | `np.sum()`                           |   |
| Average                 | `np.mean()`                          |   |
| Median                  | `np.median()`                        |   |
| Minimum                 | `np.min()`                           |   |
| Maximum                 | `np.max()`                           |   |
| Std deviation           | `np.std()`                           |   |
| Maximum position        | `np.argmax()`                        |   |
| Minimum position        | `np.argmin()`                        |   |
| Sort                    | `np.sort()`                          |   |
| Unique                  | `np.unique()`                        |   |
| Frequency               | `np.unique(..., return_counts=True)` |   |
| Reshape                 | `.reshape()`                         |   |
| Flatten                 | `.flatten()`                         |   |
| Transpose               | `.T`                                 |   |
| Combine                 | `np.concatenate()`                   |   |
| Vertical stack          | `np.vstack()`                        |   |
| Horizontal stack        | `np.hstack()`                        |   |
| Matrix multiplication   | `@`                                  |   |
| Missing values          | `np.nan`                             |   |
| Missing check           | `np.isnan()`                         |   |
| Ignore NaN in mean      | `np.nanmean()`                       |   |

---

# 63. Assessment-Oriented Practice Problems

## Easy

### Q1

Create a NumPy array containing:

```text
10, 20, 30, 40, 50
```

Display:

* array
* shape
* size
* dimensions

---

### Q2

Generate all even numbers between 10 and 50.

---

### Q3

Given:

```python
marks = np.array([45, 78, 92, 34, 88, 61])
```

Find:

* highest
* lowest
* average
* total

---

### Q4

From the same array, find all marks greater than 60.

---

### Q5

Count how many students scored more than 75.

---

# 64. Medium Problems

## Q6 — Sales Analysis

```python
sales = np.array([
    1200, 1500, 800, 2200, 1750, 900, 2500
])
```

Find:

1. Total sales
2. Average sales
3. Highest sale
4. Lowest sale
5. Sales above 1500
6. Number of sales above 1500
7. Index of highest sale

---

## Q7 — Employee Analysis

```python
salary = np.array([
    35000, 42000, 58000, 62000,
    48000, 75000, 39000
])
```

Find:

1. Average salary
2. Employees earning more than 50,000
3. Number of employees earning more than 50,000
4. Highest salary
5. Position of highest salary

---

## Q8 — Student Matrix

```python
marks = np.array([
    [70, 80, 90],
    [65, 75, 85],
    [88, 92, 95],
    [55, 60, 70]
])
```

Find:

1. Total marks per student
2. Average marks per student
3. Highest marks per subject
4. Average marks per subject
5. Overall average
6. Student with highest total

---

# 65. Advanced Practical Problems

## Q9 — Customer Transaction Analysis

```python
transactions = np.array([
    [1000, 1200, 900],
    [1500, 1800, 1700],
    [800, 950, 1100],
    [2200, 2100, 2500]
])
```

Rows represent customers.

Columns represent months.

Find:

1. Total spending by each customer
2. Average spending by each customer
3. Highest monthly spending for each customer
4. Total spending for each month
5. Average spending for each month
6. Customer with highest total spending
7. Transactions greater than 2000

---

# 66. Advanced Practical: Data Cleaning

Given:

```python
data = np.array([
    10, 20, np.nan, 30,
    np.nan, 40, 50
])
```

Perform:

1. Identify missing values
2. Count missing values
3. Calculate mean excluding missing values
4. Replace missing values with the mean

Useful functions:

```python
np.isnan()
np.sum()
np.nanmean()
```

---

# 67. The NumPy Exam Strategy

When trainees receive a practical question, tell them to underline the verbs.

For example:

> "Create an array of sales data, calculate the average, identify transactions greater than 5000, count those transactions, and find the index of the highest transaction."

Underline:

```text
Create
Calculate average
Identify
Count
Find index
```

Translate them:

```text
Create
→ np.array()

Average
→ np.mean()

Identify/filter
→ arr[arr > 5000]

Count
→ np.sum(arr > 5000)

Index of highest
→ np.argmax()
```

Then write:

```python
import numpy as np

sales = np.array([...])

average = np.mean(sales)

high_sales = sales[sales > 5000]

count = np.sum(sales > 5000)

highest_index = np.argmax(sales)
```

This is the core skill trainees need.

---

# 68. The "Question → Function" Mapping

Train yourself to automatically translate words.

```text
"total"
        ↓
np.sum()

"average"
        ↓
np.mean()

"maximum"
        ↓
np.max()

"minimum"
        ↓
np.min()

"highest position"
        ↓
np.argmax()

"lowest position"
        ↓
np.argmin()

"greater than"
        ↓
arr[arr > x]

"less than"
        ↓
arr[arr < x]

"between"
        ↓
arr[(arr >= x) & (arr <= y)]

"count"
        ↓
np.sum(condition)

"positions"
        ↓
np.where(condition)

"replace"
        ↓
arr[condition] = value

"unique"
        ↓
np.unique()

"frequency"
        ↓
np.unique(..., return_counts=True)

"sort"
        ↓
np.sort()

"reshape"
        ↓
arr.reshape()

"flatten"
        ↓
arr.flatten()

"transpose"
        ↓
arr.T
```

---

# 69. Final Mental Model

Do not try to memorize NumPy as hundreds of functions.

Remember these categories:

```text
             NUMPY
               |
     -----------------------
     |          |          |
   CREATE     ANALYZE    TRANSFORM
     |          |          |
 array       sum         reshape
 arange      mean        flatten
 linspace    max         transpose
 zeros       min
 ones        median
             std
             |
        ----------------
        |       |      |
      FILTER   COUNT  FIND
        |       |      |
       > <     sum    where
       & |           argmax
                     argmin
```

Then add:

```text
SORT       → np.sort()
UNIQUE     → np.unique()
COMBINE    → concatenate / stack
MATRIX     → @
MISSING    → np.nan / isnan / nanmean
```

The most important practical progression is:

```text
Array Creation
      ↓
Indexing & Slicing
      ↓
Filtering
      ↓
Statistics
      ↓
Conditions
      ↓
Axis
      ↓
Reshape
      ↓
Sorting / Unique
      ↓
Data Cleaning
      ↓
Real-world Problem Solving
```

If trainees master these patterns, they can solve a large proportion of **basic-to-intermediate NumPy practical assessment questions** without memorizing every NumPy function.
