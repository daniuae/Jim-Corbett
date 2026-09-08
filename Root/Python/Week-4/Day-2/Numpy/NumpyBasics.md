# NumPy — Complete Tutorial

> A practical NumPy tutorial from beginner to advanced, with examples, cheat sheets, and coding-test patterns.

---

## 1. What is NumPy?

**NumPy = Numerical Python**

NumPy is a Python library designed for:

- Numerical calculations
- Arrays and matrices
- Mathematical operations
- Statistics
- Linear algebra
- Random number generation
- Data manipulation
- Scientific computing

The most important NumPy object is the:

> **`ndarray` — N-dimensional array**

### Why NumPy instead of Python lists?

Python list:

```python
numbers = [10, 20, 30, 40]
print(numbers * 2)
```

Output:

```text
[10, 20, 30, 40, 10, 20, 30, 40]
```

NumPy array:

```python
import numpy as np

numbers = np.array([10, 20, 30, 40])
print(numbers * 2)
```

Output:

```text
[20 40 60 80]
```

NumPy performs **element-wise numerical operations**.

---

# 2. Installing NumPy

```bash
pip install numpy
```

Check installation:

```python
import numpy as np

print(np.__version__)
```

The standard convention is:

```python
import numpy as np
```

---

# 3. Creating NumPy Arrays

## From a Python list

```python
import numpy as np

arr = np.array([10, 20, 30, 40])

print(arr)
```

Output:

```text
[10 20 30 40]
```

## From a tuple

```python
arr = np.array((10, 20, 30))
```

## 2D array

```python
arr = np.array([
    [1, 2, 3],
    [4, 5, 6]
])
```

Visual representation:

```text
1  2  3
4  5  6
```

## 3D array

```python
arr = np.array([
    [
        [1, 2],
        [3, 4]
    ],
    [
        [5, 6],
        [7, 8]
    ]
])
```

Think of it as:

```text
Layer 1
1 2
3 4

Layer 2
5 6
7 8
```

---

# 4. Important Array Properties

Suppose:

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

## `ndim`

Number of dimensions:

```python
print(arr.ndim)
```

Output:

```text
2
```

## `shape`

Number of rows and columns:

```python
print(arr.shape)
```

Output:

```text
(2, 3)
```

Meaning:

- 2 rows
- 3 columns

## `size`

Total number of elements:

```python
print(arr.size)
```

Output:

```text
6
```

## `dtype`

Data type:

```python
print(arr.dtype)
```

Example:

```text
int64
```

## `itemsize`

Number of bytes used by each element:

```python
print(arr.itemsize)
```

### Important properties

| Property | Meaning |
|---|---|
| `ndim` | Number of dimensions |
| `shape` | Size of each dimension |
| `size` | Total elements |
| `dtype` | Data type |
| `itemsize` | Bytes per element |

---

# 5. Creating Special Arrays

## `zeros()`

```python
np.zeros(5)
```

Output:

```text
[0. 0. 0. 0. 0.]
```

2D:

```python
np.zeros((2, 3))
```

Output:

```text
[[0. 0. 0.]
 [0. 0. 0.]]
```

## `ones()`

```python
np.ones(5)
```

Output:

```text
[1. 1. 1. 1. 1.]
```

2D:

```python
np.ones((3, 2))
```

## `full()`

Create an array containing a specific value:

```python
np.full(5, 7)
```

Output:

```text
[7 7 7 7 7]
```

2D:

```python
np.full((2, 3), 10)
```

## Identity matrix

```python
np.eye(3)
```

Output:

```text
[[1. 0. 0.]
 [0. 1. 0.]
 [0. 0. 1.]]
```

Useful in:

- Linear algebra
- Matrix calculations
- Machine learning

---

# 6. `arange()`

Very important.

```python
np.arange(1, 10)
```

Output:

```text
[1 2 3 4 5 6 7 8 9]
```

Syntax:

```python
np.arange(start, stop, step)
```

Example:

```python
np.arange(0, 20, 2)
```

Output:

```text
[0 2 4 6 8 10 12 14 16 18]
```

Notice:

> `stop` is excluded.

---

# 7. `linspace()`

Creates evenly spaced values.

```python
np.linspace(0, 10, 5)
```

Output:

```text
[ 0.   2.5  5.   7.5 10. ]
```

### Difference between `arange()` and `linspace()`

```python
np.arange(0, 10, 2)
```

is based on **step size**.

```python
np.linspace(0, 10, 5)
```

is based on **number of values**.

---

# 8. Random Arrays

NumPy provides the `random` module.

```python
np.random.rand(5)
```

Generates random values between 0 and 1.

## Random integers

```python
np.random.randint(1, 100, 5)
```

Example:

```text
[23 78 11 56 91]
```

## 2D random integers

```python
np.random.randint(1, 100, (3, 4))
```

## Random normal distribution

```python
np.random.randn(5)
```

---

# 9. NumPy Data Types

Common NumPy data types:

```text
int8
int16
int32
int64

float32
float64

bool
complex
```

Example:

```python
arr = np.array([1, 2, 3], dtype=np.float64)

print(arr)
```

Output:

```text
[1. 2. 3.]
```

---

# 10. Type Conversion

```python
arr = np.array([1, 2, 3])

arr_float = arr.astype(float)

print(arr_float)
```

Output:

```text
[1. 2. 3.]
```

Another example:

```python
arr.astype(str)
```

---

# 11. Indexing

Consider:

```python
arr = np.array([10, 20, 30, 40, 50])
```

Access first element:

```python
print(arr[0])
```

Output:

```text
10
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

# 12. 2D Indexing

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

Access:

```python
arr[0, 1]
```

Output:

```text
20
```

Think:

```text
      col
      0   1   2
row 0 10  20  30
row 1 40  50  60
```

So:

```python
arr[1, 2]
```

returns:

```text
60
```

---

# 13. Slicing

```python
arr = np.array([10, 20, 30, 40, 50])
```

```python
arr[1:4]
```

Output:

```text
[20 30 40]
```

Syntax:

```python
array[start:stop:step]
```

## Reverse array

```python
arr[::-1]
```

Output:

```text
[50 40 30 20 10]
```

---

# 14. 2D Slicing

```python
arr = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])
```

First two rows:

```python
arr[:2]
```

First two columns:

```python
arr[:, :2]
```

Output:

```text
[[1 2]
 [4 5]
 [7 8]]
```

---

# 15. Changing Array Values

```python
arr = np.array([10, 20, 30])

arr[1] = 100

print(arr)
```

Output:

```text
[10 100 30]
```

2D:

```python
arr[0, 1] = 999
```

---

# 16. Mathematical Operations

One of NumPy's biggest advantages is vectorization.

```python
arr = np.array([10, 20, 30, 40])
```

Addition:

```python
arr + 5
```

Output:

```text
[15 25 35 45]
```

Subtraction:

```python
arr - 5
```

Multiplication:

```python
arr * 2
```

Division:

```python
arr / 2
```

Power:

```python
arr ** 2
```

---

# 17. Array + Array

```python
a = np.array([1, 2, 3])
b = np.array([10, 20, 30])

a + b
```

Output:

```text
[11 22 33]
```

Similarly:

```python
a - b
a * b
a / b
a ** 2
```

These operations are **element-wise**.

---

# 18. Comparison Operations

```python
arr = np.array([10, 20, 30, 40])
```

```python
arr > 20
```

Output:

```text
[False False  True  True]
```

Similarly:

```python
arr < 30
arr >= 20
arr <= 30
arr == 20
arr != 20
```

These produce **Boolean arrays**.

---

# 19. Boolean Filtering

This is extremely important.

```python
arr = np.array([10, 20, 30, 40, 50])

arr[arr > 25]
```

Output:

```text
[30 40 50]
```

This is called:

> **Boolean indexing / Boolean masking**

## Practical example

```python
marks = np.array([45, 78, 91, 33, 67, 88])

passed = marks[marks >= 50]

print(passed)
```

Output:

```text
[78 91 67 88]
```

---

# 20. Multiple Conditions

Use:

```python
&
```

for AND.

```python
arr[(arr > 20) & (arr < 50)]
```

OR:

```python
arr[(arr < 20) | (arr > 40)]
```

NOT:

```python
arr[~(arr > 20)]
```

Important:

> Don't use Python's `and` / `or` directly with NumPy arrays.

---

# 21. `where()`

`np.where()` is extremely useful.

```python
marks = np.array([45, 78, 91, 33])

np.where(marks >= 50, "Pass", "Fail")
```

Output:

```text
['Fail' 'Pass' 'Pass' 'Fail']
```

Think:

```text
where(condition, value_if_true, value_if_false)
```

---

# 22. Aggregation Functions

Given:

```python
arr = np.array([10, 20, 30, 40, 50])
```

## Sum

```python
np.sum(arr)
```

Output:

```text
150
```

## Mean

```python
np.mean(arr)
```

Output:

```text
30
```

## Minimum

```python
np.min(arr)
```

## Maximum

```python
np.max(arr)
```

## Standard deviation

```python
np.std(arr)
```

## Variance

```python
np.var(arr)
```

## Median

```python
np.median(arr)
```

---

# 23. Useful Statistical Functions

| Function | Purpose |
|---|---|
| `np.sum()` | Sum |
| `np.mean()` | Average |
| `np.median()` | Median |
| `np.min()` | Minimum |
| `np.max()` | Maximum |
| `np.std()` | Standard deviation |
| `np.var()` | Variance |
| `np.percentile()` | Percentile |
| `np.prod()` | Product |
| `np.argmin()` | Index of minimum |
| `np.argmax()` | Index of maximum |

---

# 24. `argmin()` and `argmax()`

```python
arr = np.array([10, 50, 20, 80, 30])

np.argmax(arr)
```

Output:

```text
3
```

Because:

```text
index:  0   1   2   3   4
value: 10  50  20  80  30
```

Maximum is at index `3`.

```python
np.argmin(arr)
```

returns:

```text
0
```

---

# 25. Axis — VERY IMPORTANT

This is one of the most important NumPy concepts.

Consider:

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

## `axis=0`

Operate **down the rows**, producing one result per column.

```python
np.sum(arr, axis=0)
```

Output:

```text
[50 70 90]
```

Because:

```text
10 + 40 = 50
20 + 50 = 70
30 + 60 = 90
```

## `axis=1`

Operate **across the columns**, producing one result per row.

```python
np.sum(arr, axis=1)
```

Output:

```text
[60 150]
```

Because:

```text
10 + 20 + 30 = 60
40 + 50 + 60 = 150
```

### Easy memory trick

For a 2D array:

```text
axis=0 → column-wise result
axis=1 → row-wise result
```

A useful conceptual rule is:

> The axis you specify is the dimension that gets reduced.

---

# 26. Reshaping

Suppose:

```python
arr = np.arange(1, 7)
```

Output:

```text
[1 2 3 4 5 6]
```

Convert to 2 × 3:

```python
arr.reshape(2, 3)
```

Output:

```text
[[1 2 3]
 [4 5 6]]
```

---

# 27. Reshape Rules

The total number of elements must remain the same.

This works:

```python
np.arange(12).reshape(3, 4)
```

because:

```text
3 × 4 = 12
```

Also:

```python
np.arange(12).reshape(2, 6)
```

But this doesn't:

```python
np.arange(10).reshape(3, 4)
```

because:

```text
3 × 4 = 12
```

but there are only 10 elements.

---

# 28. Automatic Dimension

You can use `-1`.

```python
arr = np.arange(12)

arr.reshape(3, -1)
```

NumPy calculates the missing dimension:

```text
3 × 4 = 12
```

So the result shape is:

```text
(3, 4)
```

---

# 29. Flatten

Convert a multidimensional array into one dimension.

```python
arr = np.array([
    [1, 2],
    [3, 4]
])

arr.flatten()
```

Output:

```text
[1 2 3 4]
```

---

# 30. `ravel()`

Similar to `flatten()`:

```python
arr.ravel()
```

Important difference:

- `flatten()` generally creates a copy
- `ravel()` generally returns a view when possible

For beginner-level problems, remember:

> Both convert an array to 1D.

---

# 31. Transpose

```python
arr = np.array([
    [1, 2, 3],
    [4, 5, 6]
])
```

```python
arr.T
```

Output:

```text
[[1 4]
 [2 5]
 [3 6]]
```

Rows become columns.

---

# 32. Sorting

```python
arr = np.array([50, 10, 40, 20, 30])

np.sort(arr)
```

Output:

```text
[10 20 30 40 50]
```

## In-place sorting

```python
arr.sort()
```

---

# 33. Searching

## `where()`

```python
arr = np.array([10, 20, 30, 20, 40])

np.where(arr == 20)
```

Returns indices where the condition is true.

## `nonzero()`

```python
np.nonzero(arr)
```

Returns indices of non-zero values.

---

# 34. Unique Values

```python
arr = np.array([10, 20, 20, 30, 30, 30])

np.unique(arr)
```

Output:

```text
[10 20 30]
```

Count occurrences:

```python
np.unique(arr, return_counts=True)
```

---

# 35. Concatenation

```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

np.concatenate((a, b))
```

Output:

```text
[1 2 3 4 5 6]
```

---

# 36. Stacking

## Vertical stack

```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

np.vstack((a, b))
```

Output:

```text
[[1 2 3]
 [4 5 6]]
```

## Horizontal stack

```python
np.hstack((a, b))
```

Output:

```text
[1 2 3 4 5 6]
```

For 2D arrays, horizontal stacking becomes especially useful.

---

# 37. Splitting Arrays

```python
arr = np.arange(1, 7)

np.split(arr, 3)
```

Produces three arrays:

```text
[1 2]
[3 4]
[5 6]
```

---

# 38. Copy vs View

This is a very important concept.

## View

```python
a = np.array([1, 2, 3])

b = a.view()

b[0] = 100
```

Now:

```python
print(a)
```

will show:

```text
[100   2   3]
```

because the view shares the same underlying data.

## Copy

```python
a = np.array([1, 2, 3])

b = a.copy()

b[0] = 100
```

Now:

```python
print(a)
```

remains:

```text
[1 2 3]
```

### Remember

```text
view() → shares data
copy() → independent data
```

---

# 39. Broadcasting

Broadcasting is one of NumPy's most powerful features.

```python
arr = np.array([
    [1, 2, 3],
    [4, 5, 6]
])

arr + 10
```

Output:

```text
[[11 12 13]
 [14 15 16]]
```

NumPy automatically applies `10` to every element.

## Broadcasting with arrays

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])

bonus = np.array([1, 2, 3])

arr + bonus
```

Output:

```text
[[11 22 33]
 [41 52 63]]
```

The smaller array is broadcast across rows.

### Broadcasting rule

Dimensions are compatible when, comparing from the right:

1. They are equal, or
2. One of them is `1`.

This concept becomes very important for data science and machine learning.

---

# 40. Universal Functions — `ufunc`

NumPy provides fast mathematical functions.

Examples:

```python
np.sqrt(arr)
np.exp(arr)
np.log(arr)
np.sin(arr)
np.cos(arr)
np.abs(arr)
np.round(arr)
np.floor(arr)
np.ceil(arr)
```

Example:

```python
arr = np.array([1, 4, 9, 16])

np.sqrt(arr)
```

Output:

```text
[1. 2. 3. 4.]
```

---

# 41. Mathematical Functions

## Square root

```python
np.sqrt(arr)
```

## Absolute value

```python
np.abs(arr)
```

## Exponential

```python
np.exp(arr)
```

## Logarithm

```python
np.log(arr)
```

## Power

```python
np.power(arr, 2)
```

---

# 42. Matrix Operations

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

Element-wise multiplication:

```python
A * B
```

gives:

```text
[[ 5 12]
 [21 32]]
```

Matrix multiplication:

```python
A @ B
```

gives:

```text
[[19 22]
 [43 50]]
```

---

# 43. Matrix Multiplication

You can also use:

```python
np.matmul(A, B)
```

or:

```python
np.dot(A, B)
```

For modern NumPy code, `@` is often the clearest for matrix multiplication.

---

# 44. Determinant

NumPy's linear algebra module:

```python
np.linalg.det(A)
```

---

# 45. Inverse

```python
np.linalg.inv(A)
```

---

# 46. Eigenvalues

```python
np.linalg.eig(A)
```

---

# 47. Solving Linear Equations

Consider:

```text
2x + y = 5
x + 3y = 6
```

Represent as:

```python
A = np.array([
    [2, 1],
    [1, 3]
])

b = np.array([5, 6])
```

Solve:

```python
x = np.linalg.solve(A, b)

print(x)
```

---

# 48. NumPy and Loops

Python:

```python
numbers = [1, 2, 3, 4, 5]

result = []

for number in numbers:
    result.append(number * 2)
```

NumPy:

```python
numbers = np.array([1, 2, 3, 4, 5])

result = numbers * 2
```

This is called:

> **Vectorization**

Whenever possible, NumPy encourages vectorized operations instead of explicit Python loops.

---

# 49. Iterating Through Arrays

You can still use loops.

```python
arr = np.array([10, 20, 30])

for value in arr:
    print(value)
```

For 2D:

```python
arr = np.array([
    [1, 2],
    [3, 4]
])

for row in arr:
    print(row)
```

Output:

```text
[1 2]
[3 4]
```

---

# 50. `nditer()`

For element-by-element iteration:

```python
for x in np.nditer(arr):
    print(x)
```

---

# 51. Conditional Operations

Example:

```python
marks = np.array([35, 45, 67, 89, 91])
```

Find passed students:

```python
marks[marks >= 50]
```

Count passed:

```python
np.sum(marks >= 50)
```

Find average of passed students:

```python
np.mean(marks[marks >= 50])
```

This combination is extremely useful in coding problems.

---

# 52. Handling Missing Values

NumPy commonly uses:

```python
np.nan
```

Example:

```python
arr = np.array([10, 20, np.nan, 40])
```

Normal mean:

```python
np.mean(arr)
```

returns:

```text
nan
```

Use:

```python
np.nanmean(arr)
```

Output:

```text
23.333...
```

Other useful functions:

```python
np.isnan(arr)
np.nanmin(arr)
np.nanmax(arr)
np.nansum(arr)
np.nanmedian(arr)
```

---

# 53. Random Number Generation — Modern Approach

A modern NumPy pattern is:

```python
rng = np.random.default_rng()

numbers = rng.integers(1, 100, size=10)

print(numbers)
```

This is preferable for new code over repeatedly relying on older global random-state functions.

---

# 54. Reproducible Random Numbers

```python
rng = np.random.default_rng(42)

print(rng.integers(1, 100, 5))
```

Using the same seed gives reproducible results.

Useful for:

- Machine learning
- Testing
- Simulations
- Assignments

---

# 55. `choice()`

Choose random values:

```python
arr = np.array(["Python", "Java", "SQL", "C++"])

rng = np.random.default_rng(42)

rng.choice(arr)
```

Multiple values:

```python
rng.choice(arr, size=3)
```

---

# 56. Saving NumPy Arrays

Save:

```python
np.save("data.npy", arr)
```

Load:

```python
arr = np.load("data.npy")
```

---

# 57. Saving Multiple Arrays

```python
np.savez("data.npz", a=a, b=b)
```

Load:

```python
data = np.load("data.npz")

print(data["a"])
print(data["b"])
```

---

# 58. Reading CSV

NumPy can read simple numerical CSV data:

```python
data = np.loadtxt("data.csv", delimiter=",")
```

For CSV files with missing values, headers, mixed types, etc., **Pandas is generally more appropriate**.

---

# 59. `loadtxt()` vs `genfromtxt()`

```python
np.loadtxt()
```

works well with clean numerical data.

```python
np.genfromtxt()
```

handles missing values more flexibly.

Example:

```python
data = np.genfromtxt(
    "data.csv",
    delimiter=",",
    skip_header=1
)
```

---

# 60. `meshgrid()`

Useful for mathematical functions and visualization.

```python
x = np.arange(0, 5)
y = np.arange(0, 5)

X, Y = np.meshgrid(x, y)
```

It creates coordinate grids.

Useful with:

- Matplotlib
- Mathematical modeling
- 3D visualization
- Numerical simulations

---

# 61. Dates and NumPy

NumPy supports date/time types:

```python
date = np.datetime64("2026-09-08")

print(date)
```

Date arithmetic:

```python
date + np.timedelta64(7, "D")
```

Result:

```text
2026-09-15
```

---

# 62. Structured Arrays

NumPy can store multiple fields in a structured array.

```python
data = np.array([
    ("Alice", 25),
    ("Bob", 30)
], dtype=[
    ("name", "U10"),
    ("age", "i4")
])
```

Access:

```python
data["name"]
```

or:

```python
data["age"]
```

For general tabular data, Pandas is usually the better choice.

---

# 63. NumPy Function Cheat Sheet

## Array Creation

```python
np.array()
np.zeros()
np.ones()
np.full()
np.empty()
np.eye()
np.arange()
np.linspace()
```

## Inspection

```python
arr.ndim
arr.shape
arr.size
arr.dtype
arr.itemsize
```

## Manipulation

```python
reshape()
flatten()
ravel()
transpose()
.T
resize()
```

## Joining

```python
np.concatenate()
np.vstack()
np.hstack()
np.stack()
```

## Splitting

```python
np.split()
np.vsplit()
np.hsplit()
```

## Statistics

```python
np.sum()
np.mean()
np.median()
np.std()
np.var()
np.min()
np.max()
np.percentile()
```

## Searching

```python
np.where()
np.nonzero()
np.argmax()
np.argmin()
np.unique()
```

## Mathematical

```python
np.sqrt()
np.abs()
np.exp()
np.log()
np.power()
np.sin()
np.cos()
```

## Linear Algebra

```python
np.dot()
np.matmul()
np.linalg.det()
np.linalg.inv()
np.linalg.eig()
np.linalg.solve()
```

## Random

```python
np.random.default_rng()
rng.integers()
rng.random()
rng.normal()
rng.choice()
```

---

# 64. NumPy Problem-Solving Pattern

For coding-test preparation, learn to recognize this pattern:

```python
import numpy as np

data = np.array([...])
```

Then ask:

### 1. What is the shape?

```python
data.shape
```

### 2. What are the dimensions?

```python
data.ndim
```

### 3. Do I need filtering?

```python
data[data > value]
```

### 4. Do I need aggregation?

```python
np.sum(data)
np.mean(data)
np.max(data)
```

### 5. Do I need row/column operations?

```python
np.sum(data, axis=0)
np.sum(data, axis=1)
```

### 6. Do I need transformation?

```python
data.reshape(...)
```

### 7. Do I need sorting?

```python
np.sort(data)
```

### 8. Do I need unique values?

```python
np.unique(data)
```

### 9. Do I need indices?

```python
np.argmax(data)
np.argmin(data)
np.where(...)
```

---

# 65. Practical Problem 1 — Student Marks

```python
import numpy as np

marks = np.array([45, 67, 89, 32, 76, 91, 55])

print("Average:", np.mean(marks))
print("Highest:", np.max(marks))
print("Lowest:", np.min(marks))

passed = marks[marks >= 50]

print("Passed:", passed)
print("Number passed:", len(passed))
```

---

# 66. Practical Problem 2 — Employee Salaries

```python
import numpy as np

salary = np.array([25000, 32000, 45000, 28000, 60000])

salary_after_hike = salary * 1.10

print(salary_after_hike)
```

Everyone gets a 10% increment.

---

# 67. Practical Problem 3 — Sales Analysis

```python
sales = np.array([
    [100, 200, 300],
    [150, 250, 350],
    [120, 220, 320]
])
```

Total sales:

```python
np.sum(sales)
```

Sales by month:

```python
np.sum(sales, axis=0)
```

Sales by salesperson:

```python
np.sum(sales, axis=1)
```

Highest sale:

```python
np.max(sales)
```

---

# 68. Practical Problem 4 — Find Top Scores

```python
marks = np.array([45, 90, 76, 88, 95, 67])

sorted_marks = np.sort(marks)[::-1]

print(sorted_marks)
```

Output:

```text
[95 90 88 76 67 45]
```

Top 3:

```python
sorted_marks[:3]
```

---

# 69. Practical Problem 5 — Remove Duplicates

```python
numbers = np.array([
    10, 20, 20, 30, 40, 40, 40, 50
])

unique_numbers = np.unique(numbers)

print(unique_numbers)
```

---

# 70. Practical Problem 6 — Find Even Numbers

```python
numbers = np.array([10, 15, 22, 33, 40, 51])

even = numbers[numbers % 2 == 0]

print(even)
```

Output:

```text
[10 22 40]
```

---

# 71. Practical Problem 7 — Normalize Data

Given:

```python
data = np.array([10, 20, 30, 40, 50])
```

Min-max normalization:

```python
normalized = (
    data - np.min(data)
) / (
    np.max(data) - np.min(data)
)

print(normalized)
```

Result:

```text
[0.   0.25 0.5  0.75 1.  ]
```

This concept is frequently used in machine learning.

---

# 72. Practical Problem 8 — Find Missing Values

```python
data = np.array([10, 20, np.nan, 40, np.nan])

missing = np.isnan(data)

print(missing)
```

Count missing:

```python
np.sum(np.isnan(data))
```

---

# 73. Practical Problem 9 — Replace Missing Values

```python
data = np.array([10, 20, np.nan, 40, np.nan])

mean = np.nanmean(data)

data[np.isnan(data)] = mean

print(data)
```

---

# 74. Practical Problem 10 — Student Result Matrix

Imagine:

```text
             Python SQL Math
Student 1     80    70   90
Student 2     60    85   75
Student 3     95    90   92
```

Create:

```python
marks = np.array([
    [80, 70, 90],
    [60, 85, 75],
    [95, 90, 92]
])
```

Student averages:

```python
np.mean(marks, axis=1)
```

Subject averages:

```python
np.mean(marks, axis=0)
```

Highest score:

```python
np.max(marks)
```

---

# 75. Complete Example

This example combines many NumPy concepts:

```python
import numpy as np

marks = np.array([
    [78, 85, 90],
    [45, 67, 55],
    [92, 88, 95],
    [60, 72, 68]
])

# Shape
print("Shape:", marks.shape)

# Student averages
student_avg = np.mean(marks, axis=1)

print("Student averages:")
print(student_avg)

# Subject averages
subject_avg = np.mean(marks, axis=0)

print("Subject averages:")
print(subject_avg)

# Highest score
print("Highest:", np.max(marks))

# Lowest score
print("Lowest:", np.min(marks))

# Students whose average >= 70
passed = student_avg >= 70

print("Students scoring >= 70:")
print(passed)

# Add 5 bonus marks
updated_marks = marks + 5

print("Updated marks:")
print(updated_marks)

# Maximum score location
position = np.unravel_index(
    np.argmax(marks),
    marks.shape
)

print("Highest score position:", position)
```

This covers:

```text
array
shape
axis
mean
max
min
Boolean masking
broadcasting
argmax
multidimensional arrays
```

---

# 76. NumPy vs Python List

| Feature | Python List | NumPy Array |
|---|---|---|
| Numerical operations | Slower | Faster |
| Element-wise operations | Limited | Excellent |
| Memory efficiency | Lower | Better |
| Multidimensional | Nested lists | Native |
| Broadcasting | No | Yes |
| Mathematical functions | Limited | Extensive |
| Linear algebra | No native support | Yes |
| Scientific computing | Not ideal | Excellent |

---

# 77. NumPy vs Pandas

### NumPy

Best for:

```text
Numerical arrays
Matrices
Mathematical calculations
Linear algebra
Numerical algorithms
```

### Pandas

Best for:

```text
Tables
CSV/Excel
Rows and columns
Missing data
Data cleaning
Data analysis
```

Think:

```text
NumPy
   ↓
Numerical engine

Pandas
   ↓
Tabular data analysis
```

Pandas itself is heavily built around NumPy concepts.

---

# 78. NumPy Learning Ladder

For Python preparation, learn NumPy in this order:

```text
LEVEL 1
│
├── np.array()
├── ndim
├── shape
├── size
└── dtype

        ↓

LEVEL 2
│
├── zeros()
├── ones()
├── arange()
├── linspace()
└── random

        ↓

LEVEL 3
│
├── Indexing
├── Slicing
├── Boolean filtering
└── where()

        ↓

LEVEL 4
│
├── sum()
├── mean()
├── min()
├── max()
├── std()
└── axis

        ↓

LEVEL 5
│
├── reshape()
├── flatten()
├── transpose()
├── concatenate()
├── stack()
└── split()

        ↓

LEVEL 6
│
├── Broadcasting
├── Vectorization
├── Boolean masking
└── ufuncs

        ↓

LEVEL 7
│
├── Matrix multiplication
├── np.linalg
├── Random generation
└── Missing values

        ↓

LEVEL 8
│
├── NumPy + Pandas
├── NumPy + Matplotlib
└── NumPy + Machine Learning
```

---

# 79. The 20 NumPy Commands to Memorize

If you're preparing for a test, master these first:

```python
np.array()
np.zeros()
np.ones()
np.arange()
np.linspace()

arr.shape
arr.ndim
arr.size
arr.dtype

arr.reshape()
arr.flatten()
arr.T

np.sum()
np.mean()
np.min()
np.max()
np.std()

np.sort()
np.unique()
np.where()
```

And master these **five concepts**:

1. Indexing
2. Slicing
3. Boolean masking
4. Axis
5. Broadcasting

These five concepts are more important than memorizing dozens of functions.

---

# 80. NumPy Mental Model

When you see:

```python
arr = np.array(...)
```

think:

```text
ARRAY
 │
 ├── What type?       → dtype
 ├── How many dims?   → ndim
 ├── What size?       → shape
 ├── How many items?  → size
 │
 ├── Access            → indexing
 ├── Select            → slicing / masking
 ├── Calculate         → vectorization
 ├── Summarize         → aggregation
 ├── Transform         → reshape
 ├── Combine           → concatenate / stack
 ├── Compare           → conditions
 └── Matrix operations → linalg / @
```

## The biggest transition to make

Don't think:

```python
for every number:
    calculate something
```

Start thinking:

```text
array operation
      ↓
vectorized calculation
      ↓
result
```

For example, instead of:

```python
result = []

for x in numbers:
    result.append(x * 2)
```

think:

```python
result = numbers * 2
```

That shift is the **heart of NumPy**.

---

# 81. Quick Revision Sheet

## Create

```python
np.array()
np.zeros()
np.ones()
np.full()
np.eye()
np.arange()
np.linspace()
```

## Inspect

```python
arr.ndim
arr.shape
arr.size
arr.dtype
```

## Access

```python
arr[index]
arr[row, column]
arr[start:stop]
arr[:, column]
arr[row, :]
```

## Filter

```python
arr[arr > 10]
arr[(arr > 10) & (arr < 50)]
np.where(condition)
```

## Calculate

```python
np.sum()
np.mean()
np.min()
np.max()
np.std()
np.var()
```

## Transform

```python
arr.reshape()
arr.flatten()
arr.ravel()
arr.T
```

## Combine

```python
np.concatenate()
np.vstack()
np.hstack()
np.stack()
```

## Search

```python
np.where()
np.unique()
np.argmax()
np.argmin()
```

## Math

```python
np.sqrt()
np.abs()
np.exp()
np.log()
np.power()
```

## Linear Algebra

```python
A @ B
np.matmul()
np.linalg.det()
np.linalg.inv()
np.linalg.solve()
```

## Random

```python
rng = np.random.default_rng(42)
rng.integers()
rng.random()
rng.normal()
rng.choice()
```

---

# 82. Recommended Practice Strategy

### Day 1 — Basics

Practice:

```text
array()
zeros()
ones()
arange()
linspace()
shape
ndim
size
dtype
```

### Day 2 — Accessing Data

Practice:

```text
indexing
slicing
2D indexing
2D slicing
modifying values
```

### Day 3 — Calculations

Practice:

```text
sum
mean
min
max
std
var
argmax
argmin
```

### Day 4 — Conditions

Practice:

```text
Boolean masking
where()
multiple conditions
filtering
```

### Day 5 — Reshaping

Practice:

```text
reshape
flatten
ravel
transpose
concatenate
stack
split
```

### Day 6 — Advanced

Practice:

```text
broadcasting
vectorization
ufuncs
copy vs view
random
nan
```

### Day 7 — Coding Problems

Solve problems involving:

```text
marks
salary
sales
temperature
attendance
expenses
student matrices
employee data
random data
statistics
```

---

# Final NumPy Formula

The core of NumPy can be remembered as:

```text
CREATE
   ↓
INSPECT
   ↓
INDEX / SLICE
   ↓
FILTER
   ↓
CALCULATE
   ↓
RESHAPE
   ↓
AGGREGATE
   ↓
COMBINE
   ↓
ANALYZE
```

Once these concepts are comfortable, move to:

```text
Python
   ↓
NumPy
   ↓
Pandas
   ↓
Matplotlib / Seaborn
   ↓
Data Analysis
   ↓
Machine Learning
```
