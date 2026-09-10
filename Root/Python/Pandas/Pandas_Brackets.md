# Pandas Brackets Made Easy
## Understanding `[]`, `[[]]`, `()`, and `[[ ]]` without confusion

Pandas syntax can feel confusing because very small changes in brackets can completely change the result.

The key idea is:

> **Square brackets `[]` are mainly used for selecting/accessing data.**
>
> **Double square brackets `[[]]` usually mean "give me a list of columns/labels", so Pandas returns a DataFrame.**
>
> **Parentheses `()` are mainly used for calling functions/methods or grouping expressions.**

This guide explains the patterns step by step.

---

# 1. First understand the two main Pandas objects

Before learning brackets, understand these two:

- **Series** → one-dimensional
- **DataFrame** → two-dimensional table

Example:

```python
import pandas as pd

df = pd.DataFrame({
    "Name": ["Asha", "Ravi", "John"],
    "Age": [22, 25, 30],
    "City": ["Pune", "Mumbai", "Delhi"]
})

print(df)
```

Output:

```text
   Name  Age    City
0  Asha   22    Pune
1  Ravi   25  Mumbai
2  John   30  Delhi
```

Think of it like this:

```text
DataFrame
┌─────┬──────┬─────┬────────┐
│index│ Name │ Age │  City  │
├─────┼──────┼─────┼────────┤
│  0  │ Asha │ 22  │ Pune   │
│  1  │ Ravi │ 25  │ Mumbai │
│  2  │ John │ 30  │ Delhi  │
└─────┴──────┴─────┴────────┘
```

A DataFrame can contain many Series.

```text
df
│
├── df["Name"]  → Series
├── df["Age"]   → Series
└── df["City"]  → Series
```

---

# 2. What does `()` mean?

Parentheses are primarily used for **calling a function or method**.

For example:

```python
df.head()
```

Here:

```text
head     → method
()       → call the method
```

Similarly:

```python
df.info()
df.describe()
df.sum()
df.mean()
df.drop(...)
df.sort_values(...)
```

The parentheses tell Python:

> "Execute this function/method."

## Example

```python
df.head(2)
```

`2` is an argument passed to `head()`.

Output:

```text
   Name  Age    City
0  Asha   22    Pune
1  Ravi   25  Mumbai
```

### Easy rule

```text
method()       → execute/call something
method(value)  → execute it with an argument
```

---

# 3. What does `[]` mean in Pandas?

Square brackets are mainly used for **selection**.

The most common example:

```python
df["Age"]
```

This means:

> Select the column named `Age`.

Output:

```text
0    22
1    25
2    30
Name: Age, dtype: int64
```

Notice that the result is a **Series**, not a DataFrame.

---

# 4. Why does `df["Age"]` return a Series?

Because you selected **one column**.

Think:

```text
df
 ↓
"Age"
 ↓
one column
 ↓
Series
```

So:

```python
df["Age"]
```

returns:

```text
Series
```

---

# 5. Selecting multiple columns: `df[["Age", "City"]]`

Now suppose you want two columns:

```python
df[["Age", "City"]]
```

This looks strange because there are two sets of square brackets.

Let's break it apart:

```python
df[ ["Age", "City"] ]
     └────────────┘
        Python list
```

The **outer** `[]` means:

> Select from the DataFrame.

The **inner** `[]` creates a Python list containing the column names.

So:

```python
["Age", "City"]
```

is simply a list.

Pandas receives that list and says:

> "Select all these columns."

Result:

```text
   Age    City
0   22    Pune
1   25  Mumbai
2   30   Delhi
```

And importantly:

```text
df["Age"]             → Series
df[["Age", "City"]]   → DataFrame
```

---

# 6. The most important difference

Memorize this:

```python
df["Age"]
```

means:

> Give me **one column**.

Whereas:

```python
df[["Age"]]
```

means:

> Give me a **DataFrame containing one column**.

They look almost identical but produce different types.

## Example

```python
a = df["Age"]
b = df[["Age"]]

print(type(a))
print(type(b))
```

Output:

```text
<class 'pandas.core.series.Series'>
<class 'pandas.core.frame.DataFrame'>
```

This distinction is extremely important.

---

# 7. Visual explanation

Imagine:

```text
df["Age"]

       Age
0       22
1       25
2       30

       ↓
    Series
```

But:

```text
df[["Age"]]

       Age
0       22
1       25
2       30

       ↓
   DataFrame
```

The data looks almost the same.

The **type** is different.

---

# 8. Why does Pandas use `[[ ]]`?

Because the inside brackets create a **list**.

For example:

```python
["Name", "Age", "City"]
```

is a normal Python list.

Therefore:

```python
df[["Name", "Age", "City"]]
```

means:

```text
df[
    list of column names
]
```

This is why double square brackets are used for selecting multiple columns.

---

# 9. General pattern

Remember this structure:

```python
df[selection]
```

The outer brackets mean:

> "Select something from `df`."

The thing inside can be different types of selections.

### One column

```python
df["Age"]
```

### Multiple columns

```python
df[["Name", "Age"]]
```

### Boolean condition

```python
df[df["Age"] > 23]
```

### Slice

```python
df[0:2]
```

---

# 10. Boolean filtering — where brackets become confusing

Consider:

```python
df[df["Age"] > 23]
```

This looks complicated.

Break it from the inside out.

First:

```python
df["Age"]
```

gives:

```text
0    22
1    25
2    30
```

Then:

```python
df["Age"] > 23
```

gives:

```text
0    False
1     True
2     True
```

This is called a **Boolean Series**.

Then:

```python
df[Boolean Series]
```

means:

> Keep the rows where the condition is `True`.

So:

```python
df[df["Age"] > 23]
```

produces:

```text
   Name  Age    City
1  Ravi   25  Mumbai
2  John   30  Delhi
```

---

# 11. Why are there two `[]` in filtering?

Look carefully:

```python
df[df["Age"] > 23]
```

There are actually two selections.

### Inner selection

```python
df["Age"]
```

Select the Age column.

### Outer selection

```python
df[ ... ]
```

Select rows based on the Boolean condition.

So:

```text
df[
    df["Age"] > 23
]
↑
outer selection
```

and:

```text
df["Age"]
↑
inner selection
```

---

# 12. Multiple conditions

Suppose you want:

> Age greater than 23 AND City is Mumbai.

Use:

```python
df[(df["Age"] > 23) & (df["City"] == "Mumbai")]
```

Notice the parentheses.

Why?

Because each condition should be evaluated separately:

```python
(df["Age"] > 23)
```

and:

```python
(df["City"] == "Mumbai")
```

Then:

```python
&
```

means AND.

---

# 13. `&` and `|` in Pandas

For Pandas Boolean conditions, use:

```text
&  → AND
|  → OR
~  → NOT
```

Examples:

```python
df[(df["Age"] > 20) & (df["Age"] < 30)]
```

Age between 20 and 30.

```python
df[(df["City"] == "Pune") | (df["City"] == "Delhi")]
```

City is Pune OR Delhi.

```python
df[~(df["City"] == "Mumbai")]
```

City is NOT Mumbai.

### Important

Do not normally write:

```python
df[df["Age"] > 20 and df["Age"] < 30]
```

Use:

```python
df[(df["Age"] > 20) & (df["Age"] < 30)]
```

---

# 14. Parentheses inside square brackets

This is a very common pattern:

```python
df[(condition1) & (condition2)]
```

Think:

```text
[]  → select rows
()  → group each condition
&   → combine conditions
```

For example:

```python
df[(df["Age"] >= 25) & (df["Age"] <= 30)]
```

Read it in English:

> Select from `df` the rows where Age is greater than or equal to 25 AND Age is less than or equal to 30.

---

# 15. `df.loc[]`

Now you will encounter:

```python
df.loc[rows, columns]
```

This is another major use of square brackets.

Example:

```python
df.loc[0, "Name"]
```

Meaning:

> Select row label `0` and column `"Name"`.

Result:

```text
Asha
```

---

# 16. `loc` with multiple rows and columns

```python
df.loc[[0, 2], ["Name", "Age"]]
```

This has several brackets.

Break it down:

```text
df.loc[
    [0, 2],
    ["Name", "Age"]
]
```

The first list:

```python
[0, 2]
```

means:

> Select rows 0 and 2.

The second list:

```python
["Name", "Age"]
```

means:

> Select columns Name and Age.

Result:

```text
   Name  Age
0  Asha   22
2  John   30
```

---

# 17. Why `loc[[0, 2], ["Name", "Age"]]` has `[[ ]]`

Because:

```python
[0, 2]
```

is a list of row labels.

And:

```python
["Name", "Age"]
```

is a list of column labels.

The outer brackets belong to `.loc[]`.

So:

```python
df.loc[
    [0, 2],
    ["Name", "Age"]
]
```

means:

```text
             rows        columns
              ↓             ↓
df.loc[    [0, 2],    ["Name", "Age"] ]
             ↑             ↑
           list          list
```

---

# 18. `iloc[]`

`iloc` works with **integer positions**.

```python
df.iloc[0, 1]
```

means:

> First row, second column.

Remember:

```text
iloc → integer location / position
loc  → label-based location
```

Example:

```python
df.iloc[0, 1]
```

Result:

```text
22
```

Because:

```text
       Name   Age    City
row 0  Asha   22     Pune
         ↑     ↑
       col 0  col 1
```

---

# 19. `iloc` with lists

```python
df.iloc[[0, 2], [0, 1]]
```

Means:

> Rows at positions 0 and 2, columns at positions 0 and 1.

Result:

```text
   Name  Age
0  Asha   22
2  John   30
```

Again:

```text
df.iloc[
    [0, 2],     ← list of row positions
    [0, 1]      ← list of column positions
]
```

---

# 20. Slicing uses `:`

Another important bracket pattern:

```python
df[0:2]
```

This selects rows from position 0 up to, but not including, 2.

Result:

```text
   Name  Age    City
0  Asha   22    Pune
1  Ravi   25  Mumbai
```

You can also use:

```python
df.iloc[0:2, 0:2]
```

Meaning:

```text
rows    → 0:2
columns → 0:2
```

---

# 21. `:` inside brackets

The colon means a **range/slice**.

Examples:

```python
df.iloc[:3]
```

First three rows.

```python
df.iloc[2:]
```

From row position 2 onward.

```python
df.iloc[:, 1]
```

All rows, column position 1.

```python
df.iloc[:, :2]
```

All rows, first two columns.

Notice:

```python
:
```

by itself means "everything in that dimension".

---

# 22. A very important pattern: `df["Age"].mean()`

You will frequently see code like:

```python
df["Age"].mean()
```

Read it from left to right:

```text
df
 ↓
["Age"]
 ↓
select Age column
 ↓
.mean()
 ↓
calculate average
```

So:

```python
df["Age"].mean()
```

means:

> Select the Age Series and calculate its mean.

---

# 23. Another common pattern: `df["Age"].max()`

```python
df["Age"].max()
```

Means:

> Select the Age column and find the maximum value.

Similarly:

```python
df["Age"].min()
df["Age"].sum()
df["Age"].mean()
df["Age"].median()
df["Age"].std()
```

---

# 24. `df["Age"].unique()`

```python
df["Age"].unique()
```

First:

```python
df["Age"]
```

selects the column.

Then:

```python
.unique()
```

calls the method.

The pattern is:

```text
object
  ↓
selection []
  ↓
method ()
```

---

# 25. `df["City"].value_counts()`

```python
df["City"].value_counts()
```

Read:

> Select City, then count how many times each value occurs.

Again:

```text
df["City"]       → selection
.value_counts()  → method call
```

---

# 26. `df.groupby()["..."]` — another common source of confusion

Suppose:

```python
df.groupby("City")["Age"].mean()
```

Break it down:

```text
df
 ↓
.groupby("City")
 ↓
group the DataFrame by City
 ↓
["Age"]
 ↓
select Age from each group
 ↓
.mean()
 ↓
calculate average
```

The parentheses are used to **call `groupby()`**.

The square brackets select the column.

So:

```python
.groupby("City")
```

and:

```python
["Age"]
```

have completely different jobs.

---

# 27. Example with groupby

```python
df = pd.DataFrame({
    "City": ["Pune", "Pune", "Mumbai", "Mumbai"],
    "Age": [20, 30, 25, 35]
})
```

Then:

```python
df.groupby("City")["Age"].mean()
```

Output:

```text
City
Mumbai    30.0
Pune      25.0
Name: Age, dtype: float64
```

Think:

```text
groupby("City")  → how to group
["Age"]          → what column to analyze
.mean()          → what calculation
```

---

# 28. `agg()` introduces another bracket pattern

Example:

```python
df.groupby("City")["Age"].agg(["mean", "max", "min"])
```

Here:

```python
["mean", "max", "min"]
```

is a Python list of functions/operations.

The parentheses:

```python
.agg(...)
```

call the aggregation method.

The list:

```python
["mean", "max", "min"]
```

tells Pandas which aggregations to perform.

---

# 29. Dictionary inside `agg()`

You may also see:

```python
df.groupby("City").agg({
    "Age": "mean"
})
```

Here:

```python
{}
```

is a Python dictionary.

This is different from `[]`.

A useful mental model:

```text
() → function/method arguments
[] → lists / selection
{} → dictionaries / mappings
```

---

# 30. Creating a new column

This is one of the most important uses of `[]`:

```python
df["Salary"] = [30000, 40000, 50000]
```

Read:

> Create/select the column called Salary and assign these values.

The left side:

```python
df["Salary"]
```

refers to a column.

The `=` assigns values.

---

# 31. Creating a calculated column

```python
df["Annual Salary"] = df["Monthly Salary"] * 12
```

The right side:

```python
df["Monthly Salary"]
```

selects a Series.

Then:

```python
* 12
```

performs vectorized multiplication.

Then the result is assigned to:

```python
df["Annual Salary"]
```

---

# 32. Renaming columns

You may see:

```python
df.rename(columns={"Age": "Years"})
```

Notice the braces:

```python
{"Age": "Years"}
```

That's a dictionary.

The parentheses:

```python
rename(...)
```

call the method.

So:

```python
df.rename(
    columns={"Age": "Years"}
)
```

means:

```text
rename()          → call method
columns=          → argument
{}                → dictionary
"Age": "Years"    → mapping
```

---

# 33. The four bracket types you should recognize

| Syntax | Usually means | Example |
|---|---|---|
| `()` | Call method/function or group expression | `df.mean()` |
| `[]` | Selection or list | `df["Age"]` |
| `[[]]` | List inside selection; often multiple columns | `df[["Age", "City"]]` |
| `{}` | Dictionary/set | `{"Age": "Years"}` |

There is an important caveat:

`[]` itself is also a Python list literal when it appears independently:

```python
["Age", "City"]
```

So the meaning depends on **where it appears**.

---

# 34. The easiest way to decode complicated Pandas code

Use the **inside-out method**.

Suppose you see:

```python
df[(df["Age"] > 25) & (df["City"] == "Mumbai")]["Name"]
```

Don't try to understand the whole line at once.

### Step 1

```python
df["Age"]
```

Select Age.

### Step 2

```python
df["Age"] > 25
```

Create a Boolean condition.

### Step 3

```python
df["City"] == "Mumbai"
```

Create another Boolean condition.

### Step 4

```python
(df["Age"] > 25) & (df["City"] == "Mumbai")
```

Combine the conditions.

### Step 5

```python
df[condition]
```

Filter the rows.

### Step 6

```python
df[condition]["Name"]
```

Select Name from the filtered result.

This is much easier than trying to mentally process everything at once.

---

# 35. A bracket-reading framework

Whenever you see Pandas code, ask these questions:

## Question 1 — Do I see `()`?

Example:

```python
df.head()
```

Ask:

> What method/function am I calling?

---

## Question 2 — Do I see `["Column"]`?

Example:

```python
df["Age"]
```

Ask:

> Am I selecting one column?

Usually yes.

---

## Question 3 — Do I see `[["A", "B"]]`?

Example:

```python
df[["Name", "Age"]]
```

Ask:

> Am I passing a list of columns?

Usually yes.

---

## Question 4 — Do I see `df[condition]`?

Example:

```python
df[df["Age"] > 25]
```

Ask:

> Am I filtering rows?

Yes.

---

## Question 5 — Do I see `.loc[...]`?

Example:

```python
df.loc[rows, columns]
```

Ask:

> Am I selecting by labels?

Usually yes.

---

## Question 6 — Do I see `.iloc[...]`?

Example:

```python
df.iloc[rows, columns]
```

Ask:

> Am I selecting by integer position?

Yes.

---

# 36. One-column vs multiple-column selection

This table is worth memorizing:

| Code | Meaning | Result |
|---|---|---|
| `df["Age"]` | One column | Series |
| `df[["Age"]]` | One column as list | DataFrame |
| `df[["Age", "City"]]` | Multiple columns | DataFrame |
| `df.loc[:, "Age"]` | One column by label | Series |
| `df.loc[:, ["Age"]]` | One column as list | DataFrame |
| `df.loc[:, ["Age", "City"]]` | Multiple columns | DataFrame |

The key distinction is:

```python
"Age"
```

versus:

```python
["Age"]
```

The first is a string.

The second is a list containing a string.

---

# 37. Why this matters in real problems

Suppose you write:

```python
result = df["Age"]
```

You now have a Series.

If you later need DataFrame operations that expect two dimensions, you may need:

```python
result = df[["Age"]]
```

This is why trainees sometimes get unexpected errors even though the data looks correct.

---

# 38. `loc` — memorize this pattern

Think:

```python
df.loc[ROW_SELECTION, COLUMN_SELECTION]
```

Examples:

### One cell

```python
df.loc[0, "Age"]
```

### Multiple rows

```python
df.loc[[0, 2], "Age"]
```

### Multiple columns

```python
df.loc[0, ["Name", "Age"]]
```

### Multiple rows + multiple columns

```python
df.loc[[0, 2], ["Name", "Age"]]
```

### Condition + selected columns

```python
df.loc[df["Age"] > 23, ["Name", "Age"]]
```

This last pattern is extremely useful.

---

# 39. `iloc` — same structure, positions instead of labels

Think:

```python
df.iloc[ROW_POSITION, COLUMN_POSITION]
```

Examples:

```python
df.iloc[0, 1]
```

One cell.

```python
df.iloc[[0, 2], 1]
```

Rows 0 and 2, column 1.

```python
df.iloc[:, [0, 2]]
```

All rows, columns 0 and 2.

```python
df.iloc[0:2, 0:2]
```

First two rows and first two columns.

---

# 40. A very useful comparison

Suppose the DataFrame is:

```text
   Name  Age    City
0  Asha   22    Pune
1  Ravi   25  Mumbai
2  John   30   Delhi
```

### Select Age

```python
df["Age"]
```

### Select Age as DataFrame

```python
df[["Age"]]
```

### Select Name and Age

```python
df[["Name", "Age"]]
```

### Select Ravi's Age

```python
df.loc[1, "Age"]
```

### Select Asha's Age using position

```python
df.iloc[0, 1]
```

### Select people older than 23

```python
df[df["Age"] > 23]
```

### Select names of people older than 23

```python
df.loc[df["Age"] > 23, "Name"]
```

### Select names and cities of people older than 23

```python
df.loc[df["Age"] > 23, ["Name", "City"]]
```

---

# 41. Common mistakes

## Mistake 1

```python
df["Name", "Age"]
```

Usually wrong.

Why?

Because:

```python
"Name", "Age"
```

creates a tuple-like selection, not the list Pandas expects for ordinary multiple-column selection.

Use:

```python
df[["Name", "Age"]]
```

---

## Mistake 2

```python
df[df["Age"] > 20 and df["Age"] < 30]
```

Wrong for normal Pandas Series conditions.

Use:

```python
df[(df["Age"] > 20) & (df["Age"] < 30)]
```

---

## Mistake 3

Forgetting the second brackets:

```python
df["Name", "Age"]
```

instead of:

```python
df[["Name", "Age"]]
```

Remember:

```text
One column:
df["Name"]

Multiple columns:
df[["Name", "Age"]]
```

---

# 42. A simple mental model

Think of Pandas as asking:

> **What am I selecting?**

### One thing

```python
df["Age"]
```

### A list of things

```python
df[["Age", "City"]]
```

### Rows satisfying a condition

```python
df[df["Age"] > 25]
```

### Specific row/column coordinates

```python
df.loc[rows, columns]
```

or:

```python
df.iloc[row_positions, column_positions]
```

---

# 43. The "bracket dictionary"

When you see this:

```python
df["Age"]
```

translate it mentally to:

> **Select Age.**

When you see:

```python
df[["Age", "City"]]
```

translate it to:

> **Select these columns.**

When you see:

```python
df[df["Age"] > 25]
```

translate it to:

> **Filter rows where Age > 25.**

When you see:

```python
df.loc[condition, ["Name", "Age"]]
```

translate it to:

> **Filter rows using condition, then return these columns.**

When you see:

```python
df.groupby("City")["Age"].mean()
```

translate it to:

> **Group by City → select Age → calculate mean.**

This translation habit is one of the fastest ways to become comfortable with Pandas.

---

# 44. A complete example

Let's work through a realistic problem.

```python
df = pd.DataFrame({
    "Name": ["Asha", "Ravi", "John", "Meena"],
    "Department": ["IT", "HR", "IT", "HR"],
    "Salary": [50000, 45000, 70000, 55000]
})
```

Problem:

> Find the names and salaries of IT employees earning more than 50,000.

Start with the condition:

```python
df["Department"] == "IT"
```

Then:

```python
df["Salary"] > 50000
```

Combine:

```python
(df["Department"] == "IT") & (df["Salary"] > 50000)
```

Filter and select columns:

```python
df.loc[
    (df["Department"] == "IT") & (df["Salary"] > 50000),
    ["Name", "Salary"]
]
```

Result:

```text
   Name  Salary
2  John   70000
```

Notice how many different concepts came together:

```text
()     → group conditions
[]     → select columns
&      → combine conditions
.loc[] → select rows and columns
[[]]   → select multiple columns
```

---

# 45. Problem-solving framework for trainees

When given a Pandas problem, use this sequence.

## Step 1 — What is the final output?

Do you need:

- one value?
- one column?
- multiple columns?
- filtered rows?
- grouped result?
- sorted result?

---

## Step 2 — Identify the rows

Ask:

> Which rows should remain?

If a condition is involved:

```python
df[df["Column"] > value]
```

or:

```python
df.loc[df["Column"] > value, ...]
```

---

## Step 3 — Identify the columns

One column:

```python
df["Column"]
```

Multiple columns:

```python
df[["Column1", "Column2"]]
```

---

## Step 4 — Decide whether you need `loc` or `iloc`

Use:

```python
loc
```

when you think in terms of labels/names.

Use:

```python
iloc
```

when you think in terms of positions/numbers.

---

## Step 5 — Perform the operation

Examples:

```python
.mean()
.sum()
.max()
.min()
.count()
.sort_values()
.groupby()
.value_counts()
.unique()
```

---

# 46. The "inside-out" technique

For complicated Pandas expressions, always start from the deepest part.

Example:

```python
df.loc[
    (df["Salary"] > 50000) & (df["Department"] == "IT"),
    ["Name", "Salary"]
].sort_values("Salary", ascending=False)
```

Read it in this order:

### 1.

```python
df["Salary"]
```

### 2.

```python
df["Salary"] > 50000
```

### 3.

```python
df["Department"] == "IT"
```

### 4.

```python
(condition1) & (condition2)
```

### 5.

```python
df.loc[condition, ["Name", "Salary"]]
```

### 6.

```python
.sort_values(...)
```

Final meaning:

> Find IT employees earning above 50,000, return Name and Salary, and sort by Salary descending.

---

# 47. Cheat sheet

```python
# One column
df["Age"]

# Multiple columns
df[["Name", "Age"]]

# One column as DataFrame
df[["Age"]]

# Filter rows
df[df["Age"] > 25]

# Multiple conditions
df[(df["Age"] > 20) & (df["Age"] < 30)]

# OR
df[(df["City"] == "Pune") | (df["City"] == "Mumbai")]

# NOT
df[~(df["City"] == "Mumbai")]

# loc - labels
df.loc[0, "Age"]

# loc - multiple rows/columns
df.loc[[0, 2], ["Name", "Age"]]

# loc - condition + columns
df.loc[df["Age"] > 25, ["Name", "Age"]]

# iloc - positions
df.iloc[0, 1]

# iloc - ranges
df.iloc[0:3, 0:2]

# All rows, one column
df.iloc[:, 1]

# All rows, selected columns
df.iloc[:, [0, 2]]

# Call a method
df.mean()

# Select then call a method
df["Age"].mean()

# Group → select → aggregate
df.groupby("City")["Age"].mean()

# Group → aggregate multiple functions
df.groupby("City")["Age"].agg(["mean", "max", "min"])

# Create a column
df["Total"] = df["Price"] * df["Quantity"]

# Rename using dictionary
df.rename(columns={"Age": "Years"})
```

---

# 48. Final memory trick

If your trainees remember only this, make them remember:

```text
()       → DO something
[]       → SELECT something
[[]]     → SELECT a LIST of things
.loc[]   → SELECT using LABELS
.iloc[]  → SELECT using POSITIONS
{}       → MAP/DEFINE things using a dictionary
```

And especially:

```python
df["Age"]
```

= **one column → Series**

```python
df[["Age"]]
```

= **one-column DataFrame**

```python
df[["Age", "City"]]
```

= **multiple columns → DataFrame**

```python
df[df["Age"] > 25]
```

= **filter rows**

```python
df.loc[df["Age"] > 25, ["Name", "Age"]]
```

= **filter rows + select columns**

```python
df.groupby("City")["Age"].mean()
```

= **group → select → calculate**

If you learn to read Pandas expressions **from the inside out**, the brackets stop being confusing and start telling you exactly what the code is doing.
