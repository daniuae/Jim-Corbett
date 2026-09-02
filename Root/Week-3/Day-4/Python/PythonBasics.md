# 🐍 Python Coding Tutorial & Study Material

## Python Basics → NumPy → Pandas → OOP → Problem Solving

> **Purpose:** A practical study guide based on learner feedback.
>
> **Learning philosophy:** `Understand → See → Code → Practice → Debug → Apply`

---

# 📚 Learning Roadmap

```text
PYTHON FUNDAMENTALS
        ↓
Variables & Data Types
        ↓
Operators
        ↓
Conditions
        ↓
Loops
        ↓
Data Structures
        ↓
Comprehensions
        ↓
Functions
        ↓
Problem Solving
        ↓
NUMPY
        ↓
PANDAS
        ↓
OOP
        ↓
SCENARIO / MILESTONE PROBLEMS
```

# 🎯 How to Use This Material

For every topic:

1. Understand the concept.
2. Type the examples yourself.
3. Predict the output before running the code.
4. Change the example.
5. Solve the practice questions without looking at the solution.
6. Debug your mistakes.
7. Attempt the scenario problem.

> **Golden rule:** Reading Python does not make you good at Python. Writing Python does.

---

# PART 1 — PYTHON BASICS

## 1. What Is Python?

Python is a general-purpose programming language known for readable syntax and a large ecosystem of libraries.

It is commonly used for:

- Data analysis
- Automation
- Web applications
- Machine learning
- APIs
- Testing
- Data engineering

```python
name = "Dani"
age = 25

print(name)
print(age)
```

---

## 2. Variables

A variable is a name used to refer to a value.

```python
name = "John"
age = 30
salary = 50000.50
```

Think of variables as labelled boxes:

```text
name   ──→ "John"
age    ──→ 30
salary ──→ 50000.50
```

Python determines the type dynamically.

```python
x = 10
print(type(x))
```

---

## 3. Python Data Types

| Type | Example | Meaning |
|---|---|---|
| `int` | `10` | Integer |
| `float` | `10.5` | Decimal |
| `str` | `"Python"` | Text |
| `bool` | `True` | Boolean |
| `list` | `[1, 2, 3]` | Ordered, mutable collection |
| `tuple` | `(1, 2, 3)` | Ordered, immutable collection |
| `set` | `{1, 2, 3}` | Unique values |
| `dict` | `{"id": 101}` | Key-value pairs |
| `None` | `None` | No value |

```python
student_name = "Rahul"
age = 22
percentage = 85.5
passed = True

print(type(student_name))
print(type(age))
print(type(percentage))
print(type(passed))
```

---

## 4. Type Conversion

Changing one data type into another is called type conversion.

```python
x = "100"

print(type(x))

x = int(x)

print(type(x))
print(x + 50)
```

Common conversions:

```python
int("10")
float("10.5")
str(100)
bool(1)
```

### Common Problem

```python
age = input("Enter age: ")
print(age + 5)
```

This fails because `input()` returns a string.

Correct:

```python
age = int(input("Enter age: "))
print(age + 5)
```

---

## 5. Operators

### Arithmetic

```python
a = 10
b = 3

print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a // b)
print(a % b)
print(a ** b)
```

| Operator | Meaning |
|---|---|
| `/` | Division |
| `//` | Floor division |
| `%` | Remainder |
| `**` | Power |

### Comparison

```python
a = 10
b = 20

print(a == b)
print(a != b)
print(a > b)
print(a < b)
print(a >= b)
print(a <= b)
```

### Logical

```python
age = 25
salary = 60000

print(age > 21 and salary > 50000)
print(age > 30 or salary > 50000)
print(not(age > 30))
```

Remember:

```text
and → both conditions must be True
or  → at least one condition must be True
not → reverses the result
```

---

## 6. Conditional Statements

```python
marks = 75

if marks >= 50:
    print("Pass")
else:
    print("Fail")
```

Multiple conditions:

```python
marks = 85

if marks >= 90:
    grade = "A+"
elif marks >= 80:
    grade = "A"
elif marks >= 70:
    grade = "B"
else:
    grade = "C"

print(grade)
```

### Problem-Solving Pattern

```text
What condition am I checking?
        ↓
What happens if True?
        ↓
What happens if False?
```

---

## 7. Loops

### `for`

```python
for i in range(5):
    print(i)
```

Output:

```text
0
1
2
3
4
```

Example:

```python
names = ["Asha", "Ravi", "John"]

for name in names:
    print(name)
```

### `while`

```python
count = 1

while count <= 5:
    print(count)
    count += 1
```

---

## 8. `break`, `continue`, `pass`

### `break`

```python
for number in range(1, 10):
    if number == 5:
        break
    print(number)
```

### `continue`

```python
for number in range(1, 6):
    if number == 3:
        continue
    print(number)
```

### `pass`

```python
for number in range(5):
    pass
```

---

## 9. Lists

```python
numbers = [10, 20, 30, 40]

print(numbers[0])
print(numbers[-1])
```

Modify:

```python
numbers.append(50)
numbers.remove(20)
```

Useful methods:

```text
append()
extend()
insert()
remove()
pop()
sort()
reverse()
count()
index()
```

Example:

```python
numbers = [40, 10, 30, 20]
numbers.sort()

print(numbers)
```

---

## 10. Tuples

Tuples are ordered and immutable.

```python
point = (10, 20)

print(point[0])
```

Use tuples when values should not normally be changed.

---

## 11. Sets

Sets store unique values.

```python
numbers = {10, 20, 20, 30}

print(numbers)
```

Set operations:

```python
a = {1, 2, 3}
b = {3, 4, 5}

print(a.union(b))
print(a.intersection(b))
print(a.difference(b))
```

---

## 12. Dictionaries

Dictionaries store key-value pairs.

```python
student = {
    "id": 101,
    "name": "Asha",
    "marks": 85
}

print(student["name"])
```

Update:

```python
student["marks"] = 90
student["city"] = "Mumbai"
```

Loop:

```python
for key, value in student.items():
    print(key, value)
```

Useful methods:

```text
keys()
values()
items()
get()
update()
pop()
```

---

## 13. Comprehensions

### List comprehension

Traditional:

```python
squares = []

for number in range(1, 6):
    squares.append(number ** 2)
```

Compact:

```python
squares = [number ** 2 for number in range(1, 6)]
```

With condition:

```python
even_numbers = [
    number
    for number in range(1, 11)
    if number % 2 == 0
]
```

### Dictionary comprehension

```python
squares = {
    number: number ** 2
    for number in range(1, 6)
}
```

### Set comprehension

```python
unique_lengths = {
    len(name)
    for name in ["John", "Asha", "Ravi", "John"]
}
```

---

## 14. Strings

```python
name = "Python Programming"

print(name.lower())
print(name.upper())
print(name.title())
print(name.replace("Python", "Data"))
print(name.split())
```

Indexing and slicing:

```python
print(name[0])
print(name[-1])
print(name[0:6])
```

---

## 15. Functions

Functions are reusable blocks of code.

```python
def greet():
    print("Hello")

greet()
```

### Parameters and Arguments

```python
def greet(name):
    print("Hello", name)

greet("Asha")
```

Here:

```text
name    → parameter
"Asha"  → argument
```

### Return Value

```python
def add(a, b):
    return a + b

result = add(10, 20)

print(result)
```

### Function Execution Model

```text
Function definition
        ↓
Function call
        ↓
Arguments assigned to parameters
        ↓
Function body executes
        ↓
return value
        ↓
Result received by caller
```

### Default Argument

```python
def greet(name="Guest"):
    print("Hello", name)

greet()
greet("Asha")
```

---

## 16. Exception Handling

```python
try:
    number = int(input("Enter number: "))
    print(100 / number)
except ValueError:
    print("Please enter a valid number.")
except ZeroDivisionError:
    print("Cannot divide by zero.")
```

Pattern:

```text
try
 ↓
Risky code
 ↓
except
 ↓
Handle error
```

---

# PART 2 — NUMPY

## 17. What Is NumPy?

NumPy is a Python library for numerical computing.

It provides:

- Arrays
- Fast numerical operations
- Mathematical functions
- Aggregations
- Reshaping
- Indexing and slicing
- Linear algebra functionality

```python
import numpy as np
```

---

## 18. Python List vs NumPy Array

Python:

```python
numbers = [1, 2, 3]
```

NumPy:

```python
numbers = np.array([1, 2, 3])
```

Vectorized operation:

```python
numbers = np.array([1, 2, 3])

print(numbers * 10)
```

Output:

```text
[10 20 30]
```

---

## 19. Creating NumPy Arrays

```python
a = np.array([1, 2, 3])
b = np.array([[1, 2], [3, 4]])
```

Useful constructors:

```python
np.zeros(5)
np.ones(5)
np.arange(1, 10)
np.linspace(0, 1, 5)
```

---

## 20. Array Attributes

```python
arr = np.array([[1, 2, 3], [4, 5, 6]])

print(arr.ndim)
print(arr.shape)
print(arr.size)
print(arr.dtype)
```

| Attribute | Meaning |
|---|---|
| `ndim` | Number of dimensions |
| `shape` | Dimensions of array |
| `size` | Total elements |
| `dtype` | Data type |

---

## 21. Indexing and Slicing

```python
arr = np.array([10, 20, 30, 40, 50])

print(arr[0])
print(arr[1:4])
```

2D:

```python
matrix = np.array([
    [10, 20, 30],
    [40, 50, 60]
])

print(matrix[0, 1])
print(matrix[:, 1])
```

---

## 22. Vectorized Operations

```python
prices = np.array([100, 200, 300])

discounted = prices * 0.9

print(discounted)
```

---

## 23. Aggregations

```python
numbers = np.array([10, 20, 30, 40, 50])

print(np.sum(numbers))
print(np.mean(numbers))
print(np.min(numbers))
print(np.max(numbers))
print(np.std(numbers))
```

---

## 24. Boolean Filtering

```python
numbers = np.array([10, 20, 30, 40, 50])

result = numbers[numbers > 25]

print(result)
```

Mental model:

```text
Condition
   ↓
True / False mask
   ↓
Select matching values
```

---

## 25. Reshaping

```python
numbers = np.arange(1, 7)

matrix = numbers.reshape(2, 3)

print(matrix)
```

The total number of elements must remain the same.

---

## 26. NumPy Practice

### Beginner

1. Create an array containing numbers 1–10.
2. Find the sum.
3. Find the average.
4. Extract numbers greater than 5.
5. Multiply every value by 10.

### Intermediate

6. Create a 3 × 3 matrix.
7. Extract the second row.
8. Extract the third column.
9. Find the maximum value in each row.
10. Reshape a 1D array into a 2D array.

### Scenario

```python
sales = np.array([120, 150, 90, 200, 175, 80, 220])
```

Find:

- Total sales
- Average sales
- Highest sales
- Days where sales exceeded 150
- Sales after a 10% increase

---

# PART 3 — PANDAS

## 27. What Is Pandas?

Pandas is a Python library for working with structured and tabular data.

Think:

```text
Excel Table
     ↓
Pandas DataFrame
```

Typical workflow:

```text
Load
 ↓
Inspect
 ↓
Clean
 ↓
Filter
 ↓
Transform
 ↓
Group
 ↓
Aggregate
 ↓
Merge
 ↓
Analyze
```

```python
import pandas as pd
```

---

## 28. Series

A Series is similar to a single column.

```python
sales = pd.Series([100, 200, 300])

print(sales)
```

---

## 29. DataFrame

A DataFrame is a table.

```python
data = {
    "Name": ["Asha", "Ravi", "John"],
    "Age": [22, 25, 30],
    "Salary": [40000, 50000, 70000]
}

df = pd.DataFrame(data)

print(df)
```

---

## 30. Inspecting Data

```python
df.head()
df.tail()
df.shape
df.columns
df.dtypes
df.info()
df.describe()
```

| Operation | Meaning |
|---|---|
| `head()` | First rows |
| `tail()` | Last rows |
| `shape` | Rows and columns |
| `columns` | Column names |
| `dtypes` | Data types |
| `info()` | Structure and missing values |
| `describe()` | Numerical summary |

---

## 31. Selecting Columns

Single:

```python
df["Salary"]
```

Multiple:

```python
df[["Name", "Salary"]]
```

---

## 32. Filtering Rows

```python
df[df["Salary"] > 50000]
```

Multiple conditions:

```python
df[
    (df["Age"] > 25) &
    (df["Salary"] > 50000)
]
```

Remember:

```text
& → AND
| → OR
~ → NOT
```

---

## 33. Sorting

```python
df.sort_values("Salary")
```

Descending:

```python
df.sort_values("Salary", ascending=False)
```

Multiple columns:

```python
df.sort_values(
    ["Age", "Salary"],
    ascending=[True, False]
)
```

---

## 34. Calculated Columns

```python
df["AnnualBonus"] = df["Salary"] * 0.10

df["TotalCompensation"] = (
    df["Salary"] + df["AnnualBonus"]
)
```

---

## 35. GroupBy

Example:

```python
data = {
    "Department": ["IT", "IT", "HR", "HR", "Sales"],
    "Employee": ["A", "B", "C", "D", "E"],
    "Salary": [50000, 60000, 45000, 55000, 70000]
}

df = pd.DataFrame(data)
```

Average salary by department:

```python
df.groupby("Department")["Salary"].mean()
```

Mental model:

```text
GROUP BY Department
        ↓
Create groups
        ↓
Calculate aggregate
```

---

## 36. Aggregation

```python
df.groupby("Department")["Salary"].agg(
    ["count", "sum", "mean", "min", "max"]
)
```

Common aggregations:

```text
count
sum
mean
min
max
median
std
```

---

## 37. `size()` vs `count()`

### `size()`

Counts rows in each group.

```python
df.groupby("Department").size()
```

### `count()`

Counts non-null values in a selected column.

```python
df.groupby("Department")["Salary"].count()
```

Mental model:

```text
size()
  → How many rows?

count()
  → How many non-missing values?
```

---

## 38. Missing Values

Check:

```python
df.isna()
df.isna().sum()
```

Fill:

```python
df["Salary"] = df["Salary"].fillna(0)
```

Drop:

```python
df.dropna()
```

---

## 39. `loc` and `iloc`

### `loc`

Label/condition based:

```python
df.loc[0, "Name"]

df.loc[
    df["Salary"] > 50000,
    ["Name", "Salary"]
]
```

### `iloc`

Position based:

```python
df.iloc[0, 1]
```

Remember:

```text
loc  → labels / conditions
iloc → integer positions
```

---

## 40. Merge

```python
customers = pd.DataFrame({
    "CustomerID": [1, 2, 3],
    "Name": ["Asha", "Ravi", "John"]
})

orders = pd.DataFrame({
    "CustomerID": [1, 2, 1],
    "Amount": [500, 700, 300]
})

result = customers.merge(
    orders,
    on="CustomerID",
    how="inner"
)
```

SQL equivalent:

```sql
SELECT *
FROM customers c
JOIN orders o
  ON c.CustomerID = o.CustomerID;
```

---

## 41. Merge Types

| SQL | Pandas |
|---|---|
| INNER JOIN | `how="inner"` |
| LEFT JOIN | `how="left"` |
| RIGHT JOIN | `how="right"` |
| FULL OUTER JOIN | `how="outer"` |

---

## 42. Pivot Tables

```python
df.pivot_table(
    index="Department",
    values="Salary",
    aggfunc="mean"
)
```

Think:

```text
Raw Data
   ↓
Group dimensions
   ↓
Calculate metric
   ↓
Business summary
```

---

## 43. `apply()`

```python
def salary_band(salary):
    if salary >= 60000:
        return "High"
    elif salary >= 50000:
        return "Medium"
    else:
        return "Low"

df["SalaryBand"] = df["Salary"].apply(salary_band)
```

Use `apply()` when custom row/value logic is required and a direct vectorized expression is not a better fit.

---

## 44. Pandas End-to-End Workflow

```text
Create / Load Data
        ↓
head()
        ↓
info()
        ↓
Check missing values
        ↓
Clean
        ↓
Filter
        ↓
Create calculated columns
        ↓
GroupBy
        ↓
Aggregation
        ↓
Merge
        ↓
Pivot
        ↓
Sort
        ↓
Business Insight
```

---

## 45. Pandas Scenario

```python
sales = pd.DataFrame({
    "Employee": ["A", "B", "C", "A", "B"],
    "Region": ["West", "East", "West", "West", "East"],
    "Sales": [1000, 1500, 1200, 800, 1700]
})
```

Answer:

1. Find total sales.
2. Find average sales.
3. Find sales by employee.
4. Find sales by region.
5. Find the highest-performing employee.
6. Filter sales greater than 1200.
7. Sort employees by sales.
8. Create a performance category.
9. Create a pivot table by region.
10. Write one business insight.

---

# PART 4 — OBJECT-ORIENTED PROGRAMMING

## 46. What Is OOP?

Object-Oriented Programming organizes programs around objects.

An object contains:

```text
Data
 +
Behavior
```

Example:

```text
Bank Account

Data:
    account_number
    balance
    owner

Behavior:
    deposit()
    withdraw()
    check_balance()
```

---

## 47. Class vs Object

A class is a blueprint.

An object is an instance created from the class.

```python
class Student:
    pass

student1 = Student()
student2 = Student()
```

```text
Student  → class
student1 → object
student2 → object
```

---

## 48. Constructor — `__init__`

```python
class Student:

    def __init__(self, name, marks):
        self.name = name
        self.marks = marks

student1 = Student("Asha", 85)

print(student1.name)
print(student1.marks)
```

---

## 49. What Is `self`?

`self` refers to the current object.

```python
class Student:

    def __init__(self, name):
        self.name = name
```

When:

```python
student1 = Student("Asha")
```

the object stores its own `name`.

```text
student1
   ↓
self
   ↓
name = "Asha"
```

---

## 50. Instance Methods

```python
class Student:

    def __init__(self, name, marks):
        self.name = name
        self.marks = marks

    def display(self):
        print(self.name, self.marks)

student = Student("Asha", 85)
student.display()
```

---

## 51. Encapsulation

Encapsulation means keeping data and behavior together and controlling how data is accessed.

```python
class BankAccount:

    def __init__(self, balance):
        self._balance = balance

    def deposit(self, amount):
        if amount > 0:
            self._balance += amount

    def get_balance(self):
        return self._balance
```

---

## 52. Inheritance

Inheritance allows a class to reuse or extend another class.

```python
class Animal:

    def speak(self):
        print("Animal makes a sound")


class Dog(Animal):

    def bark(self):
        print("Dog barks")

dog = Dog()

dog.speak()
dog.bark()
```

```text
Animal
  ↓
Dog
```

---

## 53. Polymorphism

Different objects can respond to the same method name differently.

```python
class Dog:

    def speak(self):
        print("Bark")


class Cat:

    def speak(self):
        print("Meow")


animals = [Dog(), Cat()]

for animal in animals:
    animal.speak()
```

Same interface:

```text
speak()
```

Different behavior.

---

## 54. Abstraction

Abstraction means exposing what an object should do while hiding unnecessary implementation details.

Conceptually:

```text
User
 ↓
withdraw()
 ↓
System handles internal details
```

---

## 55. Four Major OOP Concepts

| Concept | Simple Meaning |
|---|---|
| Encapsulation | Bundle/control data and behavior |
| Inheritance | Reuse/extend another class |
| Polymorphism | Same interface, different behavior |
| Abstraction | Hide unnecessary implementation detail |

---

# PART 5 — DEBUGGING

## 56. Debugging Workflow

Do not randomly change code.

```text
Read the error
      ↓
Find the line
      ↓
Understand the error type
      ↓
Inspect variables
      ↓
Check assumptions
      ↓
Fix one thing
      ↓
Run again
```

---

## 57. Common Errors

### SyntaxError

```python
if x > 5
    print(x)
```

Missing `:`.

### NameError

```python
print(total)
```

when `total` was never defined.

### TypeError

```python
"10" + 5
```

### ValueError

```python
int("hello")
```

### IndexError

```python
numbers = [1, 2, 3]
print(numbers[10])
```

### KeyError

```python
student = {"name": "Asha"}
print(student["age"])
```

---

# PART 6 — SQL → PYTHON / PANDAS BRIDGE

## 58. SELECT

SQL:

```sql
SELECT Name, Salary
FROM employees;
```

Pandas:

```python
df[["Name", "Salary"]]
```

## 59. WHERE

SQL:

```sql
SELECT *
FROM employees
WHERE Salary > 50000;
```

Pandas:

```python
df[df["Salary"] > 50000]
```

## 60. GROUP BY

SQL:

```sql
SELECT Department, AVG(Salary)
FROM employees
GROUP BY Department;
```

Pandas:

```python
df.groupby("Department")["Salary"].mean()
```

## 61. ORDER BY

SQL:

```sql
SELECT *
FROM employees
ORDER BY Salary DESC;
```

Pandas:

```python
df.sort_values(
    "Salary",
    ascending=False
)
```

## 62. JOIN

SQL:

```sql
SELECT *
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID;
```

Pandas:

```python
customers.merge(
    orders,
    on="CustomerID",
    how="inner"
)
```

### Quick Mapping

| SQL | Pandas |
|---|---|
| `SELECT` | Column selection |
| `WHERE` | Boolean filtering |
| `GROUP BY` | `groupby()` |
| `COUNT()` | `count()` / `size()` |
| `ORDER BY` | `sort_values()` |
| `JOIN` | `merge()` |
| `CASE WHEN` | `np.where()` / `apply()` |

---

# PART 7 — PROBLEM-SOLVING STRATEGY

## 63. The 10-Step Method

```text
1. Read the problem
       ↓
2. Identify inputs
       ↓
3. Identify expected output
       ↓
4. Identify constraints
       ↓
5. Choose data structure
       ↓
6. Break into smaller steps
       ↓
7. Write pseudocode
       ↓
8. Write code
       ↓
9. Test normal + edge cases
       ↓
10. Refactor
```

### Example

**Problem:** Find the largest number in a list.

```python
numbers = [10, 45, 23, 89, 12]

largest = numbers[0]

for number in numbers:
    if number > largest:
        largest = number

print(largest)
```

Think:

```text
Start with first value
        ↓
Compare each value
        ↓
Keep the largest
        ↓
Print result
```

---

# PART 8 — PRACTICE SET

## 64. Python

### Beginner

1. Print numbers 1–10.
2. Check whether a number is even or odd.
3. Find the largest of two numbers.
4. Calculate the sum of a list.
5. Count vowels in a string.

### Intermediate

6. Find the second-largest number.
7. Remove duplicates from a list.
8. Count the frequency of each element.
9. Reverse a string without using `reverse()`.
10. Find common values between two lists.

### Scenario

11. Given employee salaries, classify employees into salary bands.
12. Given transaction amounts, calculate total, average and maximum.
13. Given customer purchases, identify customers above a threshold.
14. Given orders, calculate number of orders per customer.
15. Given student marks, calculate grade and pass/fail.

---

## 65. NumPy

1. Create an array of 1–20.
2. Find even values.
3. Find values greater than the mean.
4. Calculate min, max, mean and standard deviation.
5. Reshape 12 values into a 3 × 4 matrix.
6. Find row-wise sums.
7. Find column-wise averages.
8. Apply a 10% increase to prices.
9. Identify values outside a specified range.
10. Analyze weekly sales.

---

## 66. Pandas

1. Create a DataFrame.
2. Inspect its structure.
3. Select one and multiple columns.
4. Filter rows.
5. Sort values.
6. Create a calculated column.
7. Handle missing values.
8. Group by one column.
9. Perform multiple aggregations.
10. Merge two DataFrames.
11. Create a pivot table.
12. Use `apply()` for business rules.
13. Build a complete analysis pipeline.
14. Extract a business insight.

---

## 67. OOP

### Beginner

1. Create a `Student` class.
2. Add name and marks.
3. Create a display method.
4. Create a method to calculate grade.

### Intermediate

5. Create a `BankAccount` class.
6. Implement deposit.
7. Implement withdrawal.
8. Prevent invalid withdrawals.
9. Add balance checking.

### Advanced

10. Create an `Employee` base class.
11. Create `Manager` and `Developer` subclasses.
12. Override a common method.
13. Demonstrate polymorphism.
14. Build a small employee-management system.

---

# 🏆 PART 9 — CAPSTONE PROJECT

## Employee Sales Analytics System

Use **Python + NumPy + Pandas + OOP**.

### Data

Create employee sales data containing:

```text
EmployeeID
EmployeeName
Department
Region
MonthlySales
```

### Python Requirements

- Validate input
- Write reusable functions
- Calculate performance category

### NumPy Requirements

- Total sales
- Average sales
- Maximum sales
- Employees above average

### Pandas Requirements

- Create DataFrame
- Inspect data
- Filter employees
- Group by department
- Group by region
- Multiple aggregations
- Sort
- Calculated columns
- Missing values
- Merge another DataFrame
- Pivot table

### OOP Requirements

Create:

```python
class Employee:
    ...
```

Include:

```text
Employee details
Sales
Performance
Display method
```

---

# 🧠 CAPSTONE THINKING PROCESS

Do not begin by writing 100 lines of code.

```text
Requirement
    ↓
Data Model
    ↓
Python Functions
    ↓
NumPy Calculations
    ↓
Pandas Analysis
    ↓
OOP Design
    ↓
Validation
    ↓
Testing
    ↓
Business Insights
```

---

# 📋 SELF-ASSESSMENT

## Python

- [ ] Can I explain variables?
- [ ] Can I choose the correct data structure?
- [ ] Can I write conditions?
- [ ] Can I write loops?
- [ ] Can I use comprehensions?
- [ ] Can I write functions?
- [ ] Can I debug common errors?
- [ ] Can I solve a new problem without copying code?

## NumPy

- [ ] Can I create arrays?
- [ ] Do I understand `shape`, `size`, `ndim`?
- [ ] Can I index and slice?
- [ ] Can I perform vectorized operations?
- [ ] Can I filter using boolean conditions?
- [ ] Can I reshape arrays?
- [ ] Can I perform aggregations?

## Pandas

- [ ] Can I create a DataFrame?
- [ ] Can I inspect data?
- [ ] Can I select columns?
- [ ] Can I filter rows?
- [ ] Can I sort?
- [ ] Can I create calculated columns?
- [ ] Do I understand `groupby()`?
- [ ] Do I understand `size()` vs `count()`?
- [ ] Can I handle missing values?
- [ ] Can I merge DataFrames?
- [ ] Can I create a pivot table?
- [ ] Can I use `apply()` appropriately?

## OOP

- [ ] Do I understand class vs object?
- [ ] Do I understand `__init__`?
- [ ] Do I understand `self`?
- [ ] Can I create methods?
- [ ] Do I understand encapsulation?
- [ ] Do I understand inheritance?
- [ ] Do I understand polymorphism?
- [ ] Do I understand abstraction?

---

# 🎯 FINAL LEARNING MODEL

```text
                    PYTHON
                      │
       ┌──────────────┼──────────────┐
       ↓              ↓              ↓
  FUNDAMENTALS    FUNCTIONS       DATA STRUCTURES
       │              │              │
       └──────────────┼──────────────┘
                      ↓
               PROBLEM SOLVING
                      ↓
                    NUMPY
                      ↓
                   PANDAS
                      ↓
                     OOP
                      ↓
                DEBUGGING
                      ↓
             BUSINESS SCENARIOS
                      ↓
              MILESTONE QUESTIONS
                      ↓
                  CONFIDENCE
```

# 🏁 Golden Rule

> **Don't memorize solutions. Learn the thinking pattern behind the solution.**

For every problem ask:

```text
What is the input?
What is the output?
What data structure should I use?
What logic is required?
Can I break the problem into functions?
Can I test an edge case?
Can I explain my solution?
Can I solve a variation?
```

---

# 🚀 Recommended Daily Practice

```text
10 min  → Revision
20 min  → Concept
30 min  → Coding
15 min  → Debugging
15 min  → Scenario problem
10 min  → Milestone question
```

### The target is not:

> "I understood the trainer's code."

### The target is:

> **"I can solve a new problem independently."**
