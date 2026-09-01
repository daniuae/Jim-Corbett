# Python — Data Structures, Control Structures & Regular Expressions

## 1. Data Structures

Python provides several built-in data structures:

| Data Structure | Ordered | Mutable | Duplicates | Example        |
| -------------- | ------- | ------- | ---------- | -------------- |
| List           | Yes     | Yes     | Yes        | `[10, 20, 30]` |
| Tuple          | Yes     | No      | Yes        | `(10, 20, 30)` |
| Set            | No      | Yes     | No         | `{10, 20, 30}` |
| Dictionary     | Yes*    | Yes     | Keys: No   | `{"id": 101}`  |

> **Note:** Dictionaries preserve insertion order in modern Python.

---

# 2. Lists

A **list** stores multiple values in a single variable.

```python
employees = ["John", "Priya", "Rahul", "Anita"]

print(employees)
print(employees[0])
print(employees[-1])
```

## List Operations

```python
employees.append("David")

employees.insert(1, "Kumar")

employees.remove("Rahul")

last_employee = employees.pop()

print(employees)
```

## List Slicing

```python
numbers = [10, 20, 30, 40, 50]

print(numbers[0:3])
print(numbers[:3])
print(numbers[2:])
print(numbers[::-1])
```

## Useful List Methods

```python
numbers.append(60)
numbers.extend([70, 80])
numbers.insert(0, 5)
numbers.remove(30)

numbers.sort()
numbers.reverse()

print(len(numbers))
print(max(numbers))
print(min(numbers))
print(sum(numbers))
```

## Real-World Example

```python
sales = [1200, 1500, 900, 2100, 1800]

total_sales = sum(sales)
average_sales = total_sales / len(sales)

print("Total:", total_sales)
print("Average:", average_sales)
```

---

# 3. Tuples

A tuple is similar to a list, but it is **immutable**.

```python
employee = (101, "John", "Data Engineer", 75000)

print(employee[0])
print(employee[1])
```

You cannot modify a tuple:

```python
employee[1] = "David"
```

This produces an error because tuples cannot be modified.

## Tuple Unpacking

```python
employee = (101, "John", 75000)

employee_id, name, salary = employee

print(employee_id)
print(name)
print(salary)
```

## List vs Tuple

Use a **list** when the data needs to change:

```python
shopping_cart = ["Laptop", "Mouse", "Keyboard"]
```

Use a **tuple** when the collection should remain fixed:

```python
coordinates = (13.0827, 80.2707)
```

---

# 4. Conditional Statements

Conditional statements allow Python to make decisions.

## if

```python
salary = 75000

if salary > 50000:
    print("High salary")
```

## if / else

```python
age = 25

if age >= 18:
    print("Eligible")
else:
    print("Not eligible")
```

## if / elif / else

```python
score = 82

if score >= 90:
    grade = "A"
elif score >= 75:
    grade = "B"
elif score >= 60:
    grade = "C"
else:
    grade = "F"

print(grade)
```

## Business Example

```python
sales = 150000

if sales >= 200000:
    commission = 0.10
elif sales >= 100000:
    commission = 0.07
else:
    commission = 0.05

print(commission)
```

---

# 5. for Loops

A `for` loop is used to iterate over a collection.

```python
employees = ["John", "Priya", "Rahul"]

for employee in employees:
    print(employee)
```

## Using range()

```python
for i in range(1, 6):
    print(i)
```

Output:

```text
1
2
3
4
5
```

## Processing Sales

```python
sales = [1000, 2500, 1800, 3200]

for sale in sales:
    print("Sale:", sale)
```

## Nested Loops

```python
departments = ["IT", "HR"]
employees = ["John", "Priya"]

for department in departments:
    for employee in employees:
        print(department, employee)
```

---

# 6. while Loop

A `while` loop continues as long as a condition is true.

```python
count = 1

while count <= 5:
    print(count)
    count += 1
```

## Example

```python
balance = 10000

while balance > 0:
    print("Current balance:", balance)
    balance -= 2000
```

## Avoid Infinite Loops

Incorrect:

```python
count = 1

while count <= 5:
    print(count)
```

The condition never changes, so the loop never ends.

Correct:

```python
count = 1

while count <= 5:
    print(count)
    count += 1
```

---

# 7. break

`break` immediately exits the loop.

```python
numbers = [10, 20, 30, 40, 50]

for number in numbers:
    if number == 30:
        break

    print(number)
```

Output:

```text
10
20
```

## Real-World Example

Find the first failed transaction:

```python
transactions = ["SUCCESS", "SUCCESS", "FAILED", "SUCCESS"]

for transaction in transactions:
    if transaction == "FAILED":
        print("Failed transaction found")
        break
```

---

# 8. continue

`continue` skips the current iteration and moves to the next iteration.

```python
numbers = [1, 2, 3, 4, 5]

for number in numbers:
    if number % 2 == 0:
        continue

    print(number)
```

Output:

```text
1
3
5
```

## ETL Example

Skip invalid records:

```python
records = [
    {"id": 101, "name": "John"},
    {"id": None, "name": "Priya"},
    {"id": 103, "name": "David"}
]

for record in records:

    if record["id"] is None:
        continue

    print("Processing:", record)
```

---

# 9. pass

`pass` does nothing.

It is useful as a placeholder.

```python
for employee in employees:
    pass
```

It can also be used inside an unfinished function:

```python
def process_data():
    pass
```

## Difference Between break, continue and pass

| Statement  | Purpose                    |
| ---------- | -------------------------- |
| `break`    | Exit the loop completely   |
| `continue` | Skip the current iteration |
| `pass`     | Do nothing; placeholder    |

---

# 10. List Comprehensions

List comprehensions provide a concise way to create lists.

## Traditional Approach

```python
numbers = [1, 2, 3, 4, 5]

squares = []

for number in numbers:
    squares.append(number ** 2)

print(squares)
```

## List Comprehension

```python
squares = [number ** 2 for number in numbers]

print(squares)
```

## List Comprehension with Condition

```python
even_numbers = [
    number
    for number in numbers
    if number % 2 == 0
]

print(even_numbers)
```

## Business Example

```python
sales = [500, 1500, 2500, 800, 3000]

high_value_sales = [
    sale
    for sale in sales
    if sale > 1000
]

print(high_value_sales)
```

---

# 11. Set Comprehensions

Sets automatically remove duplicate values.

```python
numbers = [1, 2, 2, 3, 3, 4]

unique_numbers = {
    number
    for number in numbers
}

print(unique_numbers)
```

## Example — Data Cleaning

```python
names = ["john", "JOHN", "priya", "Priya"]

normalized_names = {
    name.lower()
    for name in names
}

print(normalized_names)
```

Possible output:

```text
{'john', 'priya'}
```

---

# 12. Dictionary Comprehensions

Dictionary comprehensions create dictionaries.

```python
numbers = [1, 2, 3, 4, 5]

squares = {
    number: number ** 2
    for number in numbers
}

print(squares)
```

Output:

```text
{
    1: 1,
    2: 4,
    3: 9,
    4: 16,
    5: 25
}
```

## Business Example

```python
employees = {
    "John": 75000,
    "Priya": 85000,
    "David": 65000
}

high_salary = {
    name: salary
    for name, salary in employees.items()
    if salary > 70000
}

print(high_salary)
```

---

# 13. Regular Expressions

Regular expressions, commonly called **regex**, are patterns used to:

* Search text
* Validate data
* Extract information
* Replace text
* Clean text

Python provides the `re` module.

```python
import re
```

---

# 14. Basic Regex Matching

```python
text = "My employee ID is EMP12345"

result = re.search(r"EMP\d+", text)

print(result.group())
```

Output:

```text
EMP12345
```

### Understanding the Pattern

```text
EMP\d+
```

| Pattern | Meaning                 |
| ------- | ----------------------- |
| `EMP`   | Literal text            |
| `\d`    | Digit                   |
| `+`     | One or more occurrences |

Therefore:

```text
EMP\d+
```

means:

> Find `EMP` followed by one or more digits.

---

# 15. Important Regex Patterns

| Pattern | Meaning                     |    |
| ------- | --------------------------- | -- |
| `\d`    | Digit                       |    |
| `\D`    | Not a digit                 |    |
| `\w`    | Word character              |    |
| `\W`    | Non-word character          |    |
| `\s`    | Whitespace                  |    |
| `.`     | Any character               |    |
| `^`     | Start of string             |    |
| `$`     | End of string               |    |
| `+`     | One or more                 |    |
| `*`     | Zero or more                |    |
| `?`     | Zero or one                 |    |
| `{n}`   | Exactly n occurrences       |    |
| `{n,m}` | Between n and m occurrences |    |
| `[]`    | Character set               |    |
| `()`    | Group                       |    |
| `       | `                           | OR |

---

# 16. Regex — Email Validation

```python
import re

email = "john@example.com"

pattern = r"^[\w.-]+@[\w.-]+\.\w+$"

if re.match(pattern, email):
    print("Valid email")
else:
    print("Invalid email")
```

---

# 17. Regex — Extract Phone Numbers

```python
import re

text = """
Contact John at 9876543210
or Priya at 9123456780
"""

phones = re.findall(r"\d{10}", text)

print(phones)
```

Output:

```text
['9876543210', '9123456780']
```

---

# 18. Regex — Extract Numbers

```python
text = "Order 101 contains 25 products costing 5000"

numbers = re.findall(r"\d+", text)

print(numbers)
```

Output:

```text
['101', '25', '5000']
```

---

# 19. Regex — Replace Text

Regex is particularly useful for data cleaning.

```python
import re

text = "Python     is     powerful"

clean_text = re.sub(r"\s+", " ", text)

print(clean_text)
```

Output:

```text
Python is powerful
```

Here:

```text
\s+
```

means:

> One or more whitespace characters.

---

# 20. Important `re` Functions

| Function         | Purpose                     |
| ---------------- | --------------------------- |
| `re.search()`    | Search for a pattern        |
| `re.match()`     | Match from the beginning    |
| `re.fullmatch()` | Match the entire string     |
| `re.findall()`   | Find all matches            |
| `re.finditer()`  | Return match objects        |
| `re.sub()`       | Replace matches             |
| `re.split()`     | Split using a regex pattern |

Example:

```python
import re

text = "Python,SQL,Pandas,NumPy"

result = re.split(",", text)

print(result)
```

Output:

```text
['Python', 'SQL', 'Pandas', 'NumPy']
```

---

# 21. Mini ETL Project

Let's combine everything.

Suppose we receive raw customer data:

```python
customers = [
    "101,John, john@gmail.com, Chennai",
    "102,Priya, priya@gmail.com, Bangalore",
    "103,David, invalid_email, Mumbai",
    "104,Anita, anita@gmail.com, Chennai"
]
```

Our goal is to:

1. Read the records
2. Split the fields
3. Clean whitespace
4. Validate email
5. Remove invalid records
6. Store clean records
7. Filter Chennai customers

---

## Step 1 — Loop Through Records

```python
import re

valid_customers = []

for record in customers:

    customer_id, name, email, city = record.split(",")

    customer_id = customer_id.strip()
    name = name.strip()
    email = email.strip()
    city = city.strip()

    valid_customers.append({
        "customer_id": customer_id,
        "name": name,
        "email": email,
        "city": city
    })

print(valid_customers)
```

---

## Step 2 — Validate Email

```python
import re

pattern = r"^[\w.-]+@[\w.-]+\.\w+$"

valid_customers = []

for record in customers:

    customer_id, name, email, city = record.split(",")

    customer_id = customer_id.strip()
    name = name.strip()
    email = email.strip()
    city = city.strip()

    if not re.match(pattern, email):
        continue

    valid_customers.append({
        "customer_id": customer_id,
        "name": name,
        "email": email,
        "city": city
    })

print(valid_customers)
```

The invalid email record is skipped.

---

## Step 3 — Filter Chennai Customers

```python
chennai_customers = [
    customer
    for customer in valid_customers
    if customer["city"] == "Chennai"
]

print(chennai_customers)
```

---

# 22. Complete Mini ETL Program

```python
import re

# SOURCE
customers = [
    "101,John, john@gmail.com, Chennai",
    "102,Priya, priya@gmail.com, Bangalore",
    "103,David, invalid_email, Mumbai",
    "104,Anita, anita@gmail.com, Chennai"
]

# VALIDATION PATTERN
email_pattern = r"^[\w.-]+@[\w.-]+\.\w+$"

# TRANSFORM
valid_customers = []

for record in customers:

    customer_id, name, email, city = record.split(",")

    customer_id = customer_id.strip()
    name = name.strip()
    email = email.strip()
    city = city.strip()

    # Validate email
    if not re.match(email_pattern, email):
        continue

    valid_customers.append({
        "customer_id": customer_id,
        "name": name,
        "email": email,
        "city": city
    })

# FILTER
chennai_customers = [
    customer
    for customer in valid_customers
    if customer["city"] == "Chennai"
]

# OUTPUT
print("Valid Customers:")
for customer in valid_customers:
    print(customer)

print("\nChennai Customers:")
for customer in chennai_customers:
    print(customer)
```

---

# 23. SQL vs Python Thinking

If you already know SQL, this comparison is very useful.

| SQL             | Python                           |
| --------------- | -------------------------------- |
| `WHERE`         | `if`                             |
| `CASE WHEN`     | `if / elif / else`               |
| `GROUP BY`      | Dictionary / Pandas `groupby()`  |
| `ORDER BY`      | `sort()` / `sorted()`            |
| `DISTINCT`      | `set()`                          |
| `JOIN`          | Dictionary / Pandas `merge()`    |
| `UNION`         | List/set operations              |
| `LIMIT`         | Slicing                          |
| Subquery        | Nested logic/functions           |
| Row processing  | Loops                            |
| Regex functions | `re` module                      |
| Variable        | Temporary result                 |
| Table           | List of dictionaries / DataFrame |

### SQL

```sql
SELECT *
FROM employees
WHERE salary > 70000;
```

### Python

```python
high_salary = [
    employee
    for employee in employees
    if employee["salary"] > 70000
]
```

### Pandas

```python
high_salary = df[df["salary"] > 70000]
```

---

# 24. Hands-On Exercises

## Exercise 1 — Lists

Create a list containing 10 employee salaries.

Perform:

* Add a salary
* Remove a salary
* Find the highest salary
* Find the lowest salary
* Calculate total salary
* Calculate average salary
* Sort salaries

---

## Exercise 2 — Tuples

Create a tuple:

```python
employee = (
    101,
    "John",
    "Data Engineer",
    75000
)
```

Extract each value using tuple unpacking.

---

## Exercise 3 — Conditions

Create a salary grading program.

```text
Salary >= 100000 → Senior
Salary >= 70000  → Mid-Level
Salary >= 40000  → Junior
Otherwise        → Entry-Level
```

---

## Exercise 4 — for Loop

Given:

```python
sales = [1000, 2500, 1800, 4500, 3000]
```

Calculate:

* Total sales
* Number of transactions
* Highest sale
* Lowest sale
* Average sale

---

## Exercise 5 — while Loop

Create a program that starts with:

```python
balance = 10000
```

Withdraw `1000` repeatedly until the balance becomes zero.

---

## Exercise 6 — break

Given:

```python
transactions = [
    "SUCCESS",
    "SUCCESS",
    "SUCCESS",
    "FAILED",
    "SUCCESS"
]
```

Stop processing when the first `FAILED` transaction is found.

---

## Exercise 7 — continue

Given:

```python
numbers = [10, 20, -5, 30, -10, 40]
```

Print only positive numbers using `continue`.

---

## Exercise 8 — List Comprehension

Given:

```python
numbers = range(1, 21)
```

Create:

1. Squares
2. Even numbers
3. Odd numbers
4. Numbers greater than 10

---

## Exercise 9 — Dictionary Comprehension

Given:

```python
employees = {
    "John": 75000,
    "Priya": 85000,
    "David": 65000,
    "Anita": 95000
}
```

Create a new dictionary containing employees whose salary is greater than `70000`.

---

## Exercise 10 — Regex

Extract all email addresses from:

```python
text = """
Contact john@gmail.com
or priya@yahoo.com
or david@company.com
"""
```

Expected result:

```text
[
    'john@gmail.com',
    'priya@yahoo.com',
    'david@company.com'
]
```

---

# 25. Challenge — Customer Data Cleaning

Given:

```python
customers = [
    "101, John, john@gmail.com, Chennai",
    "102, Priya, priya@gmail.com, Bangalore",
    "103, David, invalid, Mumbai",
    "104, Anita, anita@gmail.com, Chennai",
    "105, Kumar, kumar@gmail.com, Chennai",
    "106, Ravi, ravi@gmail.com, Bangalore"
]
```

Build a program that:

1. Splits every record
2. Removes unnecessary whitespace
3. Validates email addresses using regex
4. Skips invalid customers
5. Stores valid customers as dictionaries
6. Finds all Chennai customers
7. Finds all Bangalore customers
8. Counts valid customers
9. Counts invalid customers
10. Prints the final cleaned dataset

Expected structure:

```python
[
    {
        "customer_id": "101",
        "name": "John",
        "email": "john@gmail.com",
        "city": "Chennai"
    },
    ...
]
```

---

# 26. Learning Roadmap

```text
                    PYTHON BASICS
                         |
             +-----------+-----------+
             |                       |
       DATA STRUCTURES        CONTROL STRUCTURES
             |                       |
       +-----+-----+          +------+------+
       |     |     |          |      |      |
     List  Tuple  Set       if/elif  for   while
       |                  /else      |      |
       |                              +------+
       |                                 |
       +---------- Comprehensions -------+
                         |
                    Dictionaries
                         |
                    Regex / re
                         |
                  Data Cleaning
                         |
                 File Processing
                         |
              Exception Handling
                         |
                       NumPy
                         |
                      Pandas
                         |
                    SQL + Python
                         |
                    ETL Pipeline
                         |
               Data Engineering
```

# Key Takeaways

You should be comfortable with these before moving deeper into Pandas:

* **Lists** → collections that can change
* **Tuples** → fixed collections
* **Sets** → unique values
* **Dictionaries** → key-value data
* **if/elif/else** → decision making
* **for** → iterate through data
* **while** → repeat based on a condition
* **break** → stop a loop
* **continue** → skip an iteration
* **pass** → placeholder
* **List comprehension** → create lists concisely
* **Set comprehension** → create unique collections
* **Dictionary comprehension** → create dictionaries concisely
* **Regex** → search, validate, extract, and clean text

These concepts form the foundation for **Python data processing and ETL**.
