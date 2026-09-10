# Python Practical Module: Visualization, Database, Exception Handling & File Handling

## Topics Covered

- Matplotlib
- Seaborn
- SQLite
- SQLAlchemy
- SQL Connectivity Lab
- Exception Handling
- Custom Exceptions
- Assertions
- Logging and Debugging
- File Handling
- CSV
- JSON
- XML
- File Modes
- Context Managers
- Directory and File Operations
- Integrated Practical
- Trainee Decision Framework
- Functionality Selection Cheat Sheet

---

# 1. Matplotlib

## 1.1 What is Matplotlib?

`matplotlib` is a Python library used to create visualizations.

Common charts:

- Line chart
- Bar chart
- Scatter plot
- Histogram
- Pie chart
- Box plot

```python
import matplotlib.pyplot as plt
```

---

## 1.2 Line Plot

### Problem

A company records monthly sales:

```python
months = ["Jan", "Feb", "Mar", "Apr", "May"]
sales = [100, 120, 150, 130, 170]
```

Plot the sales trend.

### Solution

```python
import matplotlib.pyplot as plt

months = ["Jan", "Feb", "Mar", "Apr", "May"]
sales = [100, 120, 150, 130, 170]

plt.plot(months, sales)

plt.xlabel("Month")
plt.ylabel("Sales")
plt.title("Monthly Sales")

plt.show()
```

### Explanation

| Function | Purpose |
|---|---|
| `plt.plot()` | Creates line chart |
| `plt.xlabel()` | X-axis label |
| `plt.ylabel()` | Y-axis label |
| `plt.title()` | Chart title |
| `plt.show()` | Displays chart |

### When to use

Use a line plot when showing a trend over an ordered sequence such as:

- Monthly sales
- Daily temperature
- Website traffic
- Stock prices

---

# 2. Bar Chart

## Problem

Display the number of employees in each department.

```python
departments = ["IT", "HR", "Finance", "Sales"]
employees = [50, 20, 30, 45]
```

## Solution

```python
import matplotlib.pyplot as plt

departments = ["IT", "HR", "Finance", "Sales"]
employees = [50, 20, 30, 45]

plt.bar(departments, employees)

plt.xlabel("Department")
plt.ylabel("Employees")
plt.title("Employees by Department")

plt.show()
```

### When to use

Use a bar chart when comparing categories.

Examples:

```text
Department → Employee count
Product → Sales
City → Customers
Course → Number of trainees
```

---

# 3. Scatter Plot

A scatter plot is used to understand the relationship between two numerical variables.

## Problem

Analyze the relationship between hours studied and marks.

```python
hours = [1, 2, 3, 4, 5, 6, 7]
marks = [35, 42, 50, 55, 65, 72, 85]
```

## Solution

```python
import matplotlib.pyplot as plt

hours = [1, 2, 3, 4, 5, 6, 7]
marks = [35, 42, 50, 55, 65, 72, 85]

plt.scatter(hours, marks)

plt.xlabel("Hours Studied")
plt.ylabel("Marks")
plt.title("Study Hours vs Marks")

plt.show()
```

### Interpretation

If the points generally move upward:

```text
Hours ↑ → Marks ↑
```

there may be a positive relationship.

---

# 4. Histogram

A histogram is used to understand the distribution of numerical data.

```python
import matplotlib.pyplot as plt

marks = [
    45, 50, 55, 60, 61,
    62, 65, 68, 70, 72,
    75, 78, 80, 85, 90
]

plt.hist(marks, bins=5)

plt.xlabel("Marks")
plt.ylabel("Number of Students")
plt.title("Marks Distribution")

plt.show()
```

### Key concept

```python
bins=5
```

divides the data into five intervals.

### When to use

Use a histogram for:

- Marks distribution
- Age distribution
- Salary distribution
- Transaction amounts
- Response times

---

# 5. Pie Chart

```python
import matplotlib.pyplot as plt

labels = ["Python", "SQL", "Java", "Excel"]
values = [40, 30, 20, 10]

plt.pie(
    values,
    labels=labels,
    autopct="%1.1f%%"
)

plt.title("Skill Distribution")

plt.show()
```

`autopct` displays percentages.

---

# 6. Seaborn

Seaborn is built on top of Matplotlib and provides convenient statistical visualizations.

```python
import seaborn as sns
import matplotlib.pyplot as plt
```

Seaborn works especially well with Pandas DataFrames.

---

# 7. Seaborn Bar Plot

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

data = {
    "Department": ["IT", "IT", "HR", "HR", "Sales", "Sales"],
    "Salary": [50000, 60000, 40000, 45000, 55000, 65000]
}

df = pd.DataFrame(data)

sns.barplot(
    data=df,
    x="Department",
    y="Salary"
)

plt.title("Average Salary by Department")
plt.show()
```

### Important difference

Matplotlib:

```python
plt.bar(x, y)
```

Seaborn:

```python
sns.barplot(
    data=df,
    x="Department",
    y="Salary"
)
```

Seaborn's `barplot()` performs aggregation by default. For the example above, it calculates the average salary for each department.

---

# 8. Seaborn Box Plot

Box plots are useful for understanding spread and identifying potential outliers.

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

data = {
    "Department": ["IT", "IT", "IT", "HR", "HR", "HR"],
    "Salary": [50000, 55000, 60000, 40000, 42000, 100000]
}

df = pd.DataFrame(data)

sns.boxplot(
    data=df,
    x="Department",
    y="Salary"
)

plt.show()
```

The `100000` salary may appear as an outlier.

---

# 9. Seaborn Heatmap

A heatmap is useful for correlation analysis.

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

data = {
    "Age": [20, 25, 30, 35, 40],
    "Experience": [1, 3, 5, 8, 12],
    "Salary": [25000, 35000, 45000, 60000, 80000]
}

df = pd.DataFrame(data)

correlation = df.corr(numeric_only=True)

sns.heatmap(
    correlation,
    annot=True
)

plt.title("Correlation Matrix")
plt.show()
```

---

# 10. SQLite

SQLite is a lightweight relational database.

Python provides the `sqlite3` module in the standard library.

```python
import sqlite3
```

---

# 11. SQLite Connection

```python
import sqlite3

connection = sqlite3.connect("company.db")

print("Database connected")

connection.close()
```

If `company.db` does not exist, SQLite creates it.

### Basic flow

```text
connect()
    ↓
cursor()
    ↓
execute()
    ↓
commit()
    ↓
fetch()
    ↓
close()
```

---

# 12. Create Table

```python
import sqlite3

connection = sqlite3.connect("company.db")

cursor = connection.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary REAL
)
""")

connection.commit()
connection.close()
```

### Explanation

- `connect()` connects to the database.
- `cursor()` creates an object used to execute SQL.
- `execute()` executes SQL.
- `commit()` permanently saves INSERT/UPDATE/DELETE changes.
- `close()` closes the database connection.

---

# 13. Insert Data

```python
import sqlite3

connection = sqlite3.connect("company.db")
cursor = connection.cursor()

cursor.execute("""
INSERT INTO employees
(name, department, salary)
VALUES (?, ?, ?)
""", ("Rahul", "IT", 60000))

connection.commit()
connection.close()
```

## Why use `?`

This is parameterized SQL.

Prefer:

```python
cursor.execute(
    "INSERT INTO employees (name, department, salary) VALUES (?, ?, ?)",
    ("Rahul", "IT", 60000)
)
```

Avoid constructing SQL by concatenating user input.

Parameterized queries are safer and help prevent SQL injection.

---

# 14. Insert Multiple Records

```python
employees = [
    ("Rahul", "IT", 60000),
    ("Priya", "HR", 50000),
    ("Amit", "Sales", 55000)
]

connection = sqlite3.connect("company.db")
cursor = connection.cursor()

cursor.executemany("""
INSERT INTO employees
(name, department, salary)
VALUES (?, ?, ?)
""", employees)

connection.commit()
connection.close()
```

### `execute()` vs `executemany()`

| Function | Use |
|---|---|
| `execute()` | One SQL operation |
| `executemany()` | Same SQL operation for multiple records |

---

# 15. SELECT Data

```python
import sqlite3

connection = sqlite3.connect("company.db")
cursor = connection.cursor()

cursor.execute("""
SELECT * FROM employees
""")

rows = cursor.fetchall()

for row in rows:
    print(row)

connection.close()
```

### Fetch methods

| Function | Purpose |
|---|---|
| `fetchone()` | One row |
| `fetchmany(n)` | `n` rows |
| `fetchall()` | All remaining rows |

---

# 16. SQL Connectivity Lab

## Lab Problem

> Create an employee database. Store employee details and perform INSERT, SELECT, UPDATE and DELETE operations.

## Complete Solution

```python
import sqlite3

connection = sqlite3.connect("employee.db")
cursor = connection.cursor()

# 1. Create table
cursor.execute("""
CREATE TABLE IF NOT EXISTS employees (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    department TEXT,
    salary REAL
)
""")

# 2. Insert records
employees = [
    (1, "Rahul", "IT", 60000),
    (2, "Priya", "HR", 50000),
    (3, "Amit", "Sales", 55000)
]

cursor.executemany("""
INSERT OR IGNORE INTO employees
(id, name, department, salary)
VALUES (?, ?, ?, ?)
""", employees)

# 3. Select
cursor.execute("""
SELECT * FROM employees
""")

rows = cursor.fetchall()

print("Employees:")

for row in rows:
    print(row)

# 4. Update
cursor.execute("""
UPDATE employees
SET salary = ?
WHERE id = ?
""", (70000, 1))

# 5. Delete
cursor.execute("""
DELETE FROM employees
WHERE id = ?
""", (3,))

connection.commit()

print("\nAfter Update/Delete:")

cursor.execute("SELECT * FROM employees")

for row in cursor.fetchall():
    print(row)

connection.close()
```

### CRUD mapping

| Requirement | SQL |
|---|---|
| Create/Insert | `INSERT` |
| Read | `SELECT` |
| Update | `UPDATE` |
| Delete | `DELETE` |

---

# 17. SQLAlchemy

SQLAlchemy is a Python SQL toolkit and ORM.

Install:

```bash
pip install sqlalchemy
```

---

# 18. SQLAlchemy Basic Connection

```python
from sqlalchemy import create_engine

engine = create_engine("sqlite:///company.db")

print("Database connected")
```

---

# 19. SQLAlchemy + Pandas

This is especially useful in data-analysis problems.

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("sqlite:///company.db")

query = "SELECT * FROM employees"

df = pd.read_sql(query, engine)

print(df)
```

### Real-world workflow

```text
Database
   ↓
SQL
   ↓
Pandas DataFrame
   ↓
Analysis
   ↓
Visualization
```

---

# 20. Exception Handling

Exception handling prevents a program from terminating unexpectedly when an error occurs.

Basic syntax:

```python
try:
    # risky code
except:
    # error handling
```

---

# 21. Basic `try-except`

```python
try:
    number = int(input("Enter number: "))
    print(10 / number)

except:
    print("Something went wrong")
```

### Better approach

Use specific exceptions.

```python
try:
    number = int(input("Enter number: "))
    result = 10 / number
    print(result)

except ValueError:
    print("Please enter a valid integer")

except ZeroDivisionError:
    print("Cannot divide by zero")
```

### Why specific exceptions?

This:

```python
except:
```

can hide unexpected problems.

This:

```python
except ValueError:
```

clearly identifies the error being handled.

---

# 22. Multiple Exceptions

```python
try:
    a = int(input("Enter A: "))
    b = int(input("Enter B: "))

    print(a / b)

except (ValueError, ZeroDivisionError):
    print("Invalid input or division by zero")
```

---

# 23. `else`

`else` executes only when no exception occurs.

```python
try:
    number = int(input("Enter number: "))

except ValueError:
    print("Invalid number")

else:
    print("Valid number:", number)
```

### Flow

```text
try
 ↓
Exception?
 ↙      ↘
YES      NO
 ↓        ↓
except   else
```

---

# 24. `finally`

`finally` executes whether an exception occurs or not.

```python
try:
    file = open("data.txt", "r")
    data = file.read()

except FileNotFoundError:
    print("File not found")

finally:
    print("Execution completed")
```

Typical uses:

- Closing files
- Closing database connections
- Releasing resources
- Cleanup operations

---

# 25. Complete Exception Structure

```python
try:
    number = int(input("Enter number: "))
    result = 100 / number

except ValueError:
    print("Invalid number")

except ZeroDivisionError:
    print("Cannot divide by zero")

else:
    print("Result:", result)

finally:
    print("Program finished")
```

---

# 26. Custom Exceptions

Custom exceptions are useful when a business rule needs its own error type.

```python
class InvalidSalaryError(Exception):
    pass
```

Use it:

```python
salary = -5000

try:
    if salary < 0:
        raise InvalidSalaryError("Salary cannot be negative")

except InvalidSalaryError as e:
    print(e)
```

### Important pattern

```python
raise CustomException("message")
```

---

# 27. Practical Custom Exception

```python
class InsufficientBalanceError(Exception):
    pass


balance = 5000
withdraw = 7000

try:

    if withdraw > balance:
        raise InsufficientBalanceError(
            "Insufficient account balance"
        )

    balance -= withdraw

except InsufficientBalanceError as e:
    print(e)
```

### When to use custom exceptions

Use them when the problem contains a business rule such as:

- Salary cannot be negative
- Account balance cannot go below zero
- Marks must be between 0 and 100
- Age must satisfy a business requirement
- Stock quantity cannot become negative

---

# 28. Assertions

Assertions are used to verify assumptions or invariants.

```python
age = 25

assert age >= 18
```

If the condition is false:

```python
age = 15

assert age >= 18, "Age must be at least 18"
```

This raises:

```text
AssertionError: Age must be at least 18
```

---

# 29. Practical Assertion

```python
def calculate_percentage(marks, total):

    assert total > 0, "Total marks must be positive"

    return marks / total * 100


print(calculate_percentage(450, 500))
```

### Assertion vs Exception

Use `assert` primarily for:

- Programmer assumptions
- Internal invariants
- Conditions that should always be true during development/testing

Use explicit exceptions for:

- User input validation
- Business-rule validation
- Recoverable runtime conditions

For example:

```python
if salary < 0:
    raise ValueError("Salary cannot be negative")
```

is preferable to using an assertion for user input.

---

# 30. Logging

Logging records information about program execution.

Instead of relying only on:

```python
print("Something happened")
```

use:

```python
import logging

logging.basicConfig(
    level=logging.INFO
)

logging.info("Program started")
logging.warning("Low balance")
logging.error("Database connection failed")
```

---

# 31. Logging Levels

Remember the common levels:

```text
DEBUG
INFO
WARNING
ERROR
CRITICAL
```

Example:

```python
import logging

logging.basicConfig(
    level=logging.DEBUG
)

logging.debug("Debug information")
logging.info("Application started")
logging.warning("Low memory")
logging.error("File not found")
logging.critical("System failure")
```

---

# 32. Logging to a File

```python
import logging

logging.basicConfig(
    filename="application.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

logging.info("Application started")
logging.warning("Something unusual happened")
logging.error("An error occurred")
```

This creates:

```text
application.log
```

---

# 33. Debugging with Exception Logging

```python
import logging

logging.basicConfig(
    filename="error.log",
    level=logging.ERROR
)

try:
    result = 10 / 0

except Exception:
    logging.exception("Unexpected error occurred")
```

`logging.exception()` records the error along with traceback information when called inside an exception handler.

---

# 34. File Handling

Python uses:

```python
open()
```

General syntax:

```python
file = open("filename", "mode")
```

Example:

```python
file = open("data.txt", "r")

content = file.read()

print(content)

file.close()
```

However, for most practical programs, prefer a context manager:

```python
with open("data.txt", "r") as file:
    content = file.read()
```

---

# 35. File Modes

| Mode | Meaning |
|---|---|
| `r` | Read |
| `w` | Write |
| `a` | Append |
| `x` | Create new file |
| `rb` | Read binary |
| `wb` | Write binary |

### Important

`w` can overwrite existing content.

`a` adds content at the end.

---

# 36. Writing a File

```python
file = open("students.txt", "w")

file.write("Rahul\n")
file.write("Priya\n")
file.write("Amit\n")

file.close()
```

---

# 37. Reading a File

```python
file = open("students.txt", "r")

content = file.read()

print(content)

file.close()
```

---

# 38. Read Line by Line

```python
file = open("students.txt", "r")

for line in file:
    print(line.strip())

file.close()
```

---

# 39. `read()`, `readline()`, `readlines()`

## `read()`

```python
content = file.read()
```

Reads all remaining content.

## `readline()`

```python
line = file.readline()
```

Reads one line.

## `readlines()`

```python
lines = file.readlines()
```

Returns a list containing the remaining lines.

---

# 40. Context Manager

Instead of:

```python
file = open("data.txt")
data = file.read()
file.close()
```

prefer:

```python
with open("data.txt", "r") as file:
    data = file.read()

print(data)
```

The context manager handles resource cleanup automatically.

### Preferred pattern

```python
with open(...) as file:
    # work with file
```

---

# 41. Writing Using Context Manager

```python
with open("students.txt", "w") as file:

    file.write("Rahul\n")
    file.write("Priya\n")
    file.write("Amit\n")
```

---

# 42. CSV Files

Python provides the `csv` module.

```python
import csv
```

---

# 43. Write CSV

```python
import csv

data = [
    ["ID", "Name", "Salary"],
    [1, "Rahul", 60000],
    [2, "Priya", 50000],
    [3, "Amit", 55000]
]

with open("employees.csv", "w", newline="") as file:

    writer = csv.writer(file)

    writer.writerows(data)
```

---

# 44. Read CSV

```python
import csv

with open("employees.csv", "r") as file:

    reader = csv.reader(file)

    for row in reader:
        print(row)
```

---

# 45. CSV Using Dictionary

Dictionary-based CSV handling is often easier to understand for real-world records.

```python
import csv

employees = [
    {"id": 1, "name": "Rahul", "salary": 60000},
    {"id": 2, "name": "Priya", "salary": 50000}
]

with open("employees.csv", "w", newline="") as file:

    fieldnames = ["id", "name", "salary"]

    writer = csv.DictWriter(
        file,
        fieldnames=fieldnames
    )

    writer.writeheader()
    writer.writerows(employees)
```

Read:

```python
with open("employees.csv", "r") as file:

    reader = csv.DictReader(file)

    for row in reader:
        print(row["name"], row["salary"])
```

---

# 46. JSON

JSON is commonly used for:

- APIs
- Configuration
- Data exchange
- Web applications

Import:

```python
import json
```

---

# 47. Python Dictionary → JSON File

```python
import json

employee = {
    "id": 101,
    "name": "Rahul",
    "department": "IT",
    "skills": ["Python", "SQL"]
}

with open("employee.json", "w") as file:

    json.dump(
        employee,
        file,
        indent=4
    )
```

---

# 48. JSON File → Python Object

```python
import json

with open("employee.json", "r") as file:

    employee = json.load(file)

print(employee)
print(employee["name"])
```

---

# 49. `dump()` vs `dumps()`

A common trainee confusion.

## `dump()`

Writes JSON into a file:

```python
json.dump(data, file)
```

## `dumps()`

Converts a Python object into a JSON string:

```python
json_string = json.dumps(data)
```

Similarly:

```text
dump  → Python object → JSON file
dumps → Python object → JSON string

load  → JSON file → Python object
loads → JSON string → Python object
```

---

# 50. XML

Python provides XML support through `xml.etree.ElementTree`.

```python
import xml.etree.ElementTree as ET
```

---

# 51. Create XML

```python
import xml.etree.ElementTree as ET

root = ET.Element("employees")

employee = ET.SubElement(root, "employee")

ET.SubElement(employee, "name").text = "Rahul"
ET.SubElement(employee, "department").text = "IT"
ET.SubElement(employee, "salary").text = "60000"

tree = ET.ElementTree(root)

tree.write("employees.xml")
```

Generated structure:

```xml
<employees>
    <employee>
        <name>Rahul</name>
        <department>IT</department>
        <salary>60000</salary>
    </employee>
</employees>
```

---

# 52. Read XML

```python
import xml.etree.ElementTree as ET

tree = ET.parse("employees.xml")

root = tree.getroot()

for employee in root:

    name = employee.find("name").text
    department = employee.find("department").text
    salary = employee.find("salary").text

    print(name, department, salary)
```

---

# 53. Directory Operations with `os`

Use:

```python
import os
```

## Current Directory

```python
import os

print(os.getcwd())
```

---

# 54. List Files

```python
import os

files = os.listdir(".")

for file in files:
    print(file)
```

---

# 55. Create Directory

```python
import os

os.mkdir("reports")
```

For nested directories:

```python
os.makedirs("data/reports", exist_ok=True)
```

`exist_ok=True` prevents an error if the directory already exists.

---

# 56. Check File/Directory

```python
import os

print(os.path.exists("employees.csv"))

print(os.path.isfile("employees.csv"))

print(os.path.isdir("reports"))
```

---

# 57. Join Paths

Avoid manually constructing paths:

```python
path = "data/" + "employees.csv"
```

Prefer:

```python
import os

path = os.path.join(
    "data",
    "employees.csv"
)

print(path)
```

This is more portable across operating systems.

---

# 58. `pathlib` — Modern Approach

`pathlib` provides an object-oriented way to work with paths.

```python
from pathlib import Path

path = Path("data")

print(path.exists())
```

Create directory:

```python
path.mkdir(exist_ok=True)
```

Create file:

```python
file = path / "employees.txt"

file.write_text("Rahul\nPriya\nAmit")
```

Read:

```python
content = file.read_text()

print(content)
```

---

# 59. Complete Practical: File + Exception Handling

### Problem

Read a file and handle the possibility that the file does not exist.

```python
try:

    with open("employees.txt", "r") as file:
        content = file.read()

    print(content)

except FileNotFoundError:

    print("employees.txt does not exist")

except PermissionError:

    print("You do not have permission to read this file")
```

---

# 60. Complete Practical: CSV + Exception Handling

```python
import csv

try:

    with open("employees.csv", "r") as file:

        reader = csv.DictReader(file)

        for row in reader:
            print(
                row["name"],
                row["salary"]
            )

except FileNotFoundError:

    print("CSV file not found")

except KeyError:

    print("Required column is missing")

except Exception as e:

    print("Unexpected error:", e)
```

---

# 61. Complete Practical: JSON + Exception Handling

```python
import json

try:

    with open("employee.json", "r") as file:

        employee = json.load(file)

    print(employee["name"])

except FileNotFoundError:

    print("JSON file not found")

except json.JSONDecodeError:

    print("Invalid JSON format")

except KeyError:

    print("Name field is missing")
```

---

# 62. Complete Practical: Database + Exception Handling + Logging

This is a good integrated practical.

```python
import sqlite3
import logging

logging.basicConfig(
    filename="database.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

connection = None

try:

    logging.info("Connecting to database")

    connection = sqlite3.connect("company.db")

    cursor = connection.cursor()

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS employees (
        id INTEGER PRIMARY KEY,
        name TEXT,
        department TEXT,
        salary REAL
    )
    """)

    cursor.execute("""
    INSERT INTO employees
    (name, department, salary)
    VALUES (?, ?, ?)
    """, ("Rahul", "IT", 60000))

    connection.commit()

    logging.info("Employee inserted successfully")

except sqlite3.Error:

    logging.exception("Database error")

finally:

    if connection:
        connection.close()

    logging.info("Database connection closed")
```

---

# 63. Integrated Data Analytics Practical

## Problem

> Read employee information from CSV, store it in SQLite, load it into Pandas and visualize department-wise salaries.

## Flow

```text
employees.csv
      ↓
CSV / Pandas
      ↓
SQLite
      ↓
SQLAlchemy
      ↓
DataFrame
      ↓
Seaborn
      ↓
Visualization
```

## Solution

```python
import pandas as pd
from sqlalchemy import create_engine
import seaborn as sns
import matplotlib.pyplot as plt

# Read CSV
df = pd.read_csv("employees.csv")

print(df)

# Database connection
engine = create_engine("sqlite:///company.db")

# Store DataFrame in database
df.to_sql(
    "employees",
    engine,
    if_exists="replace",
    index=False
)

# Read from database
query = """
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
"""

result = pd.read_sql(query, engine)

print(result)

# Visualization
sns.barplot(
    data=result,
    x="department",
    y="average_salary"
)

plt.title("Average Salary by Department")
plt.xlabel("Department")
plt.ylabel("Average Salary")

plt.show()
```

---

# 64. Functionality Selection Cheat Sheet

| Requirement in Problem | Functionality |
|---|---|
| Draw trend | `plt.plot()` |
| Compare categories | `plt.bar()` / `sns.barplot()` |
| Relationship between variables | `plt.scatter()` |
| Data distribution | `plt.hist()` |
| Detect outliers | `sns.boxplot()` |
| Correlation | `df.corr()` + `sns.heatmap()` |
| Database connection | `sqlite3.connect()` |
| Execute SQL | `cursor.execute()` |
| Multiple inserts | `executemany()` |
| Retrieve all records | `fetchall()` |
| Retrieve one record | `fetchone()` |
| Pandas ↔ database | `pd.read_sql()` / `df.to_sql()` |
| Handle errors | `try-except` |
| Cleanup resources | `finally` / `with` |
| User/business invalid input | `raise ValueError` |
| Custom business error | Custom `Exception` |
| Verify programmer assumption | `assert` |
| Track application events | `logging` |
| Read entire file | `read()` |
| Read one line | `readline()` |
| Read all lines | `readlines()` |
| Automatically close file | `with open()` |
| CSV | `csv` module / Pandas |
| JSON | `json` |
| XML | `ElementTree` |
| File existence | `os.path.exists()` / `Path.exists()` |
| Directory operations | `os` / `pathlib` |
| Modern path handling | `pathlib.Path` |

---

# 65. Trainee Decision Framework

When trainees receive a practical question, teach them to ask these questions in order.

```text
1. Is there data?
       ↓
2. Where is the data?
       ↓
   CSV / JSON / XML / Database
       ↓
3. Do I need to transform it?
       ↓
   Pandas
       ↓
4. Do I need an error-handling mechanism?
       ↓
   try / except
       ↓
5. Do I need guaranteed cleanup?
       ↓
   with / finally
       ↓
6. Do I need to track execution?
       ↓
   logging
       ↓
7. Do I need visualization?
       ↓
   Matplotlib / Seaborn
```

---

# 66. Most Important Patterns to Memorize

## File

```python
with open("file.txt", "r") as file:
    data = file.read()
```

## Exception

```python
try:
    risky_operation()

except SpecificError as e:
    handle_error(e)

finally:
    cleanup()
```

## Custom Exception

```python
class MyError(Exception):
    pass

raise MyError("Something went wrong")
```

## Logging

```python
import logging

logging.basicConfig(level=logging.INFO)

logging.info("Started")
logging.error("Failed")
```

## SQLite

```python
connection = sqlite3.connect("database.db")
cursor = connection.cursor()

cursor.execute("SQL QUERY")

connection.commit()
connection.close()
```

## SQLAlchemy

```python
from sqlalchemy import create_engine

engine = create_engine("sqlite:///database.db")

df = pd.read_sql(
    "SELECT * FROM employees",
    engine
)
```

## Visualization

```python
sns.barplot(
    data=df,
    x="category",
    y="value"
)

plt.show()
```

---

# 67. Recommended Training Sequence

Rather than teaching these topics as completely isolated chapters, use this sequence.

## Day 1 — File Handling

- `open()`
- Read
- Write
- Append
- File modes
- `with`
- Context managers

## Day 2 — Structured Files

- CSV
- JSON
- XML
- Directory operations
- `os`
- `pathlib`

## Day 3 — Exception Handling

- `try`
- `except`
- Specific exceptions
- Multiple exceptions
- `else`
- `finally`
- `raise`
- Custom exceptions

## Day 4 — Assertions, Logging & Debugging

- `assert`
- Logging levels
- Logging to file
- `logging.exception()`
- Debugging strategy

## Day 5 — SQLite

- Connection
- Cursor
- CREATE
- INSERT
- SELECT
- UPDATE
- DELETE
- `commit()`
- Fetch methods

## Day 6 — SQLAlchemy

- Engine
- SQLite connection
- Pandas + SQLAlchemy
- `read_sql()`
- `to_sql()`

## Day 7 — Visualization

- Matplotlib
- Line
- Bar
- Scatter
- Histogram
- Pie
- Seaborn
- Box plot
- Heatmap

## Day 8 — Integrated Practical

```text
CSV
 ↓
Pandas
 ↓
SQLAlchemy
 ↓
SQLite
 ↓
SQL
 ↓
Exception Handling
 ↓
Logging
 ↓
Seaborn
```

---

# 68. Final Problem-Solving Mindset

The important skill is not memorizing every function.

Trainees should learn:

```text
PROBLEM STATEMENT
       ↓
IDENTIFY THE REQUIREMENT
       ↓
IDENTIFY THE DATA SOURCE
       ↓
CHOOSE THE PYTHON FUNCTIONALITY
       ↓
IMPLEMENT
       ↓
HANDLE ERRORS
       ↓
VALIDATE
       ↓
LOG IF REQUIRED
       ↓
VISUALIZE / REPORT
```

For example:

> "Read employee records from CSV, calculate average salary by department, store the records in SQLite, handle missing files, and display the result."

Break it down:

```text
CSV
 ↓
pd.read_csv()

Database
 ↓
SQLAlchemy + SQLite

Aggregation
 ↓
groupby() / SQL GROUP BY

Missing file
 ↓
try / except FileNotFoundError

Visualization
 ↓
sns.barplot()

Logging
 ↓
logging.info()
logging.exception()
```

This **requirement → functionality → implementation** approach is the most important practical skill for trainees.
