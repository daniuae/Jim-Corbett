# Employee Salary Calculator

**Technology:** Python
**Difficulty:** Medium
**Marks:** 20
**Duration:** 30 Minutes

---

## Task

Create a Python program to calculate and display an employee's **monthly and annual salary details**.

Write your complete program in:

```text
employee_salary.py
```

---

## Requirements

### 1. Accept Employee Details

Use `input()` to accept the following values from the user:

* Employee Name
* Employee ID
* Basic Monthly Salary
* Monthly Bonus
* Monthly Deduction

Use appropriate data types for each value.

---

### 2. Calculate Salary Details

Perform the following calculations:

```text
Gross Monthly Salary = Basic Monthly Salary + Monthly Bonus

Net Monthly Salary = Gross Monthly Salary - Monthly Deduction

Annual Gross Salary = Gross Monthly Salary × 12

Annual Net Salary = Net Monthly Salary × 12
```

---

### 3. Display the Result

Display all of the following details:

* Employee Name
* Employee ID
* Basic Monthly Salary
* Monthly Bonus
* Monthly Deduction
* Gross Monthly Salary
* Net Monthly Salary
* Annual Gross Salary
* Annual Net Salary

---

## Sample Input

```text
Enter Employee Name: Rahul
Enter Employee ID: 101
Enter Basic Monthly Salary: 30000
Enter Monthly Bonus: 5000
Enter Monthly Deduction: 2000
```

---

## Expected Output

```text
Employee Salary Summary

Employee Name: Rahul
Employee ID: 101
Basic Monthly Salary: 30000.0
Monthly Bonus: 5000.0
Monthly Deduction: 2000.0
Gross Monthly Salary: 35000.0
Net Monthly Salary: 33000.0
Annual Gross Salary: 420000.0
Annual Net Salary: 396000.0
```

---

# Additional Instructions

1. Write the solution only in `employee_salary.py`.
2. Use Python variables to store all input values.
3. Use Python variables to store all calculated values.
4. Use appropriate type conversion for numeric inputs.
5. Use arithmetic operators to perform the calculations.
6. Use `print()` to display the final results.
7. Add meaningful comments to explain the important sections of the program.
8. The program should run without syntax or runtime errors.

---

# Starter Template

Students may use the following structure as a starting point:

```python
# Employee Salary Calculator

# Accept employee details
employee_name = input("Enter Employee Name: ")
employee_id = int(input("Enter Employee ID: "))
basic_salary = float(input("Enter Basic Monthly Salary: "))
monthly_bonus = float(input("Enter Monthly Bonus: "))
monthly_deduction = float(input("Enter Monthly Deduction: "))

# Calculate monthly salary
gross_monthly_salary = basic_salary + monthly_bonus
net_monthly_salary = gross_monthly_salary - monthly_deduction

# Calculate annual salary
annual_gross_salary = gross_monthly_salary * 12
annual_net_salary = net_monthly_salary * 12

# Display salary summary
print("\nEmployee Salary Summary\n")

print("Employee Name:", employee_name)
print("Employee ID:", employee_id)
print("Basic Monthly Salary:", basic_salary)
print("Monthly Bonus:", monthly_bonus)
print("Monthly Deduction:", monthly_deduction)
print("Gross Monthly Salary:", gross_monthly_salary)
print("Net Monthly Salary:", net_monthly_salary)
print("Annual Gross Salary:", annual_gross_salary)
print("Annual Net Salary:", annual_net_salary)
```

---

# Marking Scheme – 20 Marks

| Criteria                                                           |  Marks |
| ------------------------------------------------------------------ | -----: |
| Accepting all required inputs correctly                            |      4 |
| Correct use of variables, data types, and type conversion          |      3 |
| Correct calculation of Gross Monthly Salary and Net Monthly Salary |      4 |
| Correct calculation of Annual Gross Salary and Annual Net Salary   |      3 |
| Displaying all required output clearly and correctly               |      3 |
| Use of meaningful comments and readable Python code                |      2 |
| Program executes successfully without errors                       |      1 |
| **Total**                                                          | **20** |

---

# Skills Tested

This exercise tests the following Python fundamentals:

* `input()`
* Variables
* Strings
* Integers
* Floating-point numbers
* Type conversion using `int()` and `float()`
* Arithmetic operators
* Addition (`+`)
* Subtraction (`-`)
* Multiplication (`*`)
* `print()`
* Comments
* Basic program structure

---

# Student Checklist

Before submitting `employee_salary.py`, verify:

* [ ] Employee Name is accepted.
* [ ] Employee ID is accepted.
* [ ] Basic Monthly Salary is accepted.
* [ ] Monthly Bonus is accepted.
* [ ] Monthly Deduction is accepted.
* [ ] Numeric inputs use appropriate type conversion.
* [ ] Gross Monthly Salary is calculated correctly.
* [ ] Net Monthly Salary is calculated correctly.
* [ ] Annual Gross Salary is calculated correctly.
* [ ] Annual Net Salary is calculated correctly.
* [ ] All required details are displayed.
* [ ] Comments are included.
* [ ] Program runs without errors.


# Solution

```python
# Employee Salary Calculator
# This program calculates an employee's monthly and annual salary details.

# --------------------------------------------------
# Step 1: Accept employee details from the user
# --------------------------------------------------

employee_name = input("Enter Employee Name: ")
employee_id = int(input("Enter Employee ID: "))

basic_salary = float(input("Enter Basic Monthly Salary: "))
monthly_bonus = float(input("Enter Monthly Bonus: "))
monthly_deduction = float(input("Enter Monthly Deduction: "))


# --------------------------------------------------
# Step 2: Calculate monthly salary
# --------------------------------------------------

# Gross salary = Basic salary + Bonus
gross_monthly_salary = basic_salary + monthly_bonus

# Net salary = Gross salary - Deduction
net_monthly_salary = gross_monthly_salary - monthly_deduction


# --------------------------------------------------
# Step 3: Calculate annual salary
# --------------------------------------------------

# Annual gross salary = Gross monthly salary × 12
annual_gross_salary = gross_monthly_salary * 12

# Annual net salary = Net monthly salary × 12
annual_net_salary = net_monthly_salary * 12


# --------------------------------------------------
# Step 4: Display the salary summary
# --------------------------------------------------

print("\nEmployee Salary Summary\n")

print("Employee Name:", employee_name)
print("Employee ID:", employee_id)
print("Basic Monthly Salary:", basic_salary)
print("Monthly Bonus:", monthly_bonus)
print("Monthly Deduction:", monthly_deduction)
print("Gross Monthly Salary:", gross_monthly_salary)
print("Net Monthly Salary:", net_monthly_salary)
print("Annual Gross Salary:", annual_gross_salary)
print("Annual Net Salary:", annual_net_salary)
```

## 2. Step-by-Step Breakdown

### Step 1 — Get the employee name

```python
employee_name = input("Enter Employee Name: ")
```

`input()` always receives data as a **string**.

If the user enters:

```text
Rahul
```

Python stores:

```python
employee_name = "Rahul"
```

---

### Step 2 — Get the employee ID

```python
employee_id = int(input("Enter Employee ID: "))
```

Here we use `int()` because an employee ID such as `101` is an integer.

Without conversion:

```python
employee_id = input(...)
```

the value would be stored as:

```python
"101"
```

With `int()`:

```python
employee_id = 101
```

The important pattern is:

```python
int(input())
```

---

### Step 3 — Get the basic salary

```python
basic_salary = float(input("Enter Basic Monthly Salary: "))
```

We use `float()` because salary can contain decimal values.

For example:

```text
30000
```

becomes:

```python
30000.0
```

The pattern is:

```python
float(input())
```

---

### Step 4 — Get the monthly bonus

```python
monthly_bonus = float(input("Enter Monthly Bonus: "))
```

If the user enters:

```text
5000
```

Python stores:

```python
monthly_bonus = 5000.0
```

---

### Step 5 — Get the monthly deduction

```python
monthly_deduction = float(input("Enter Monthly Deduction: "))
```

If the user enters:

```text
2000
```

Python stores:

```python
monthly_deduction = 2000.0
```

---

# 3. Calculate Gross Monthly Salary

The requirement says:

```text
Gross Monthly Salary = Basic Monthly Salary + Monthly Bonus
```

Therefore:

```python
gross_monthly_salary = basic_salary + monthly_bonus
```

Using the sample values:

```text
basic_salary = 30000
monthly_bonus = 5000
```

Calculation:

```text
30000 + 5000
= 35000
```

So:

```python
gross_monthly_salary = 35000.0
```

---

# 4. Calculate Net Monthly Salary

The requirement says:

```text
Net Monthly Salary = Gross Monthly Salary - Monthly Deduction
```

Python:

```python
net_monthly_salary = gross_monthly_salary - monthly_deduction
```

Using the sample:

```text
Gross Monthly Salary = 35000
Monthly Deduction = 2000
```

Calculation:

```text
35000 - 2000
= 33000
```

Therefore:

```python
net_monthly_salary = 33000.0
```

---

# 5. Calculate Annual Gross Salary

The requirement says:

```text
Annual Gross Salary = Gross Monthly Salary × 12
```

Python:

```python
annual_gross_salary = gross_monthly_salary * 12
```

Calculation:

```text
35000 × 12
= 420000
```

Therefore:

```python
annual_gross_salary = 420000.0
```

---

# 6. Calculate Annual Net Salary

The requirement says:

```text
Annual Net Salary = Net Monthly Salary × 12
```

Python:

```python
annual_net_salary = net_monthly_salary * 12
```

Calculation:

```text
33000 × 12
= 396000
```

Therefore:

```python
annual_net_salary = 396000.0
```

---

# 7. Display the Results

We use `print()`:

```python
print("Employee Name:", employee_name)
```

For example:

```text
Employee Name: Rahul
```

The same approach is used for every value:

```python
print("Employee ID:", employee_id)
print("Basic Monthly Salary:", basic_salary)
print("Monthly Bonus:", monthly_bonus)
print("Monthly Deduction:", monthly_deduction)
print("Gross Monthly Salary:", gross_monthly_salary)
print("Net Monthly Salary:", net_monthly_salary)
print("Annual Gross Salary:", annual_gross_salary)
print("Annual Net Salary:", annual_net_salary)
```

---

# 8. Program Flow

Think of the program as four stages:

```text
             USER INPUT
                 |
                 v
    +--------------------------+
    | Employee Name            |
    | Employee ID              |
    | Basic Salary             |
    | Monthly Bonus            |
    | Monthly Deduction        |
    +--------------------------+
                 |
                 v
            CALCULATIONS
                 |
       +---------+---------+
       |                   |
       v                   v
   Gross Salary        Net Salary
   Basic + Bonus       Gross - Deduction
       |                   |
       v                   v
   Annual Gross        Annual Net
   Gross × 12          Net × 12
       |                   |
       +---------+---------+
                 |
                 v
             OUTPUT
                 |
                 v
       Employee Salary Summary
```

---

# 9. Dry Run

Suppose the user enters:

```text
Rahul
101
30000
5000
2000
```

Python variables will contain:

| Variable            |     Value | Data Type |
| ------------------- | --------: | --------- |
| `employee_name`     | `"Rahul"` | `str`     |
| `employee_id`       |     `101` | `int`     |
| `basic_salary`      | `30000.0` | `float`   |
| `monthly_bonus`     |  `5000.0` | `float`   |
| `monthly_deduction` |  `2000.0` | `float`   |

Then:

```text
gross_monthly_salary
= 30000 + 5000
= 35000
```

Then:

```text
net_monthly_salary
= 35000 - 2000
= 33000
```

Then:

```text
annual_gross_salary
= 35000 × 12
= 420000
```

Then:

```text
annual_net_salary
= 33000 × 12
= 396000
```

Final result:

```text
Employee Salary Summary

Employee Name: Rahul
Employee ID: 101
Basic Monthly Salary: 30000.0
Monthly Bonus: 5000.0
Monthly Deduction: 2000.0
Gross Monthly Salary: 35000.0
Net Monthly Salary: 33000.0
Annual Gross Salary: 420000.0
Annual Net Salary: 396000.0
```

# 10. Python Concepts Used

This single exercise covers several important Python basics:

```text
input()
   ↓
Type Conversion
   ↓
Variables
   ↓
Arithmetic Operators
   ↓
Calculated Variables
   ↓
print()
```

The three most important patterns to remember are:

### String input

```python
name = input("Enter name: ")
```

### Integer input

```python
age = int(input("Enter age: "))
```

### Decimal/numeric input

```python
salary = float(input("Enter salary: "))
```

And the basic arithmetic operators used here are:

```python
+     # Addition
-     # Subtraction
*     # Multiplication
```

**Key lesson:** Don't try to solve the entire program in one line. Break a business problem into **Input → Process → Output (IPO)**. This pattern will become extremely useful when you move from Python basics into Pandas and ETL programming.
