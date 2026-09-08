# Q330 -- Library Lending Analyzer

## Problem Breakup & Approach

The original Q330 follows this programming pattern:

**Create DataFrame → Calculate Monthly Rate → Add Flag → Filter by
Threshold → Crosstab Summary**

The domain is changed from employee attendance analysis to **Library
Lending Analysis**, while the underlying Pandas and Python patterns
remain the same.

------------------------------------------------------------------------

# 🎯 Overall Problem

A library maintains daily lending records.

Each record contains:

-   Member ID
-   Book Category
-   Date
-   Lending Status

The lending status can be:

``` text
Borrowed
Returned
Overdue
```

Example:

``` python
[
    [501, "Fiction", "2024-06-01", "Borrowed"],
    [502, "Science", "2024-06-01", "Returned"],
    [501, "Fiction", "2024-06-02", "Overdue"]
]
```

The objective is to analyze this data using Pandas.

------------------------------------------------------------------------

# 🔥 Overall Flow

``` text
Raw Lending Data
       ↓
1. Create DataFrame
       ↓
Structured DataFrame
       ↓
2. Calculate Monthly Return Rate
       ↓
Member-wise Monthly Rate
       ↓
3. Add Overdue Flag
       ↓
IsOverdue = 0 / 1
       ↓
4. Find High-Overdue Members
       ↓
Members above threshold
       ↓
5. Category-wise Summary
       ↓
Crosstab
```

------------------------------------------------------------------------

# 1. Create Lending DataFrame

## What is the problem?

The input is a normal Python list:

``` python
data = [
    [501, "Fiction", "2024-06-01", "Borrowed"],
    [502, "Science", "2024-06-01", "Returned"],
    [501, "Fiction", "2024-06-02", "Overdue"]
]
```

We need to convert it into a Pandas DataFrame.

Expected structure:

``` text
   MemberID Category        Date    Status
0       501  Fiction  2024-06-01  Borrowed
1       502  Science  2024-06-01  Returned
2       501  Fiction  2024-06-02  Overdue
```

## Step 1 -- Define columns

``` python
columns = ["MemberID", "Category", "Date", "Status"]
```

## Step 2 -- Create DataFrame

``` python
df = pd.DataFrame(data, columns=columns)
```

## Important

The original problem specifically keeps the date as a **string**.

Do not convert it to datetime.

## Final Approach

``` python
def create_lending_df(self, data: list) -> pd.DataFrame:
    columns = ["MemberID", "Category", "Date", "Status"]

    df = pd.DataFrame(data, columns=columns)

    return df
```

### 🧠 Remember

``` text
List
 ↓
pd.DataFrame()
 ↓
DataFrame
```

------------------------------------------------------------------------

# 2. Calculate Monthly Return Rate

## What is the problem?

We need to calculate:

> What percentage of a member's lending records were marked `Returned`
> during each month?

Formula:

``` text
Return Rate = (Returned Records / Total Records) × 100
```

For example:

``` text
Total records = 4
Returned = 2

Return Rate = (2 / 4) × 100
            = 50%
```

------------------------------------------------------------------------

## Step 1 -- Create Month column

The date looks like:

``` text
2024-06-15
```

We only need:

``` text
2024-06
```

Use:

``` python
df["Month"] = df["Date"].str[:7]
```

Why `[:7]`?

``` text
2024-06-15
0123456...
```

The first 7 characters are:

``` text
2024-06
```

------------------------------------------------------------------------

## Step 2 -- Count Total Records

Use:

``` python
total = (
    df.groupby(["MemberID", "Month"])
    .size()
    .reset_index(name="Total")
)
```

### What does `groupby()` do?

It groups records by:

``` text
MemberID
Month
```

For example:

``` text
Member 501 + June 2024
Member 502 + June 2024
```

### What does `.size()` do?

It counts the number of records in each group.

------------------------------------------------------------------------

# Step 3 -- Filter Returned Records

We only want records where:

``` python
df["Status"] == "Returned"
```

So:

``` python
returned_df = df[df["Status"] == "Returned"]
```

Then group and count:

``` python
returned = (
    returned_df.groupby(["MemberID", "Month"])
    .size()
    .reset_index(name="Returned")
)
```

------------------------------------------------------------------------

# Step 4 -- Merge Total and Returned

We now have two DataFrames:

### Total

``` text
MemberID | Month   | Total
501      | 2024-06 | 4
502      | 2024-06 | 3
```

### Returned

``` text
MemberID | Month   | Returned
501      | 2024-06 | 2
502      | 2024-06 | 3
```

Merge them:

``` python
result = total.merge(
    returned,
    on=["MemberID", "Month"],
    how="left"
)
```

------------------------------------------------------------------------

# Step 5 -- Handle Missing Returned Values

Suppose a member has:

``` text
Total = 5
Returned = no records
```

The merge produces:

``` text
NaN
```

We want:

``` text
0
```

Use:

``` python
result["Returned"] = result["Returned"].fillna(0)
```

------------------------------------------------------------------------

# Step 6 -- Calculate Return Rate

Formula:

``` python
result["Return Rate"] = (
    result["Returned"] / result["Total"]
) * 100
```

------------------------------------------------------------------------

## Final Approach

``` python
def compute_monthly_return_rate(self, df: pd.DataFrame) -> pd.DataFrame:

    df = df.copy()

    df["Month"] = df["Date"].str[:7]

    total = (
        df.groupby(["MemberID", "Month"])
        .size()
        .reset_index(name="Total")
    )

    returned = (
        df[df["Status"] == "Returned"]
        .groupby(["MemberID", "Month"])
        .size()
        .reset_index(name="Returned")
    )

    result = total.merge(
        returned,
        on=["MemberID", "Month"],
        how="left"
    )

    result["Returned"] = result["Returned"].fillna(0)

    result["Return Rate"] = (
        result["Returned"] / result["Total"]
    ) * 100

    return result[["MemberID", "Month", "Return Rate"]]
```

### 🧠 Remember

``` text
Date
 ↓
Month
 ↓
Group + Count Total
 ↓
Filter Returned
 ↓
Group + Count Returned
 ↓
Merge
 ↓
Fill NaN
 ↓
Calculate %
```

------------------------------------------------------------------------

# 3. Add Overdue Flag

## What is the problem?

We need to create a new column:

``` text
IsOverdue
```

Rules:

``` text
Overdue  → 1
Anything else → 0
```

Example:

``` text
Status       IsOverdue
Borrowed        0
Returned        0
Overdue         1
```

------------------------------------------------------------------------

## Step 1 -- Compare Status

``` python
df["Status"] == "Overdue"
```

This produces:

``` text
False
False
True
```

## Step 2 -- Convert Boolean to Integer

``` python
.astype(int)
```

converts:

``` text
False → 0
True  → 1
```

## Final Approach

``` python
def add_overdue_flag(self, df: pd.DataFrame) -> pd.DataFrame:

    df = df.copy()

    df["IsOverdue"] = (
        df["Status"] == "Overdue"
    ).astype(int)

    return df
```

### 🧠 Remember

``` text
Condition
   ↓
True / False
   ↓
.astype(int)
   ↓
1 / 0
```

------------------------------------------------------------------------

# 4. Find Members with High Overdue Records

## What is the problem?

Find members whose number of overdue records is **greater than the
threshold**.

Example:

``` text
threshold = 2
```

If:

``` text
Member 501 → 1 overdue
Member 502 → 3 overdue
Member 503 → 4 overdue
```

Result:

``` text
MemberID | Overdue Count
502      | 3
503      | 4
```

Why?

Because:

``` text
1 > 2 → False
3 > 2 → True
4 > 2 → True
```

------------------------------------------------------------------------

## Step 1 -- Filter Overdue Records

``` python
overdue = df[df["Status"] == "Overdue"]
```

------------------------------------------------------------------------

## Step 2 -- Group by Member

``` python
overdue.groupby("MemberID")
```

------------------------------------------------------------------------

## Step 3 -- Count

``` python
overdue.groupby("MemberID").size()
```

------------------------------------------------------------------------

## Step 4 -- Convert to DataFrame

``` python
.reset_index(name="Overdue Count")
```

------------------------------------------------------------------------

## Step 5 -- Apply Threshold

``` python
result = result[
    result["Overdue Count"] > threshold
]
```

------------------------------------------------------------------------

## Final Approach

``` python
def high_overdue_members(
    self,
    df: pd.DataFrame,
    threshold: int
) -> pd.DataFrame:

    overdue = df[df["Status"] == "Overdue"]

    result = (
        overdue.groupby("MemberID")
        .size()
        .reset_index(name="Overdue Count")
    )

    result = result[
        result["Overdue Count"] > threshold
    ]

    return result.reset_index(drop=True)
```

### 🧠 Remember

``` text
Filter
  ↓
GroupBy
  ↓
Count
  ↓
Threshold
  ↓
Return
```

------------------------------------------------------------------------

# 5. Category-wise Lending Summary

## What is the problem?

We need to know how many:

-   Borrowed
-   Returned
-   Overdue

records exist for each category.

Example:

``` text
Category    Borrowed    Returned    Overdue
Fiction        3           2           1
Science        2           3           0
```

This is a perfect use case for:

``` python
pd.crosstab()
```

------------------------------------------------------------------------

# Step 1 -- Create Crosstab

``` python
result = pd.crosstab(
    df["Category"],
    df["Status"]
)
```

This creates a table similar to:

``` text
Status      Borrowed  Returned  Overdue
Category
Fiction          3         2        1
Science          2         3        0
```

------------------------------------------------------------------------

# Step 2 -- Remove Column Name

The crosstab may have:

``` text
Status
```

as the column name.

Use:

``` python
result.columns.name = None
```

------------------------------------------------------------------------

# Step 3 -- Ensure Required Columns Exist

We want exactly:

``` text
Borrowed
Returned
Overdue
```

Use:

``` python
result = result.reindex(
    columns=["Borrowed", "Returned", "Overdue"],
    fill_value=0
)
```

This also handles a category where one status doesn't occur.

------------------------------------------------------------------------

# Step 4 -- Reset Index

``` python
result = result.reset_index()
```

Now `Category` becomes a normal column.

------------------------------------------------------------------------

## Final Approach

``` python
def category_lending_summary(
    self,
    df: pd.DataFrame
) -> pd.DataFrame:

    result = pd.crosstab(
        df["Category"],
        df["Status"]
    )

    result.columns.name = None

    result = result.reindex(
        columns=["Borrowed", "Returned", "Overdue"],
        fill_value=0
    )

    return result.reset_index()
```

### 🧠 Remember

``` text
Category + Status
       ↓
pd.crosstab()
       ↓
reindex()
       ↓
fill_value=0
       ↓
reset_index()
```

------------------------------------------------------------------------

# 🔥 Complete Q330 Flow

Suppose the input is:

``` python
data = [
    [501, "Fiction", "2024-06-01", "Borrowed"],
    [502, "Science", "2024-06-01", "Returned"],
    [501, "Fiction", "2024-06-02", "Overdue"],
    [501, "Fiction", "2024-06-03", "Returned"],
    [502, "Science", "2024-06-02", "Returned"]
]
```

## Step 1

``` text
List
 ↓
DataFrame
```

## Step 2

``` text
Date
 ↓
Month
 ↓
Total records
 ↓
Returned records
 ↓
Merge
 ↓
Return Rate
```

## Step 3

``` text
Status
 ↓
Status == "Overdue"
 ↓
True / False
 ↓
1 / 0
```

## Step 4

``` text
Overdue records
 ↓
Group by MemberID
 ↓
Count
 ↓
Count > threshold
```

## Step 5

``` text
Category + Status
 ↓
pd.crosstab()
 ↓
Borrowed / Returned / Overdue
```

------------------------------------------------------------------------

# 🧩 Exam Approach

When you see Q330, don't write the entire solution immediately.

Break it into these five functions:

``` text
Q330
 │
 ├── 1. create_lending_df()
 │      ├── columns
 │      └── pd.DataFrame()
 │
 ├── 2. compute_monthly_return_rate()
 │      ├── str[:7]
 │      ├── groupby()
 │      ├── size()
 │      ├── filter
 │      ├── merge()
 │      ├── fillna()
 │      └── percentage
 │
 ├── 3. add_overdue_flag()
 │      ├── condition
 │      └── astype(int)
 │
 ├── 4. high_overdue_members()
 │      ├── filter
 │      ├── groupby()
 │      ├── size()
 │      └── threshold
 │
 └── 5. category_lending_summary()
        ├── crosstab()
        ├── reindex()
        ├── fill_value=0
        └── reset_index()
```

------------------------------------------------------------------------

# ⭐ Most Important Pandas Patterns

  Requirement              Pattern
  ------------------------ ---------------------------------------
  Create DataFrame         `pd.DataFrame(data, columns=columns)`
  Copy DataFrame           `df.copy()`
  Extract Year-Month       `df["Date"].str[:7]`
  Filter rows              `df[df["Status"] == "Returned"]`
  Group data               `df.groupby(["MemberID", "Month"])`
  Count groups             `.size()`
  Name result              `.reset_index(name="Total")`
  Merge DataFrames         `.merge(..., how="left")`
  Replace missing values   `.fillna(0)`
  Calculate percentage     `(count / total) * 100`
  Boolean → integer        `.astype(int)`
  Crosstab                 `pd.crosstab()`
  Select/reorder columns   `.reindex(columns=[...])`
  Fill missing columns     `fill_value=0`
  Reset index              `.reset_index()`

------------------------------------------------------------------------

# 🧠 The 5 Patterns to Memorize

### Pattern 1 -- DataFrame

``` python
df = pd.DataFrame(data, columns=columns)
```

### Pattern 2 -- Group and Count

``` python
df.groupby("MemberID").size()
```

### Pattern 3 -- Filter

``` python
df[df["Status"] == "Overdue"]
```

### Pattern 4 -- Boolean Flag

``` python
(df["Status"] == "Overdue").astype(int)
```

### Pattern 5 -- Crosstab

``` python
pd.crosstab(df["Category"], df["Status"])
```

------------------------------------------------------------------------

# 🚀 One-Line Memory Trick

``` text
CREATE → GROUP → FILTER → FLAG → CROSS-TAB
```

For the monthly calculation:

``` text
DATE → MONTH → TOTAL → RETURNED → MERGE → RATE
```

For high overdue members:

``` text
FILTER → GROUP → COUNT → THRESHOLD
```

For category summary:

``` text
CROSSTAB → REINDEX → RESET
```

------------------------------------------------------------------------

# 🎯 Key Insight

Q330 is fundamentally a:

**Pandas DataFrame + GroupBy + Filtering + Merge + Crosstab**

problem.

The **library lending** domain changes the story and column names, but
the underlying programming techniques remain the same as the original
attendance-analysis question.
