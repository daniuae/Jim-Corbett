# Python Labs

## ILS 1 — Virtual Machine: Introduction to Computation Using Python

### Lab Objective

This lab introduces the fundamentals of computation and guides learners through creating a simple Python program.

By the end of this lab, learners will be able to:

- Understand what computation is and why it is important.
- Use Python to accept user input.
- Perform a basic mathematical calculation.
- Display output to the user.

### Introduction: What is Computation?

Computation is the process of using step-by-step instructions (algorithms) to perform calculations and solve problems.

It is a foundational concept in programming and allows us to create efficient and effective solutions.

In this lab, you will apply computation principles to write a Python program that calculates the area of a rectangle.

### Case Description

You are required to write a Python program that:

1. Accepts the length and width of a rectangle from the user.
2. Calculates the area using the formula:

   `area = length * width`

3. Displays the result to the user.

### Steps of Computation

1. **Define Variables**
   - Create variables to store the length and width.
2. **Input**
   - Use the `input()` function to receive input from the user.
3. **Convert to Float**
   - Convert the input values to `float` to allow decimal values.
4. **Calculate Area**
   - Use the formula `area = length * width`.
5. **Output**
   - Display the result to the user.

### Lab Instructions

#### Step 1: Open Visual Studio Code

1. Launch Visual Studio Code.
2. Create a new folder named `pythonlabs`.
3. Open this folder in Visual Studio Code:
   - **File → Open Folder… → Select `pythonlabs`**

#### Step 2: Create a Python File

1. Inside the `pythonlabs` folder, create a new file.
2. Name the file `computation.py`.

#### Step 3: Add the Program Code

Enter the following code into `computation.py`:

```python
# Define Variables
length = 0.0
width = 0.0

# Input
length = float(input("Enter the length of the rectangle: "))
width = float(input("Enter the width of the rectangle: "))

# Calculate Area
area = length * width

# Output
print(f"The area of the rectangle is: {area}")
```

Save the file.

#### Step 4: Run the Program

**Option 1: Using the Run Button in VS Code**

Click the **Run** button in Visual Studio Code.

**Option 2: Using the Terminal**

1. Open the terminal in Visual Studio Code:
   - **View → Terminal**
2. Run the program using:

```bash
python computation.py
```

### Expected Output

When the program runs, it will prompt the user to enter the length and width.

Example:

```text
Enter the length of the rectangle: 5.5
Enter the width of the rectangle: 3.25
The area of the rectangle is: 17.875
```

### End of Lab

This concludes the lab.

You have written and executed a basic Python program using:

- Input
- Computation
- Output


---

# ILS 2 — Python Data Types, Typecasting, and Special Functions

## Objective

Explore Python data types, typecasting, and special functions including `len()`, `id()`, `type()`, and `range()`.

## Case Description

You are working on a data processing project where understanding different data types and their conversions is crucial.

Create a program that demonstrates:

- Various Python data types
- Typecasting between data types
- Special functions

## Important Facts to Note

Python supports various data types such as:

- Integers
- Floats
- Strings
- Lists

**Typecasting** is the process of converting one data type to another.

Special functions such as `len()`, `id()`, `type()`, and `range()` are useful for various data operations.

---

## Part 1: Data Type Exploration

### Step 1: Launch Visual Studio Code

Launch Visual Studio Code.

### Step 2: Create and Open the Project Folder

1. Create a folder named `pythonlabs`.
2. Open the directory by selecting:
   - **File → Open Folder…**
3. Select the `pythonlabs` folder.

### Step 3: Create the Python File

Create a file named `fundamentals.py` inside the `pythonlabs` folder.

Enter the following code:

```python
# Data Type Exploration
int_var = 10
float_var = 10.5
str_var = "Hello, World!"
list_var = [1, 2, 3, 4, 5]

print("Integer variable:", int_var, "Type:", type(int_var))
print("Float variable:", float_var, "Type:", type(float_var))
print("String variable:", str_var, "Type:", type(str_var))
print("List variable:", list_var, "Type:", type(list_var))
```

### Step 4: Save and Run

Save the file and execute it by either:

- Clicking the **Run** button, or
- Opening the VS Code terminal using **View → Terminal** and running:

```bash
python fundamentals.py
```

### Expected Output

```text
Integer variable: 10 Type: <class 'int'>
Float variable: 10.5 Type: <class 'float'>
String variable: Hello, World! Type: <class 'str'>
List variable: [1, 2, 3, 4, 5] Type: <class 'list'>
```

---

## Part 2: Typecasting

### Case Description

Convert variables between different data types and observe their new types.

### Step 1: Append the Following Code to `fundamentals.py`

```python
# Step 2: Typecasting
int_to_float = float(int_var)
float_to_int = int(float_var)
str_to_int = int("123")
list_to_str = str(list_var)

print("Integer to float:", int_to_float, "Type:", type(int_to_float))
print("Float to integer:", float_to_int, "Type:", type(float_to_int))
print("String to integer:", str_to_int, "Type:", type(str_to_int))
print("List to string:", list_to_str, "Type:", type(list_to_str))
```

### Step 2: Save and Run

Run using the same command:

```bash
python fundamentals.py
```

### Expected Output

```text
Integer to float: 10.0 Type: <class 'float'>
Float to integer: 10 Type: <class 'int'>
String to integer: 123 Type: <class 'int'>
List to string: [1, 2, 3, 4, 5] Type: <class 'str'>
```

---

## Part 3: Using Special Functions

### Case Description

Use:

- `len()` to print the length of the string and list.
- `id()` to print the memory identity of each variable.
- `type()` to print the data type of each variable.
- `range()` to create a sequence of numbers and convert it to a list.

> **Note:** The value returned by `id()` can be different each time the program runs and can differ across computers or Python implementations.

### Step 1: Append the Following Code to `fundamentals.py`

```python
# Step 3: Special Functions
print("Length of string:", len(str_var))
print("Length of list:", len(list_var))

print("Memory address of int_var:", id(int_var))
print("Memory address of float_var:", id(float_var))
print("Memory address of str_var:", id(str_var))
print("Memory address of list_var:", id(list_var))

print("Data type of int_var:", type(int_var))
print("Data type of float_var:", type(float_var))
print("Data type of str_var:", type(str_var))
print("Data type of list_var:", type(list_var))

range_list = list(range(10))
print("Range converted to list:", range_list, "Type:", type(range_list))
```

### Step 2: Save and Run

Save the file and execute it by either:

- Clicking the **Run** button, or
- Opening the VS Code terminal using **View → Terminal** and running:

```bash
python fundamentals.py
```

### Expected Output

The exact `id()` values may vary between executions and computers.

```text
Integer variable: 10 Type: <class 'int'>
Float variable: 10.5 Type: <class 'float'>
String variable: Hello, World! Type: <class 'str'>
List variable: [1, 2, 3, 4, 5] Type: <class 'list'>

Integer to float: 10.0 Type: <class 'float'>
Float to integer: 10 Type: <class 'int'>
String to integer: 123 Type: <class 'int'>
List to string: [1, 2, 3, 4, 5] Type: <class 'str'>

Length of string: 13
Length of list: 5
Memory address of int_var: <memory address>
Memory address of float_var: <memory address>
Memory address of str_var: <memory address>
Memory address of list_var: <memory address>
Data type of int_var: <class 'int'>
Data type of float_var: <class 'float'>
Data type of str_var: <class 'str'>
Data type of list_var: <class 'list'>
Range converted to list: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] Type: <class 'list'>
```

---

# ILS 3 — String Manipulation in Python

## Objective

This lab aims to help you understand basic string manipulation techniques and Python's built-in string functions.

You will learn how to:

- Reverse strings
- Capitalize words
- Format strings
- Replace substrings
- Perform basic string operations

---

## Part 1: Reverse a String

### Logic

1. Get the user input string.
2. Reverse the string using slicing.
3. Print the reversed string.

### Program

```python
# Get User Input
user_input = input("Enter a string: ")

# Reverse String
reversed_string = user_input[::-1]

# Output
print(f"The reversed string is: {reversed_string}")
```

### Example Output

```text
Enter a string: hello
The reversed string is: olleh
```

---

## Part 2: Capitalize the First Letter of Each Word

### Logic

1. Get the sentence from the user.
2. Use the `title()` method to capitalize the first letter of each word.
3. Print the sentence with each word capitalized.

### Program

```python
# Get User Input
sentence = input("Enter a sentence: ")

# Capitalize First Letter of Each Word
capitalized_sentence = sentence.title()

# Output
print(f"The capitalized sentence is: {capitalized_sentence}")
```

### Example Output

```text
Enter a sentence: hello world
The capitalized sentence is: Hello World
```

---

## Part 3: Count the Occurrences of a Substring

### Logic

1. Define a string and a substring.
2. Use the `count()` method to count the occurrences of the substring.
3. Print the result.

### Program

```python
# Define the String
text = "Hello, World! Hello, Python!"

# Count Substring Occurrences
count_hello = text.count("Hello")

# Output
print(f"Occurrences of 'Hello': {count_hello}")
```

### Example Output

```text
Occurrences of 'Hello': 2
```

---

## Part 4: Replace Substrings

### Logic

1. Define a string with a specific substring.
2. Use the `replace()` method to replace the substring with another string.
3. Print the modified string.

### Program

```python
# Define the String
text = "Hello, World! Hello, Python!"

# Replace Substring
modified_text = text.replace("Hello", "Hi")

# Output
print(f"Modified String: {modified_text}")
```

### Example Output

```text
Modified String: Hi, World! Hi, Python!
```

---

## Part 5: String Length

### Logic

1. Define a string.
2. Use the `len()` function to get the length of the string.
3. Print the length.

### Program

```python
# Define the String
text = "Hello, Python!"

# Get Length of the String
text_length = len(text)

# Output
print(f"The length of the string is: {text_length}")
```

### Example Output

```text
The length of the string is: 14
```

---

## Part 6: Convert to Uppercase and Lowercase

### Logic

1. Use the `upper()` method to convert the string to uppercase.
2. Use the `lower()` method to convert the string to lowercase.
3. Print both versions.

### Program

```python
# Define the String
text = "Hello, Python!"

# Convert to Uppercase and Lowercase
uppercase_text = text.upper()
lowercase_text = text.lower()

# Output
print(f"Uppercase: {uppercase_text}")
print(f"Lowercase: {lowercase_text}")
```

### Example Output

```text
Uppercase: HELLO, PYTHON!
Lowercase: hello, python!
```

---

## Part 7: Check If a String Starts or Ends With a Substring

### Logic

1. Use `startswith()` to check if a string starts with a specific substring.
2. Use `endswith()` to check if a string ends with a specific substring.
3. Print the results.

### Program

```python
# Define the String
text = "Hello, Python!"

# Check if Starts or Ends With Substring
starts_with_hello = text.startswith("Hello")
ends_with_python = text.endswith("Python!")

# Output
print(f"Starts with 'Hello': {starts_with_hello}")
print(f"Ends with 'Python!': {ends_with_python}")
```

### Example Output

```text
Starts with 'Hello': True
Ends with 'Python!': True
```

---

## End of Lab

In this lab, you have learned how to:

1. Reverse strings using slicing.
2. Capitalize the first letter of each word using the `title()` method.
3. Count substring occurrences using the `count()` method.
4. Replace substrings using the `replace()` method.
5. Calculate the length of a string using the `len()` function.
6. Convert strings to uppercase and lowercase.
7. Check if a string starts or ends with a specific substring.

These basic string manipulation techniques are foundational for text-processing tasks such as **data cleaning, transformation, and formatting in Python**.
