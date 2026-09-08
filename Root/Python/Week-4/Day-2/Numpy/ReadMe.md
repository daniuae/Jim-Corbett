# NumPy Problems — Consolidated Summary & Exam Insights

> **Purpose:** A practical revision guide based on the provided **NumPy Complete Tutorial** and **Student Workbook 1 – NumPy**. It consolidates the recurring problem patterns, functions, concepts, and assessment traps rather than repeating every example.

---

## 1. Big Picture

The NumPy material is built around one central idea:

```text
Raw data
   ↓
Create NumPy array
   ↓
Validate
   ↓
Filter / classify
   ↓
Calculate statistics
   ↓
Transform / format
   ↓
Return exact result
```

The tutorial emphasizes NumPy as a numerical engine based on `ndarray`, with element-wise operations, vectorization, broadcasting, statistics, array manipulation, and linear algebra.

The assessment workbook then applies those concepts to realistic analyzers such as:

- Health / steps
- Stock price changes
- Temperature
- Heart rate
- Fuel consumption
- Order data

The important insight is that **the business story changes, but the NumPy coding pattern remains almost the same**.

---

# 2. Core Problem-Solving Pattern

For almost every assessment question, ask these questions in order:

### Step 1 — What is the input?

Usually:

```python
list
```

or

```python
np.ndarray
```

### Step 2 — Does it need to become a NumPy array?

Typical pattern:

```python
arr = np.array(data)
```

If the question specifies a dtype:

```python
arr = np.array(data, dtype=np.float64)
```

### Step 3 — Does the input need validation?

Look for:

- Empty array
- Negative values
- Allowed range
- Numeric values
- Other explicitly stated constraints

Useful functions:

```python
arr.size
np.all(...)
np.any(...)
```

### Step 4 — Is the operation element-wise?

Think:

```python
arr + value
arr * value
arr / value
arr ** 2
```

rather than writing a loop.

### Step 5 — Is there a condition?

Think:

```python
arr >= threshold
```

or:

```python
np.where(...)
```

or:

```python
arr[arr >= threshold]
```

### Step 6 — Is there a statistic?

Think:

```python
np.sum()
np.mean()
np.min()
np.max()
np.std()
np.var()
```

### Step 7 — Is the question asking for a streak?

This is the major exception where a small loop/state-tracking algorithm may be appropriate if the assessment explicitly expects it.

### Step 8 — What exact type must be returned?

Possible outputs:

```text
np.ndarray
list
tuple
bool
int
float
string
```

This matters to the auto-checker.

---

# 3. The Most Important NumPy Concepts

## A. `ndarray`

The central NumPy object:

```python
arr = np.array([10, 20, 30])
```

Think of it as a numerical container optimized for array operations.

---

## B. Array properties

| Property | Meaning | Example |
|---|---|---|
| `ndim` | Number of dimensions | `arr.ndim` |
| `shape` | Size of each dimension | `arr.shape` |
| `size` | Total number of elements | `arr.size` |
| `dtype` | Data type | `arr.dtype` |
| `itemsize` | Bytes per element | `arr.itemsize` |

These are inspection tools, not calculations.

---

# 4. Array Creation Functions

| Function | Main use |
|---|---|
| `np.array()` | Create array from list/tuple |
| `np.zeros()` | Array of zeros |
| `np.ones()` | Array of ones |
| `np.full()` | Array filled with a value |
| `np.eye()` | Identity matrix |
| `np.arange()` | Values based on step |
| `np.linspace()` | Values based on count |
| `np.random.default_rng()` | Modern random-number generator |

### Key distinction

```python
np.arange(0, 10, 2)
```

means:

> Start, stop, **step**

Whereas:

```python
np.linspace(0, 10, 5)
```

means:

> Start, stop, **number of values**

---

# 5. Indexing and Slicing

## 1D indexing

```python
arr[0]
arr[-1]
```

## 2D indexing

```python
arr[row, column]
```

Example:

```python
arr[1, 2]
```

means:

> Row 1, column 2

## Slicing

```python
arr[start:stop:step]
```

Examples:

```python
arr[1:4]
arr[::-1]
arr[:2]
arr[:, :2]
```

### Exam insight

Most array-selection problems reduce to:

```text
Which elements do I want?
        ↓
Index / Slice / Boolean mask
```

---

# 6. Boolean Masking — VERY IMPORTANT

This is one of the most heavily reusable patterns.

```python
arr[arr > 25]
```

The condition creates a Boolean array and NumPy uses it to select values.

Example:

```python
marks[marks >= 50]
```

means:

> Select only marks that satisfy the condition.

### Multiple conditions

Use:

```python
&
```

for AND:

```python
arr[(arr > 20) & (arr < 50)]
```

Use:

```python
|
```

for OR:

```python
arr[(arr < 20) | (arr > 40)]
```

Use:

```python
~
```

for NOT:

```python
arr[~(arr > 20)]
```

### Important

Do **not** use Python's:

```python
and
or
```

directly with NumPy arrays.

---

# 7. `np.where()` — Classification Engine

Whenever a problem says:

> If condition → label A, otherwise → label B

think:

```python
np.where(condition, value_if_true, value_if_false)
```

Example:

```python
np.where(marks >= 50, "Pass", "Fail")
```

For multiple categories:

```python
np.where(
    arr > 5,
    "High",
    np.where(arr > 2, "Moderate", "Stable")
)
```

This pattern appears directly in the stock analyzer and is conceptually reused in the health and temperature problems.

---

# 8. Aggregation / Statistics

The core statistical functions are:

```python
np.sum(arr)
np.mean(arr)
np.min(arr)
np.max(arr)
np.std(arr)
np.var(arr)
np.median(arr)
np.percentile(arr, ...)
np.argmax(arr)
np.argmin(arr)
```

### Mental mapping

| Question wording | Likely function |
|---|---|
| Total | `np.sum()` |
| Average / Mean | `np.mean()` |
| Minimum | `np.min()` |
| Maximum | `np.max()` |
| Spread / volatility | `np.std()` |
| Variance | `np.var()` |
| Middle value | `np.median()` |
| Position of highest | `np.argmax()` |
| Position of lowest | `np.argmin()` |

---

# 9. `axis` — Critical Concept

For a 2D array:

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])
```

### `axis=0`

Produces one result per column:

```python
np.sum(arr, axis=0)
```

Result:

```text
[50 70 90]
```

### `axis=1`

Produces one result per row:

```python
np.sum(arr, axis=1)
```

Result:

```text
[60 150]
```

### Best mental model

> **The axis you specify is the dimension being reduced.**

For common 2D exam questions:

```text
axis=0 → column-wise result
axis=1 → row-wise result
```

---

# 10. Vectorization — The Heart of NumPy

Instead of:

```python
result = []

for x in numbers:
    result.append(x * 2)
```

prefer:

```python
result = numbers * 2
```

NumPy performs the operation over the entire array.

The workbook specifically advises using NumPy functions rather than loops unless the problem explicitly requires a loop.

### Think differently

```text
Python thinking:
one value → calculate → next value → calculate

NumPy thinking:
whole array → vectorized operation → result
```

This is one of the most important skills for the assessment.

---

# 11. Broadcasting

Broadcasting allows compatible arrays/scalars to participate in element-wise operations.

Example:

```python
arr + 10
```

adds `10` to every element.

Another example:

```python
arr = np.array([
    [10, 20, 30],
    [40, 50, 60]
])

bonus = np.array([1, 2, 3])

arr + bonus
```

Result:

```text
[[11 22 33]
 [41 52 63]]
```

### Assessment insight

If you see:

> "Add a bonus to every value"

think:

```python
arr + bonus
```

not a loop.

---

# 12. Reshaping and Transformation

Important tools:

```python
arr.reshape(...)
arr.flatten()
arr.ravel()
arr.T
```

### `reshape`

Changes dimensions without changing the number of elements.

```python
np.arange(12).reshape(3, 4)
```

### `-1`

Lets NumPy calculate one dimension:

```python
arr.reshape(3, -1)
```

### `flatten()`

Converts to 1D and generally creates a copy.

### `ravel()`

Converts to 1D and generally returns a view when possible.

### `.T`

Transpose:

```text
rows ↔ columns
```

---

# 13. Combining and Splitting Arrays

Know these:

```python
np.concatenate()
np.vstack()
np.hstack()
np.stack()
np.split()
np.vsplit()
np.hsplit()
```

Mental model:

```text
concatenate → join
vstack      → stack vertically
hstack      → stack horizontally
stack       → add a new dimension
split       → divide
```

---

# 14. Copy vs View

This is a conceptual question that can easily appear in tests.

### View

```python
b = a.view()
```

Shares underlying data.

Changing `b` can affect `a`.

### Copy

```python
b = a.copy()
```

Creates independent data.

Changing `b` does not change `a`.

### Memorize

```text
view() → shared data
copy() → independent data
```

---

# 15. Mathematical / Ufunc Operations

Important functions:

```python
np.sqrt()
np.abs()
np.exp()
np.log()
np.power()
np.sin()
np.cos()
np.round()
np.floor()
np.ceil()
```

These operate efficiently on arrays.

---

# 16. Searching and Identification

Know:

```python
np.where()
np.nonzero()
np.argmax()
np.argmin()
np.unique()
```

### Examples of question wording

| Problem wording | Tool |
|---|---|
| Find values satisfying condition | Boolean masking |
| Find indices satisfying condition | `np.where()` |
| Find highest-value position | `np.argmax()` |
| Find lowest-value position | `np.argmin()` |
| Find distinct values | `np.unique()` |
| Count unique occurrences | `np.unique(..., return_counts=True)` |

---

# 17. Rounding and Formatting

This is an **assessment-critical** area.

If the question says:

> Round to 2 decimals

use:

```python
np.round(value, 2)
```

Examples:

```python
np.round(np.sum(arr), 2)
np.round(np.mean(arr), 4)
```

If the output must be formatted:

```python
f"{value:.2f}"
```

Example:

```python
[f"{x:.2f} °C" for x in arr]
```

or:

```python
[f"{x:.2f} Litres" for x in arr]
```

### Important distinction

```python
np.round(86.4475, 2)
```

is numerical rounding.

```python
f"{86.4475:.2f}"
```

is string formatting.

---

# 18. Streak Problems

Several workbook problems ask for a **longest consecutive streak**.

Examples:

- Longest active step streak
- Longest stock-loss streak
- Longest normal-temperature streak
- Longest normal heart-rate streak

The common algorithm is:

```text
current_streak = 0
max_streak = 0

For each value:
    if condition is true:
        current_streak += 1
        max_streak = max(max_streak, current_streak)
    else:
        current_streak = 0

return max_streak
```

### Key insight

This is different from simple filtering.

```python
arr[arr >= threshold]
```

can find matching values, but it does **not** by itself tell you the longest consecutive run.

For streaks, you must preserve **sequence information**.

---

# 19. Problem Family 1 — Health Tracker

## Main objective

Process daily step counts.

### Operations

1. Create steps array
2. Validate steps
3. Add a new day
4. Categorize activity
5. Assign grade
6. Update a day
7. Find high-activity days
8. Format step values
9. Find longest active streak
10. Compute statistics

### Activity classification

```text
>= 8000       → Active
5000–7999     → Moderate
< 5000        → Sedentary
```

### Grade classification

```text
>= 9000       → A
7000–8999     → B
5000–6999     → C
< 5000        → D
```

### Statistics

```text
mean
min
max
standard deviation
```

rounded to 2 decimals.

### Skills tested

```text
np.array
validation
np.where
Boolean filtering
np.append / concatenation
indexing
string formatting
statistics
streak logic
return types
```

---

# 20. Problem Family 2 — Stock Price Analyzer

## Main objective

Analyze price changes.

### Operations

1. Create stock array
2. Compute volatility metrics
3. Flag volatile stocks
4. Find consecutive loss days

### Validation pattern

The supplied workbook example validates:

```text
array is not empty
values are between -100 and 100
```

### Risk classification

The supplied example uses:

```text
> 5 → High Risk
> 2 → Moderate Risk
else → Stable
```

### Metrics

The example computes:

```python
mean
standard deviation
maximum
```

with rounding.

### Key insight

Stock analysis combines:

```text
validation
+ statistics
+ nested np.where()
+ streak detection
```

This makes it a very good model problem for the entire assessment.

---

# 21. Problem Family 3 — Temperature Analyzer

## Main objective

Analyze temperature readings.

### Validation

The workbook specifies:

```text
30°C to 45°C
```

as the accepted input range.

### Metrics

```text
average
maximum
minimum
```

Example:

```text
(37.12, 39.1, 36.5)
```

### Classification

```text
< 35°C       → Hypothermia
35–37.5°C    → Normal
> 37.5°C     → Fever
```

### Streak

Find the longest consecutive sequence in the normal range:

```text
35°C–37.5°C
```

### Formatting

Output format:

```text
"36.57 °C"
"38.23 °C"
```

### Skills tested

```text
array creation
validation
mean/min/max
np.where
streak algorithm
formatting
```

---

# 22. Problem Family 4 — Heart Rate Analyzer

The workbook summary shows the same overall structure as the temperature analyzer.

### Data

```text
Heart Rate (BPM)
```

### Validation

```text
40–180 BPM
```

### Metrics

```text
average
maximum
minimum
```

### Abnormal classification

The workbook summary identifies:

```text
Brady / Tachy
```

### Streak

Find the longest `"Normal"` streak.

### Formatting

Output uses:

```text
" BPM"
```

### Important insight

The Heart Rate problem is structurally very similar to Temperature:

```text
Create
→ Validate
→ Metrics
→ Classify
→ Find normal streak
→ Format
```

Therefore, once the Temperature Analyzer is understood, the Heart Rate problem should be approached as the **same algorithmic template with different thresholds and labels**.

---

# 23. Problem Family 5 — Fuel Consumption Analyzer

## Main objective

Analyze fleet fuel consumption.

### Operations

1. Create fuel array
2. Validate fuel data
3. Compute fuel summary
4. Apply bulk discount
5. Flag heavy-consumption trips
6. Format fuel readings

### Validation

All entries must be:

```text
numeric
non-negative
```

### Summary

Calculate:

```text
total fuel
average fuel per trip
maximum fuel
```

### Bulk discount

For trips consuming:

```text
> 100 litres
```

apply:

```text
10% reduction
```

Example:

```text
80  → 80
120 → 108
150 → 135
```

### Heavy consumption

Compare each trip with the array average:

```text
> average → High
else      → Normal
```

### Formatting

```text
"80.00 Litres"
"120.46 Litres"
```

### Skills tested

```text
validation
np.sum
np.mean
np.max
np.where
vectorized arithmetic
string formatting
```

---

# 24. Problem Family 6 — Order Data Analyzer

The workbook summary shows an additional analyzer built around **Order Amount (USD)**.

The recurring operations include:

```text
create order array
apply discount
compute order summary
flag high-value orders
format order amounts
```

The important lesson is that the same NumPy building blocks are reused:

```text
array
→ validation
→ calculation
→ condition
→ formatting
```

The business domain changes, but the programming pattern does not.

---

# 25. NumPy + Python Lists

The workbook also includes tasks deliberately requiring ordinary Python list operations.

Examples include:

```python
convert_array_to_list()
total_steps_from_list()
min_max_steps_tuple()
filter_active_days()
format_steps_list_as_strings()
```

### Why this matters

Not every question should be solved with NumPy.

If the required return type is a:

```python
list
```

return a list.

If it is:

```python
tuple
```

return a tuple.

If it is:

```python
np.ndarray
```

return a NumPy array.

### Core rule

> Use NumPy where the problem asks for NumPy; use Python list operations where the problem explicitly asks for lists/list comprehensions.

---

# 26. Assessment Traps — VERY IMPORTANT

The workbook strongly emphasizes that many failures are not algorithm failures; they are **specification failures**.

## Trap 1 — Wrong function name

If required:

```python
create_stock_array
```

do not write:

```python
CreateStockArray
```

Python is case-sensitive.

---

## Trap 2 — Wrong return type

If expected:

```python
np.ndarray
```

do not return:

```python
list
```

If expected:

```python
tuple
```

do not return:

```python
list
```

If expected:

```python
bool
```

do not return:

```python
"True"
```

---

## Trap 3 — `print()` instead of `return`

Wrong:

```python
def compute_sum(arr):
    print(np.sum(arr))
```

Correct:

```python
def compute_sum(arr):
    return np.sum(arr)
```

Auto-graders check returned values.

### Memorize:

```text
PRINT ≠ RETURN
```

---

## Trap 4 — Hardcoding

Wrong:

```python
mean = 100
```

Correct:

```python
mean = np.mean(arr)
```

Your code must work with new test inputs.

---

## Trap 5 — Ignoring validation

If the question says:

```text
non-empty
non-negative
range-limited
```

implement those checks.

Do not assume the input is valid.

---

## Trap 6 — Incorrect rounding

If the question specifies 2 decimals:

```python
np.round(value, 2)
```

Do not leave floating-point output uncontrolled.

---

## Trap 7 — Wrong formatting

If expected:

```text
80.00 Litres
```

returning:

```text
80
```

is not equivalent for an auto-checker.

---

## Trap 8 — Unnecessary loops

If a condition can be expressed as:

```python
np.where(...)
```

or:

```python
arr[arr > threshold]
```

prefer the NumPy solution unless the problem explicitly asks for a loop/list comprehension.

---

## Trap 9 — Method vs property confusion

Properties:

```python
arr.shape
arr.size
arr.ndim
arr.dtype
```

Methods:

```python
arr.mean()
arr.sum()
arr.reshape(...)
```

Do not write:

```python
arr.mean
```

when you need the calculated mean.

---

# 27. High-Priority Function Cheat Sheet

## Must Know

```python
np.array()
np.zeros()
np.ones()
np.full()
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

## Selection

```python
arr[index]
arr[row, column]
arr[start:stop]
arr[condition]
```

## Conditions

```python
np.where()
np.any()
np.all()
```

## Statistics

```python
np.sum()
np.mean()
np.min()
np.max()
np.std()
np.var()
np.median()
np.percentile()
```

## Search

```python
np.argmax()
np.argmin()
np.nonzero()
np.unique()
```

## Transformation

```python
reshape()
flatten()
ravel()
arr.T
```

## Combining

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

## Math

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
A @ B
np.matmul()
np.dot()
np.linalg.det()
np.linalg.inv()
np.linalg.eig()
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

# 28. The Five Concepts to Master First

The tutorial identifies five concepts as more important than memorizing dozens of functions:

1. **Indexing**
2. **Slicing**
3. **Boolean masking**
4. **Axis**
5. **Broadcasting**

If these five are strong, many assessment questions become straightforward.

---

# 29. How the Problems Map to NumPy Skills

| Problem | Main Skills |
|---|---|
| Health Tracker | Validation, `where`, filtering, statistics, streaks, formatting |
| Stock Analyzer | Validation, statistics, nested `where`, streaks |
| Temperature Analyzer | Validation, statistics, classification, streaks, formatting |
| Heart Rate Analyzer | Validation, statistics, abnormal classification, streaks, formatting |
| Fuel Analyzer | Validation, aggregation, broadcasting/vectorization, `where`, formatting |
| Order Analyzer | Array creation, discount calculation, summary, classification, formatting |
| Student/Matrix examples | 2D arrays, `axis`, `argmax`, Boolean masking, broadcasting |
| List conversion tasks | NumPy ↔ Python list, `sum`, `min/max`, list comprehension |

---

# 30. What the Examiner Is Really Testing

Although the questions look like different real-world applications, the underlying skills are highly repetitive.

### Pattern 1 — Convert

```python
list → np.array
```

### Pattern 2 — Validate

```python
size / any / all / comparisons
```

### Pattern 3 — Calculate

```python
sum / mean / min / max / std
```

### Pattern 4 — Classify

```python
np.where()
```

### Pattern 5 — Filter

```python
arr[condition]
```

### Pattern 6 — Transform

```python
reshape / append / arithmetic
```

### Pattern 7 — Find a streak

```text
current → maximum
```

### Pattern 8 — Format

```python
f"{x:.2f} ..."
```

### Pattern 9 — Return exact type

```text
array / list / tuple / bool / int / float
```

---

# 31. A Reusable Analyzer Template

Most analyzer classes can mentally be structured like this:

```python
import numpy as np

class Analyzer:

    def create_array(self, data):
        return np.array(data)

    def validate(self, arr):
        # apply the exact validation rules
        pass

    def compute_metrics(self, arr):
        # sum / mean / min / max / std
        pass

    def classify(self, arr):
        # np.where()
        pass

    def filter_data(self, arr, threshold):
        return arr[arr >= threshold]

    def find_streak(self, arr, threshold):
        current = 0
        maximum = 0

        for value in arr:
            if value >= threshold:
                current += 1
                maximum = max(maximum, current)
            else:
                current = 0

        return maximum

    def format_data(self, arr):
        # exact format required by question
        pass
```

Do **not** copy this blindly into every problem. Treat it as a mental framework and follow the exact problem specification.

---

# 32. Exam Decision Tree

When you read a question:

```text
What does it ask?
       |
       +-- Create array?
       |      → np.array()
       |
       +-- Validate?
       |      → size / any / all / conditions
       |
       +-- Select values?
       |      → Boolean masking
       |
       +-- Assign labels?
       |      → np.where()
       |
       +-- Total?
       |      → np.sum()
       |
       +-- Average?
       |      → np.mean()
       |
       +-- Highest/lowest?
       |      → np.max()/np.min()
       |
       +-- Position?
       |      → np.argmax()/np.argmin()
       |
       +-- Row/column?
       |      → axis
       |
       +-- Reshape?
       |      → reshape()
       |
       +-- Consecutive?
       |      → streak algorithm
       |
       +-- Format?
       |      → f-string
       |
       +-- Exact output type?
              → return exactly that type
```

---

# 33. Highest-Value Insights

## Insight 1 — Learn patterns, not individual problems

You do not need six separate mental programs.

Learn one generic pattern:

```text
Create → Validate → Analyze → Classify → Filter → Format → Return
```

Then adapt thresholds and labels.

---

## Insight 2 — Thresholds are data, not algorithms

For example:

```text
8000 → Active
9000 → A
```

and:

```text
35 → Hypothermia boundary
37.5 → Fever boundary
```

The algorithm is the same. Only the thresholds change.

---

## Insight 3 — `np.where()` is your classification tool

If the question uses language such as:

> if this, then this; otherwise that

immediately consider:

```python
np.where()
```

---

## Insight 4 — Filtering and streaks are different

Filtering:

```python
arr[arr >= threshold]
```

answers:

> Which values qualify?

A streak algorithm answers:

> How long did the qualifying condition continue consecutively?

---

## Insight 5 — The return type is part of the answer

Correct calculation + wrong return type = failed test.

Treat the function signature as part of the question.

---

## Insight 6 — Formatting is logic

These are not equivalent to an auto-checker:

```text
80
80.0
80.00
80.00 Litres
```

Return exactly what is requested.

---

## Insight 7 — Most assessment failures are specification failures

The workbook highlights:

```text
wrong function name
wrong variable/parameter name
wrong return type
missing validation
missing rounding
wrong formatting
print instead of return
hardcoded result
unnecessary randomization
```

Therefore, spend the final minute checking the specification, not just the algorithm.

---

# 34. 10-Minute Revision Before the Test

Memorize these:

```python
import numpy as np

arr = np.array(data)

arr.shape
arr.ndim
arr.size
arr.dtype

arr[index]
arr[start:stop]

arr[arr > x]

np.where(condition, "A", "B")

np.sum(arr)
np.mean(arr)
np.min(arr)
np.max(arr)
np.std(arr)

np.argmax(arr)
np.argmin(arr)
np.unique(arr)

arr.reshape(rows, cols)
arr.T

np.concatenate(...)
np.vstack(...)
np.hstack(...)

arr + value
arr * value

np.round(value, 2)

f"{value:.2f}"
```

And remember:

```text
axis=0 → column-wise result
axis=1 → row-wise result

view() → shares data
copy() → independent data

PRINT ≠ RETURN
```

---

# 35. Final Mental Model

The entire NumPy assessment can be compressed into:

```text
                NUMPY
                  |
        +---------+---------+
        |                   |
      ARRAY              LOGIC
        |                   |
   create/inspect       condition
        |                   |
 index/slice            where/mask
        |                   |
   reshape/combine      classify/filter
        |                   |
        +---------+---------+
                  |
             CALCULATE
                  |
        sum / mean / min
        max / std / var
                  |
             SPECIAL CASES
                  |
       streak / formatting
                  |
              RETURN
                  |
     exact expected data type
```

## The ultimate exam formula

```text
READ THE QUESTION
      ↓
IDENTIFY INPUT TYPE
      ↓
CREATE / RECEIVE ARRAY
      ↓
VALIDATE IF REQUIRED
      ↓
USE VECTORIZED NUMPY OPERATION
      ↓
FILTER / CLASSIFY
      ↓
CALCULATE
      ↓
ROUND / FORMAT
      ↓
RETURN EXACT TYPE
```

---

# 36. Priority Ranking for Study

If time is limited, study in this order:

### 🔴 Priority 1 — Must master

```text
np.array()
shape / ndim / size
indexing
slicing
Boolean masking
np.where()
np.sum()
np.mean()
np.min()
np.max()
np.std()
```

### 🟠 Priority 2 — Very important

```text
axis
np.argmax()
np.argmin()
reshape()
broadcasting
vectorization
np.round()
string formatting
```

### 🟡 Priority 3 — Assessment support

```text
concatenate
vstack
hstack
flatten
ravel
unique
copy vs view
```

### 🟢 Priority 4 — Advanced/tutorial topics

```text
ufuncs
random generators
NaN handling
linear algebra
meshgrid
datetime64
structured arrays
saving/loading arrays
```

---

# 37. Final Takeaway

The provided problems are **not six unrelated NumPy programs**.

They are variations of approximately the same engineering workflow:

```text
                    DATA
                     ↓
                NumPy Array
                     ↓
                 VALIDATE
                     ↓
             ┌───────┴───────┐
             ↓               ↓
         CALCULATE        CLASSIFY
             ↓               ↓
       mean/min/max       np.where
             ↓               ↓
             └───────┬───────┘
                     ↓
                  FILTER
                     ↓
              STREAK / SEARCH
                     ↓
               ROUND / FORMAT
                     ↓
              EXACT RETURN TYPE
```

If you master **Boolean masking + `np.where()` + aggregation + axis + vectorization + exact return types**, you will have the core toolkit needed for most of the supplied assessment problems.

The tutorial itself frames the learning progression from array creation and inspection through indexing/filtering, aggregation, reshaping, vectorization/broadcasting, and then advanced topics. The workbook reinforces that the assessment rewards exact adherence to function names, return types, validation, NumPy operations, rounding, formatting, and `return` rather than `print`.
