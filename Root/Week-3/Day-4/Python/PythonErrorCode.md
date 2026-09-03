# 🐞 Python Syntax Error Lab — Broken Code + Solutions

## Purpose

This trainer-ready lab converts the learner feedback into hands-on debugging practice.

Each exercise contains:

1. ❌ Intentionally broken code
2. 🔎 Error identification
3. ✅ Corrected code
4. 🧠 Explanation
5. 🎯 Learner challenge

> **Important:** Not every broken example is technically a `SyntaxError`. Some are `IndentationError`, runtime errors, or logical errors. Learning to distinguish them is an important Python skill.

---

# 1. Error Categories

| Error | Meaning |
|---|---|
| `SyntaxError` | Python cannot parse the code structure |
| `IndentationError` | Block indentation is invalid |
| `NameError` | A name has not been defined |
| `TypeError` | An operation is incompatible with the type |
| `ValueError` | The value is invalid for the operation |
| `IndexError` | Invalid sequence position |
| `KeyError` | Dictionary key does not exist |
| Logical error | Code runs but produces the wrong result |

---

# 2. Python Basics

## 2.1 Missing Colon

### ❌ Broken

```python
age = 20

if age >= 18
    print("Adult")
```

### Error

`SyntaxError` — missing `:`.

### ✅ Solution

```python
age = 20

if age >= 18:
    print("Adult")
```

### Explanation

Python blocks introduced by `if`, `for`, `while`, `def`, `class`, `try`, etc. require a colon.

---

## 2.2 Missing Parenthesis

### ❌ Broken

```python
print("Hello"
```

### Error

`SyntaxError` — `)` is missing.

### ✅ Solution

```python
print("Hello")
```

---

## 2.3 Missing List Bracket

### ❌ Broken

```python
numbers = [10, 20, 30
```

### ✅ Solution

```python
numbers = [10, 20, 30]
```

---

## 2.4 Missing Dictionary Brace

### ❌ Broken

```python
student = {
    "name": "Asha",
    "marks": 90
```

### ✅ Solution

```python
student = {
    "name": "Asha",
    "marks": 90
}
```

---

## 2.5 Missing String Quote

### ❌ Broken

```python
name = "Asha
```

### ✅ Solution

```python
name = "Asha"
```

---

## 2.6 Assignment vs Comparison

### ❌ Broken

```python
if age = 20:
    print("Twenty")
```

### ✅ Solution

```python
if age == 20:
    print("Twenty")
```

### Explanation

```text
=   assignment
==  comparison
```

---

# 3. Conditions — All Major Combinations

## 3.1 `if`

### ❌

```python
if marks >= 50
    print("Pass")
```

### ✅

```python
if marks >= 50:
    print("Pass")
```

---

## 3.2 `if + else`

### ❌

```python
if marks >= 50:
    print("Pass")
else
    print("Fail")
```

### ✅

```python
if marks >= 50:
    print("Pass")
else:
    print("Fail")
```

---

## 3.3 `if + elif + else`

### ❌

```python
marks = 75

if marks >= 90:
    print("A")
elif marks >= 75
    print("B")
else:
    print("C")
```

### ✅

```python
marks = 75

if marks >= 90:
    print("A")
elif marks >= 75:
    print("B")
else:
    print("C")
```

---

## 3.4 Incorrect `else` Position

### ❌

```python
if marks >= 90:
    print("A")
else:
    print("Other")
elif marks >= 75:
    print("B")
```

### ✅

```python
if marks >= 90:
    print("A")
elif marks >= 75:
    print("B")
else:
    print("Other")
```

### Rule

```text
if
 ↓
zero or more elif
 ↓
optional else
```

---

## 3.5 `and`

### ❌

```python
if age > 18 && salary > 50000:
    print("Eligible")
```

### ✅

```python
if age > 18 and salary > 50000:
    print("Eligible")
```

---

## 3.6 `or`

### ❌

```python
if age > 18 || salary > 50000:
    print("Eligible")
```

### ✅

```python
if age > 18 or salary > 50000:
    print("Eligible")
```

---

## 3.7 `not`

### ❌

```python
if !is_active:
    print("Inactive")
```

### ✅

```python
if not is_active:
    print("Inactive")
```

---

# 4. Loops

## 4.1 `for`

### ❌

```python
for number in range(5)
    print(number)
```

### ✅

```python
for number in range(5):
    print(number)
```

---

## 4.2 Missing `in`

### ❌

```python
for number range(5):
    print(number)
```

### ✅

```python
for number in range(5):
    print(number)
```

---

## 4.3 Missing Indentation

### ❌

```python
for number in range(5):
print(number)
```

### ✅

```python
for number in range(5):
    print(number)
```

---

## 4.4 Nested Loop

### ❌

```python
for i in range(3):
    for j in range(3):
    print(i, j)
```

### ✅

```python
for i in range(3):
    for j in range(3):
        print(i, j)
```

---

## 4.5 `while`

### ❌

```python
count = 1

while count <= 5
    print(count)
    count += 1
```

### ✅

```python
count = 1

while count <= 5:
    print(count)
    count += 1
```

---

# 5. `break`, `continue`, `pass`

## 5.1 `break`

### ❌

```python
if number == 5:
    break
```

### Explanation

`break` must occur inside a loop.

### ✅

```python
for number in range(10):
    if number == 5:
        break
```

---

## 5.2 `continue`

### ❌

```python
if number == 5:
    continue
```

### ✅

```python
for number in range(10):
    if number == 5:
        continue
    print(number)
```

---

# 6. Data Structures

## 6.1 List

### ❌

```python
numbers = [1 2 3]
```

### ✅

```python
numbers = [1, 2, 3]
```

---

## 6.2 Dictionary

### ❌

```python
student = {
    "name" "Asha",
    "marks": 90
}
```

### ✅

```python
student = {
    "name": "Asha",
    "marks": 90
}
```

---

## 6.3 Dictionary Missing Comma

### ❌

```python
student = {
    "name": "Asha"
    "marks": 90
}
```

### ✅

```python
student = {
    "name": "Asha",
    "marks": 90
}
```

---

# 7. Strings

## 7.1 Unterminated String

### ❌

```python
message = "Hello Python
```

### ✅

```python
message = "Hello Python"
```

---

## 7.2 Nested Quotes

### ❌

```python
message = "Python is "easy""
```

### ✅

```python
message = 'Python is "easy"'
```

or:

```python
message = "Python is \"easy\""
```

---

## 7.3 f-string

### ❌

```python
name = "Asha"
print(f"Hello {name")
```

### ✅

```python
name = "Asha"
print(f"Hello {name}")
```

---

# 8. Functions

## 8.1 Missing Colon

### ❌

```python
def add(a, b)
    return a + b
```

### ✅

```python
def add(a, b):
    return a + b
```

---

## 8.2 Missing Parenthesis in Call

### ❌

```python
result = add(10, 20
```

### ✅

```python
result = add(10, 20)
```

---

## 8.3 Incorrect Parameters

### ❌

```python
def greet(name age):
    print(name, age)
```

### ✅

```python
def greet(name, age):
    print(name, age)
```

---

## 8.4 Default Argument Ordering

### ❌

```python
def greet(name="Guest", age):
    print(name, age)
```

### Error

A required argument cannot follow a default argument.

### ✅

```python
def greet(name, age=18):
    print(name, age)
```

---

## 8.5 Function + Condition

### ❌

```python
def grade(marks):
    if marks >= 90
        return "A"
    elif marks >= 75:
        return "B"
    else:
        return "C"
```

### ✅

```python
def grade(marks):
    if marks >= 90:
        return "A"
    elif marks >= 75:
        return "B"
    else:
        return "C"
```

---

# 9. Comprehensions

## 9.1 List Comprehension

### ❌

```python
squares = [x ** 2 for x in range(5)
```

### ✅

```python
squares = [x ** 2 for x in range(5)]
```

---

## 9.2 Missing `for`

### ❌

```python
squares = [x ** 2 x in range(5)]
```

### ✅

```python
squares = [x ** 2 for x in range(5)]
```

---

## 9.3 Conditional Comprehension

### ❌

```python
even = [x for x in range(10) if x % 2 == 0
```

### ✅

```python
even = [x for x in range(10) if x % 2 == 0]
```

---

## 9.4 Dictionary Comprehension

### ❌

```python
squares = {x: x ** 2 for x in range(5)
```

### ✅

```python
squares = {x: x ** 2 for x in range(5)}
```

---

# 10. Exception Handling

## 10.1 `try`

### ❌

```python
try
    x = 10 / 0
except ZeroDivisionError:
    print("Cannot divide")
```

### ✅

```python
try:
    x = 10 / 0
except ZeroDivisionError:
    print("Cannot divide")
```

---

## 10.2 `except`

### ❌

```python
try:
    x = 10 / 0
except ZeroDivisionError
    print("Cannot divide")
```

### ✅

```python
try:
    x = 10 / 0
except ZeroDivisionError:
    print("Cannot divide")
```

---

# 11. Imports

## 11.1 NumPy

### ❌

```python
import numpy as
```

### ✅

```python
import numpy as np
```

---

## 11.2 Multiple Imports

### ❌

```python
import pandas as pd numpy as np
```

### ✅

```python
import pandas as pd
import numpy as np
```

---

# 12. NumPy Error Lab

## 12.1 Array Construction

### ❌

```python
import numpy as np

arr = np.array([1, 2, 3]
```

### ✅

```python
import numpy as np

arr = np.array([1, 2, 3])
```

---

## 12.2 Boolean Filtering

### ❌

```python
result = arr[arr > 10 & arr < 50]
```

### ✅

```python
result = arr[(arr > 10) & (arr < 50)]
```

### Explanation

Each comparison should be grouped:

```text
(arr > 10)
     &
(arr < 50)
```

---

## 12.3 Reshape

### ❌

```python
matrix = arr.reshape(2, 3
```

### ✅

```python
matrix = arr.reshape(2, 3)
```

---

## 12.4 Aggregation

### ❌

```python
average = np.mean(arr
```

### ✅

```python
average = np.mean(arr)
```

---

# 13. Pandas Error Lab

## 13.1 DataFrame

### ❌

```python
import pandas as pd

df = pd.DataFrame({
    "Name": ["Asha", "Ravi"],
    "Salary": [50000, 60000]
```

### ✅

```python
import pandas as pd

df = pd.DataFrame({
    "Name": ["Asha", "Ravi"],
    "Salary": [50000, 60000]
})
```

---

## 13.2 Filtering

### ❌

```python
result = df[
    (df["Age"] > 25) &
    (df["Salary"] > 50000]
```

### ✅

```python
result = df[
    (df["Age"] > 25) &
    (df["Salary"] > 50000)
]
```

---

## 13.3 Pandas `and`

### ❌

```python
result = df[
    (df["Age"] > 25) and
    (df["Salary"] > 50000)
]
```

### ✅

```python
result = df[
    (df["Age"] > 25) &
    (df["Salary"] > 50000)
]
```

---

## 13.4 GroupBy

### ❌

```python
result = df.groupby("Department")["Salary".mean()
```

### ✅

```python
result = df.groupby("Department")["Salary"].mean()
```

---

## 13.5 Aggregation

### ❌

```python
result = df.groupby("Department")["Salary"].agg(
    ["count", "mean", "max"
)
```

### ✅

```python
result = df.groupby("Department")["Salary"].agg(
    ["count", "mean", "max"]
)
```

---

## 13.6 Merge

### ❌

```python
result = customers.merge(
    orders,
    on="CustomerID"
    how="inner"
)
```

### ✅

```python
result = customers.merge(
    orders,
    on="CustomerID",
    how="inner"
)
```

---

## 13.7 `fillna`

### ❌

```python
df["Salary"] = df["Salary"].fillna(0
```

### ✅

```python
df["Salary"] = df["Salary"].fillna(0)
```

---

## 13.8 Pivot

### ❌

```python
pivot = df.pivot_table(
    index="Department",
    values="Salary",
    aggfunc="mean"
```

### ✅

```python
pivot = df.pivot_table(
    index="Department",
    values="Salary",
    aggfunc="mean"
)
```

---

## 13.9 `apply`

### ❌

```python
def category(salary):
    if salary >= 60000:
        return "High"
    else
        return "Low"
```

### ✅

```python
def category(salary):
    if salary >= 60000:
        return "High"
    else:
        return "Low"
```

---

# 14. `size()` vs `count()` Debugging Concept

Correct:

```python
df.groupby("Department").size()
```

Counts rows.

Correct:

```python
df.groupby("Department")["Salary"].count()
```

Counts non-null Salary values.

Mental model:

```text
size()
    → How many rows?

count()
    → How many non-null values?
```

---

# 15. OOP Error Lab

## 15.1 Class

### ❌

```python
class Student
    pass
```

### ✅

```python
class Student:
    pass
```

---

## 15.2 Constructor

### ❌

```python
class Student:

    def __init__(self, name, marks)
        self.name = name
        self.marks = marks
```

### ✅

```python
class Student:

    def __init__(self, name, marks):
        self.name = name
        self.marks = marks
```

---

## 15.3 Method

### ❌

```python
class Student:

    def display(self)
        print(self.name)
```

### ✅

```python
class Student:

    def display(self):
        print(self.name)
```

---

## 15.4 `self`

### ❌

```python
class Student:

    def __init__(name, marks):
        self.name = name
        self.marks = marks
```

### Explanation

This is not a syntax error. The method is missing the conventional first instance parameter.

### ✅

```python
class Student:

    def __init__(self, name, marks):
        self.name = name
        self.marks = marks
```

---

## 15.5 Inheritance

### ❌

```python
class Dog Animal:
    pass
```

### ✅

```python
class Dog(Animal):
    pass
```

---

# 16. Combined Beginner Challenge

## ❌ Broken

```python
name = "Asha
age = 22

if age >= 18
    print(name, "is an adult")
else:
    print(name, "is a minor"
```

### Find all errors

```text
1. Missing closing quote
2. Missing colon
3. Missing closing parenthesis
```

### ✅ Solution

```python
name = "Asha"
age = 22

if age >= 18:
    print(name, "is an adult")
else:
    print(name, "is a minor")
```

---

# 17. Combined Intermediate Challenge

## ❌ Broken

```python
def calculate_total(numbers)
    total = 0

    for number in numbers
        if number > 0
            total += number

    return total

values = [10, -5, 20, 30

result = calculate_total(values)

print("Total:", result
```

### Errors

```text
1. Missing : after def
2. Missing : after for
3. Missing : after if
4. Missing ] in list
5. Missing ) in print
```

### ✅ Solution

```python
def calculate_total(numbers):
    total = 0

    for number in numbers:
        if number > 0:
            total += number

    return total

values = [10, -5, 20, 30]

result = calculate_total(values)

print("Total:", result)
```

---

# 18. Combined Pandas Challenge

## ❌ Broken

```python
import pandas as pd

data = {
    "Department": ["IT", "IT", "HR", "Sales"],
    "Salary": [50000, 60000, 45000, 70000]
}

df = pd.DataFrame(data

df["Bonus"] = df["Salary"] * 0.10

high_salary = df[
    (df["Salary"] > 50000) &
    (df["Bonus"] > 5000)
]

summary = high_salary.groupby("Department")["Salary"].agg(
    ["count", "mean", "max"
)

print(summary
```

### Errors

```text
1. Missing ) after DataFrame(data
2. Missing ] in agg()
3. Missing ) in print()
```

### ✅ Solution

```python
import pandas as pd

data = {
    "Department": ["IT", "IT", "HR", "Sales"],
    "Salary": [50000, 60000, 45000, 70000]
}

df = pd.DataFrame(data)

df["Bonus"] = df["Salary"] * 0.10

high_salary = df[
    (df["Salary"] > 50000) &
    (df["Bonus"] > 5000)
]

summary = high_salary.groupby("Department")["Salary"].agg(
    ["count", "mean", "max"]
)

print(summary)
```

---

# 19. Combined OOP Challenge

## ❌ Broken

```python
class Student

    def __init__(self, name, marks):
        self.name = name
        self.marks = marks

    def display(self)
        print(self.name, self.marks)

student = Student("Asha", 85

student.display()
```

### Errors

```text
1. Missing : after class
2. Missing : after display()
3. Missing ) after Student(...)
```

### ✅ Solution

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

# 20. MASTER CHALLENGE — Python + NumPy + Pandas + OOP

## ❌ Broken

```python
import pandas as pd
import numpy as np

class Employee

    def __init__(self, name, department, salary)
        self.name = name
        self.department = department
        self.salary = salary

    def bonus(self)
        if self.salary >= 60000
            return self.salary * 0.15
        else:
            return self.salary * 0.10


employees = [
    Employee("Asha", "IT", 70000),
    Employee("Ravi", "HR", 50000),
    Employee("John", "IT", 65000)
]

data = {
    "Name": [e.name for e in employees],
    "Department": [e.department for e in employees],
    "Salary": [e.salary for e in employees],
    "Bonus": [e.bonus() for e in employees]
}

df = pd.DataFrame(data

high_salary = df[
    (df["Salary"] > 60000) &
    (df["Bonus"] > 8000
]

summary = high_salary.groupby("Department")["Salary"].agg(
    ["count", "mean", "max"
)

print(summary
```

---

# 21. Master Solution

```python
import pandas as pd
import numpy as np


class Employee:

    def __init__(self, name, department, salary):
        self.name = name
        self.department = department
        self.salary = salary

    def bonus(self):
        if self.salary >= 60000:
            return self.salary * 0.15
        else:
            return self.salary * 0.10


employees = [
    Employee("Asha", "IT", 70000),
    Employee("Ravi", "HR", 50000),
    Employee("John", "IT", 65000)
]

data = {
    "Name": [e.name for e in employees],
    "Department": [e.department for e in employees],
    "Salary": [e.salary for e in employees],
    "Bonus": [e.bonus() for e in employees]
}

df = pd.DataFrame(data)

high_salary = df[
    (df["Salary"] > 60000) &
    (df["Bonus"] > 8000)
]

summary = high_salary.groupby("Department")["Salary"].agg(
    ["count", "mean", "max"]
)

print(summary)
```

---

# 22. Master Challenge — What It Tests

```text
Class
 ↓
__init__
 ↓
self
 ↓
Instance attributes
 ↓
Method
 ↓
if / else
 ↓
List comprehension
 ↓
Dictionary
 ↓
Pandas DataFrame
 ↓
Boolean filtering
 ↓
GroupBy
 ↓
Aggregation
```

This is deliberately designed as a milestone-style integrated problem.

---

# 23. Debugging Method

Never randomly change code.

Use:

```text
READ
 ↓
LOCATE
 ↓
CLASSIFY
 ↓
EXPLAIN
 ↓
FIX
 ↓
RUN
 ↓
TEST
 ↓
MODIFY
```

For every error ask:

### 1. Where is the error?

Identify the exact line.

### 2. What type of error?

```text
Syntax
Indentation
Runtime
Logical
```

### 3. Why does it happen?

State the Python rule.

### 4. How do I fix it?

Make the smallest appropriate correction.

### 5. Can I prevent it?

Create a reusable mental rule.

---

# 24. Error Detection Scan

Before running code, check in this order:

```text
1. Quotes
2. Parentheses
3. Brackets
4. Braces
5. Colons
6. Commas
7. Indentation
8. Keywords
9. Variable names
10. Operators
11. Function arguments
12. Logic
```

---

# 25. Bracket Matching

When code is nested:

```python
result = df.groupby("Department")["Salary"].agg(
    ["count", "mean", "max"]
)
```

Mentally match:

```text
groupby(          → )
["Salary"]        → []
agg(              → )
["count", ...]    → []
```

Remember:

```text
( → )
[ → ]
{ → }
" → "
' → '
```

---

# 26. Indentation Mental Model

Correct:

```python
if condition:
    statement1
    statement2
```

Nested:

```python
if condition:
    for item in items:
        if item > 10:
            print(item)
```

Think:

```text
if
└── for
    └── if
        └── print
```

---

# 27. 20 Learner Debugging Challenges

## Challenge 1

```python
if x > 10
    print(x)
```

## Challenge 2

```python
for i in range(5)
    print(i)
```

## Challenge 3

```python
numbers = [1, 2, 3, 4
```

## Challenge 4

```python
student = {"name": "Asha", "age": 22
```

## Challenge 5

```python
def add(a, b)
    return a + b
```

## Challenge 6

```python
def greet(name="Guest", age):
    print(name, age)
```

## Challenge 7

```python
squares = [x ** 2 for x in range(5)
```

## Challenge 8

```python
try:
    x = int(input("Number: "))
except ValueError
    print("Invalid")
```

## Challenge 9

```python
import numpy as
```

## Challenge 10

```python
arr = np.array([1, 2, 3]
```

## Challenge 11

```python
result = arr[(arr > 10) & (arr < 50]
```

## Challenge 12

```python
df = pd.DataFrame({
    "Name": ["Asha", "Ravi"],
    "Salary": [50000, 60000]
```

## Challenge 13

```python
df[df["Salary"] > 50000
```

## Challenge 14

```python
df.groupby("Department")["Salary".mean()
```

## Challenge 15

```python
df.sort_values("Salary", ascending=False
```

## Challenge 16

```python
class Student
    pass
```

## Challenge 17

```python
class Student:

    def __init__(self, name)
        self.name = name
```

## Challenge 18

```python
class Dog Animal:
    pass
```

## Challenge 19

```python
class BankAccount:

    def deposit(self, amount)
        self.balance += amount
```

## Challenge 20

```python
import pandas as pd

def analyze(data)
    df = pd.DataFrame(data

    df["Bonus"] = df["Salary"] * 0.10

    result = df[
        (df["Salary"] > 50000) &
        (df["Bonus"] > 5000)
    ]

    return result

data = {
    "Name": ["A", "B"],
    "Salary": [50000, 70000]
}

output = analyze(data)

print(output
```

### Solution for Challenge 20

```python
import pandas as pd

def analyze(data):
    df = pd.DataFrame(data)

    df["Bonus"] = df["Salary"] * 0.10

    result = df[
        (df["Salary"] > 50000) &
        (df["Bonus"] > 5000)
    ]

    return result

data = {
    "Name": ["A", "B"],
    "Salary": [50000, 70000]
}

output = analyze(data)

print(output)
```

---

# 28. Trainer Classroom Format

Use this sequence instead of immediately showing the answer:

```text
BROKEN CODE
    ↓
30 sec — Read
    ↓
1 min — Identify errors
    ↓
1 min — Classify errors
    ↓
2 min — Explain the Python rule
    ↓
Fix
    ↓
Run
    ↓
Change one requirement
    ↓
Solve again
```

---

# 29. Difficulty Progression

```text
LEVEL 1
One syntax error
        ↓
LEVEL 2
Two syntax errors
        ↓
LEVEL 3
Syntax + indentation
        ↓
LEVEL 4
Syntax + runtime
        ↓
LEVEL 5
Multiple concepts
        ↓
LEVEL 6
Scenario problem
        ↓
LEVEL 7
Milestone-style problem
        ↓
LEVEL 8
Debug unfamiliar code
```

---

# 30. Final Learner Checklist

Before running code:

- [ ] Are quotes closed?
- [ ] Are parentheses closed?
- [ ] Are brackets closed?
- [ ] Are braces closed?
- [ ] Are colons present?
- [ ] Are commas present?
- [ ] Is indentation correct?
- [ ] Are keywords correct?
- [ ] Are variable names valid?
- [ ] Are conditions using the correct operators?
- [ ] Are Pandas conditions wrapped in parentheses?
- [ ] Are Pandas conditions using `&` / `|`?
- [ ] Are function parameters valid?
- [ ] Is `self` present in instance methods?
- [ ] Is inheritance written as `Child(Parent)`?

---

# 🏁 Final Goal

The objective is **not**:

> "I can fix this exact code."

The objective is:

> **"I recognize the error pattern and can fix a new program independently."**

```text
ERROR
  ↓
PATTERN
  ↓
RULE
  ↓
FIX
  ↓
PRACTICE
  ↓
VARIATION
  ↓
CONFIDENCE
```

## Trainer Golden Rule

> **Let learners struggle with broken code before showing the solution. The debugging process is part of learning to code.**
