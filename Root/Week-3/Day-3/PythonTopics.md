# **Python — Data Structures, Control Structures & Regular Expressions**

## **1\. Data Structures**

Data structures are ways of **storing and organizing data** so that we can access and manipulate it efficiently.

The most important Python data structures are:

| Data Structure | Ordered | Mutable | Duplicates | Example |
| ----- | ----- | ----- | ----- | ----- |
| List | ✅ | ✅ | ✅ | \[10, 20, 30\] |
| Tuple | ✅ | ❌ | ✅ | (10, 20, 30\) |
| Set | ❌ | ✅ | ❌ | {10, 20, 30} |
| Dictionary | ✅ | ✅ | Keys ❌ | {"id": 101} |

---

# **2\. Lists**

A **list** stores multiple values in a single variable.

numbers \= \[10, 20, 30, 40, 50\]

print(numbers)

Output:

\[10, 20, 30, 40, 50\]

## **Creating a List**

names \= \["John", "Alice", "David"\]

prices \= \[100, 200, 300\]

mixed \= \[101, "Python", 99.5, True\]  
---

## **Accessing List Elements**

Python uses **zero-based indexing**.

names \= \["John", "Alice", "David"\]

print(names\[0\])  
print(names\[1\])  
print(names\[2\])

Output:

John  
Alice  
David

### **Negative Indexing**

print(names\[-1\])

Output:

David  
Index:

  0       1        2  
 John    Alice    David  
 \-3      \-2       \-1  
---

# **3\. List Slicing**

numbers \= \[10, 20, 30, 40, 50\]

print(numbers\[1:4\])

Output:

\[20, 30, 40\]

Syntax:

list\[start:stop:step\]

Example:

print(numbers\[:3\])  
print(numbers\[2:\])  
print(numbers\[::2\])  
print(numbers\[::-1\])  
---

# **4\. Modifying Lists**

Lists are **mutable**.

names \= \["John", "Alice", "David"\]

names\[1\] \= "Robert"

print(names)

Output:

\['John', 'Robert', 'David'\]  
---

# **5\. List Methods**

## **append()**

Adds one item.

numbers \= \[10, 20, 30\]

numbers.append(40)

print(numbers)  
\[10, 20, 30, 40\]  
---

## **insert()**

Adds an item at a specific position.

numbers.insert(1, 15\)

print(numbers)  
---

## **extend()**

Adds multiple elements.

numbers.extend(\[50, 60, 70\])

print(numbers)  
---

## **remove()**

Removes a specific value.

numbers.remove(30)  
---

## **pop()**

Removes an item using its index.

numbers.pop(1)

If no index is provided:

numbers.pop()

It removes the last element.

---

## **sort()**

numbers \= \[50, 10, 40, 20, 30\]

numbers.sort()

print(numbers)

Output:

\[10, 20, 30, 40, 50\]

Descending:

numbers.sort(reverse=True)  
---

## **reverse()**

numbers.reverse()  
---

## **count()**

numbers \= \[10, 20, 10, 30, 10\]

print(numbers.count(10))

Output:

3  
---

## **index()**

names \= \["John", "Alice", "David"\]

print(names.index("Alice"))

Output:

1  
---

# **6\. Tuples**

A tuple is similar to a list, but it is **immutable**.

employee \= (101, "John", "IT", 75000\)

print(employee)

You can access values:

print(employee\[0\])  
print(employee\[1\])

But you cannot modify them:

employee\[1\] \= "David"

This produces an error.

### **When should you use a tuple?**

Use a tuple when the data should not change.

Example:

coordinates \= (19.0760, 72.8777)  
months \= ("Jan", "Feb", "Mar", "Apr")  
---

# **7\. List vs Tuple**

employees \= \["John", "Alice", "David"\]

can be modified.

employees\[0\] \= "Robert"

A tuple:

employees \= ("John", "Alice", "David")

cannot be modified.

### **Practical rule**

**List → data may change**

**Tuple → data should remain fixed**

---

# **8\. Conditional Statements**

Conditional statements allow Python to make decisions.

The basic structure is:

if condition:  
    statement

Example:

age \= 25

if age \>= 18:  
    print("Eligible to vote")  
---

# **9\. if / else**

age \= 16

if age \>= 18:  
    print("Eligible")  
else:  
    print("Not eligible")  
---

# **10\. if / elif / else**

Use `elif` when there are multiple conditions.

marks \= 75

if marks \>= 90:  
    grade \= "A"  
elif marks \>= 75:  
    grade \= "B"  
elif marks \>= 60:  
    grade \= "C"  
else:  
    grade \= "D"

print(grade)  
---

# **11\. Multiple Conditions**

Use:

* `and`  
* `or`  
* `not`

Example:

age \= 25  
salary \= 50000

if age \>= 18 and salary \>= 30000:  
    print("Eligible")

Using `or`:

day \= "Saturday"

if day \== "Saturday" or day \== "Sunday":  
    print("Weekend")

Using `not`:

is\_logged\_in \= False

if not is\_logged\_in:  
    print("Please login")  
---

# **12\. Loops**

Loops allow us to execute code repeatedly.

Python has two major loops:

for  
while  
---

# **13\. for Loop**

Use a `for` loop when you want to iterate over a sequence.

names \= \["John", "Alice", "David"\]

for name in names:  
    print(name)

Output:

John  
Alice  
David  
---

# **14\. range()**

`range()` is commonly used with `for`.

for i in range(5):  
    print(i)

Output:

0  
1  
2  
3  
4

Notice that `5` is not included.

for i in range(1, 6):  
    print(i)

Output:

1  
2  
3  
4  
5  
---

# **15\. range() with Step**

for i in range(0, 11, 2):  
    print(i)

Output:

0  
2  
4  
6  
8  
10  
---

# **16\. while Loop**

A `while` loop executes as long as a condition is true.

count \= 1

while count \<= 5:  
    print(count)  
    count \+= 1

Output:

1  
2  
3  
4  
5

### **Important**

Always make sure the condition eventually becomes false.

Otherwise you can create an **infinite loop**.

---

# **17\. break**

`break` immediately exits the loop.

for i in range(1, 11):

    if i \== 5:  
        break

    print(i)

Output:

1  
2  
3  
4  
---

# **18\. continue**

`continue` skips the current iteration.

for i in range(1, 6):

    if i \== 3:  
        continue

    print(i)

Output:

1  
2  
4  
5  
---

# **19\. pass**

`pass` does nothing.

It is useful as a placeholder.

for i in range(5):

    if i \== 3:  
        pass

    print(i)

Another example:

def calculate\_salary():  
    pass

You can implement the function later.

---

# **20\. break vs continue vs pass**

| Statement | Purpose |
| ----- | ----- |
| `break` | Exit the loop |
| `continue` | Skip current iteration |
| `pass` | Do nothing |

Think:

break     → STOP  
continue  → SKIP  
pass      → DO NOTHING  
---

# **21\. List Comprehension**

List comprehensions provide a compact way of creating lists.

Normal approach:

numbers \= \[\]

for i in range(1, 6):  
    numbers.append(i)

print(numbers)

List comprehension:

numbers \= \[i for i in range(1, 6)\]

print(numbers)  
---

# **22\. List Comprehension with Calculation**

squares \= \[x \* x for x in range(1, 6)\]

print(squares)

Output:

\[1, 4, 9, 16, 25\]  
---

# **23\. List Comprehension with Condition**

numbers \= \[1, 2, 3, 4, 5, 6\]

even\_numbers \= \[x for x in numbers if x % 2 \== 0\]

print(even\_numbers)

Output:

\[2, 4, 6\]  
---

# **24\. Dictionary Comprehension**

Normal:

numbers \= \[1, 2, 3, 4, 5\]

squares \= {}

for x in numbers:  
    squares\[x\] \= x \* x

Dictionary comprehension:

squares \= {x: x \* x for x in numbers}

print(squares)

Output:

{1: 1, 2: 4, 3: 9, 4: 16, 5: 25}  
---

# **25\. Dictionary Comprehension with Condition**

numbers \= range(1, 11\)

even\_squares \= {  
    x: x \* x  
    for x in numbers  
    if x % 2 \== 0  
}

print(even\_squares)  
---

# **26\. Set Comprehension**

Sets automatically remove duplicates.

numbers \= \[1, 2, 2, 3, 3, 4\]

unique \= {x for x in numbers}

print(unique)

Output:

{1, 2, 3, 4}

Example:

squares \= {x \* x for x in range(1, 6)}

print(squares)  
---

# **27\. Regular Expressions**

Regular expressions, commonly called **Regex**, are used for finding patterns in text.

Python provides the `re` module.

import re

Regex is commonly used for:

* Email validation  
* Phone number validation  
* Extracting numbers  
* Searching text  
* Finding dates  
* Cleaning data  
* Log analysis  
* ETL pipelines

---

# **28\. re.search()**

Searches for a pattern anywhere in a string.

import re

text \= "Python is powerful"

result \= re.search("Python", text)

if result:  
    print("Found")  
---

# **29\. re.match()**

Checks only at the beginning.

import re

text \= "Python is powerful"

result \= re.match("Python", text)

if result:  
    print("Matched")  
---

# **30\. re.findall()**

Finds all occurrences.

import re

text \= "Python SQL Python Pandas Python"

result \= re.findall("Python", text)

print(result)

Output:

\['Python', 'Python', 'Python'\]  
---

# **31\. Extract Numbers**

import re

text \= "Order 101 contains 25 products"

numbers \= re.findall(r"\\d+", text)

print(numbers)

Output:

\['101', '25'\]

Here:

\\d → digit  
\+  → one or more  
---

# **32\. Common Regex Patterns**

| Pattern | Meaning |
| ----- | ----- |
| `\d` | Digit |
| `\D` | Non-digit |
| `\w` | Word character |
| `\W` | Non-word character |
| `\s` | Whitespace |
| `\S` | Non-whitespace |
| `.` | Any character |
| `^` | Beginning |
| `$` | End |
| `+` | One or more |
| `*` | Zero or more |
| `?` | Zero or one |
| `{n}` | Exactly n |
| `{n,m}` | n to m |

---

# **33\. Email Validation**

A basic example:

import re

email \= "john@example.com"

pattern \= r"^\[\\w.-\]+@\[\\w.-\]+\\.\\w+$"

if re.match(pattern, email):  
    print("Valid email")  
else:  
    print("Invalid email")  
---

# **34\. Phone Number Validation**

Example for a 10-digit number:

import re

phone \= "9876543210"

pattern \= r"^\\d{10}$"

if re.match(pattern, phone):  
    print("Valid phone number")  
else:  
    print("Invalid phone number")  
---

# **35\. Extract Email Addresses**

import re

text \= """  
Contact john@example.com  
or alice@gmail.com  
for more information.  
"""

emails \= re.findall(  
    r"\[\\w.-\]+@\[\\w.-\]+\\.\\w+",  
    text  
)

print(emails)  
---

# **36\. Regex \+ ETL Example**

Suppose you receive messy customer data:

data \= """  
Customer: John, Email: john@gmail.com, Phone: 9876543210  
Customer: Alice, Email: alice@yahoo.com, Phone: 9123456789  
"""

You can extract the emails:

import re

emails \= re.findall(  
    r"\[\\w.-\]+@\[\\w.-\]+\\.\\w+",  
    data  
)

print(emails)

Extract phone numbers:

phones \= re.findall(  
    r"\\d{10}",  
    data  
)

print(phones)

This is extremely useful in **data engineering and ETL**.

---

# **37\. Mini Project — Employee Data Processor**

Consider:

employees \= \[  
    ("E101", "John", 75000),  
    ("E102", "Alice", 85000),  
    ("E103", "David", 65000),  
    ("E104", "Robert", 95000\)  
\]

## **Find employees earning more than 70,000**

high\_salary \= \[  
    employee  
    for employee in employees  
    if employee\[2\] \> 70000  
\]

print(high\_salary)  
---

## **Create salary dictionary**

salary \= {  
    employee\[0\]: employee\[2\]  
    for employee in employees  
}

print(salary)

Result:

{  
    'E101': 75000,  
    'E102': 85000,  
    'E103': 65000,  
    'E104': 95000  
}  
---

## **Find employees earning more than 80,000**

high\_salary \= {  
    employee\[0\]: employee\[2\]  
    for employee in employees  
    if employee\[2\] \> 80000  
}

print(high\_salary)  
---

# **38\. Hands-On Practice**

## **Beginner**

### **Problem 1 — Even Numbers**

Create a list from 1 to 50 containing only even numbers.

Expected:

\[2, 4, 6, ..., 50\]  
---

### **Problem 2 — Squares**

Create a list containing squares of numbers from 1 to 10\.

---

### **Problem 3 — Employee Names**

Given:

employees \= \["John", "Alice", "David", "Robert", "Sarah"\]

Print each employee using a `for` loop.

---

### **Problem 4 — Salary Classification**

Given:

salary \= 75000

Display:

High Salary

if salary \>= 70000, otherwise:

Normal Salary  
---

### **Problem 5 — Multiplication Table**

Ask the user for a number and print its multiplication table from 1 to 10\.

Example:

Enter number: 5

5 x 1 \= 5  
5 x 2 \= 10  
...  
5 x 10 \= 50  
---

# **39\. Intermediate Problems**

### **Problem 6 — Find Maximum**

Given:

numbers \= \[45, 12, 78, 34, 89, 23\]

Find the maximum number **without using `max()`**.

---

### **Problem 7 — Remove Duplicates**

Given:

numbers \= \[10, 20, 10, 30, 20, 40, 30\]

Create a collection containing only unique values.

---

### **Problem 8 — Employee Filtering**

Given:

employees \= \[  
    ("E101", "John", 45000),  
    ("E102", "Alice", 75000),  
    ("E103", "David", 55000),  
    ("E104", "Robert", 95000\)  
\]

Find employees whose salary is greater than `60000`.

---

### **Problem 9 — Dictionary Comprehension**

Create:

{  
  1: 1,  
  2: 4,  
  3: 9,  
  ...  
  10: 100  
}

using dictionary comprehension.

---

### **Problem 10 — Regex**

Given:

text \= """  
John: john@gmail.com  
Alice: alice@yahoo.com  
David: david@company.com  
"""

Extract all email addresses using Regex.

---

# **40\. Challenge — Data Cleaning Pipeline**

Use this raw data:

raw\_data \= """  
John, john@gmail.com, 75000  
Alice, alice@gmail.com, 85000  
David, invalid-email, 65000  
Robert, robert@gmail.com, 95000  
Sarah, sarah@gmail.com, 55000  
"""

Build a small Python pipeline that:

RAW DATA  
   ↓  
Split records  
   ↓  
Extract name/email/salary  
   ↓  
Validate email using Regex  
   ↓  
Convert salary to integer  
   ↓  
Filter salary \> 70000  
   ↓  
Create list/dictionary  
   ↓  
Display clean data

Expected conceptually:

John   → valid   → 75000  
Alice  → valid   → 85000  
David  → invalid → rejected  
Robert → valid   → 95000  
Sarah  → valid   → rejected

This single exercise combines:

**Lists \+ Tuples \+ Conditions \+ Loops \+ `break`/`continue` \+ Comprehensions \+ Regex**

and is a good bridge from **Python basics into Pandas and ETL/data engineering**.

