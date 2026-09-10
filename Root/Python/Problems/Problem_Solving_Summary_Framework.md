# MS1 Python + SQL --- Complete Function Summary, Problem-Solving Framework, Tips & Solutions

This guide is based on the supplied MS1-style Python and SQL problems
and the similar practice questions created from them. The source Python
paper covers Pandas DataFrame analysis, NumPy operations, and
dictionary-based Python OOP; the SQL paper uses `AVG()` window functions
and `LAG()` window functions. fileciteturn0file0L4-L11
fileciteturn0file1L11-L23

------------------------------------------------------------------------

## 1. The Master Problem-Solving Framework

For every question, use:

``` text
INPUT
  ↓
WHAT DOES ONE OUTPUT ROW / VALUE REPRESENT?
  ↓
WHAT OPERATION IS REQUIRED?
  ↓
WHAT CONDITIONS APPLY?
  ↓
WHAT FUNCTION / TECHNIQUE MATCHES IT?
  ↓
WHAT EDGE CASES EXIST?
  ↓
WHAT EXACT OUTPUT FORMAT IS REQUIRED?
```

Before coding, identify:

1.  Input type
2.  Required operation
3.  Conditions
4.  Boundary operators (`<`, `<=`, `>`, `>=`)
5.  Output columns/type
6.  Sorting requirements
7.  Index requirements
8.  Rounding requirements
9.  Error/exception requirements
10. Empty/missing/invalid cases

------------------------------------------------------------------------

# 2. Pandas --- Complete Function Summary

The supplied Pandas pattern requires DataFrame creation, cleaning,
flagging, grouping, threshold filtering, cost calculation, sorting,
copying, and zero-based indexing. fileciteturn0file0L25-L51

## `pd.DataFrame()`

Creates a DataFrame.

``` python
df = pd.DataFrame(data, columns=columns)
```

**Use when:** the question says to create a DataFrame from a list of
rows.

------------------------------------------------------------------------

## `df.copy()`

Creates a copy without modifying the original.

``` python
result = df.copy()
```

**Use when:** the question says "return a copy" or "do not modify the
input".

------------------------------------------------------------------------

## `df.notna()`

Checks for non-missing values.

``` python
df.notna()
```

For an entire row:

``` python
df.notna().all(axis=1)
```

**Use when:** every column in a row must contain a value.

------------------------------------------------------------------------

## `Series.isin()`

Checks whether values belong to an allowed set.

``` python
df["Status"].isin(["Completed", "Scheduled"])
```

**Use when:** the requirement says "must be one of A, B, C".

------------------------------------------------------------------------

## Boolean filtering

``` python
df[df["UsageHours"] > 0]
```

Multiple conditions:

``` python
df[
    (df["UsageHours"] > 0)
    & (df["DowntimeHours"] >= 0)
]
```

Use `&`, `|`, and `~` for Pandas conditions.

Do not use Python `and`, `or`, `not`.

------------------------------------------------------------------------

## `df.loc[]`

Select rows and columns.

``` python
df.loc[valid, required_columns]
```

Very useful when the output must have an exact column order.

------------------------------------------------------------------------

## `reset_index(drop=True)`

Creates a zero-based index.

``` python
result.reset_index(drop=True)
```

Use this when the question explicitly requires a zero-based index.

------------------------------------------------------------------------

## `groupby()`

Groups rows by a column.

``` python
df.groupby("EquipmentID")
```

Think:

> "for each equipment/site/customer/department"

→ `groupby()`.

------------------------------------------------------------------------

## `groupby(..., as_index=False)`

Keeps the grouping column as a normal output column.

``` python
df.groupby("EquipmentID", as_index=False)
```

This is often convenient for assessment outputs.

------------------------------------------------------------------------

## `agg()`

Performs several aggregations together.

``` python
result = (
    df.groupby("EquipmentID", as_index=False)
      .agg(
          ServiceCount=("ServiceID", "count"),
          TotalUsageHours=("UsageHours", "sum"),
          AverageDowntime=("DowntimeHours", "mean")
      )
)
```

Pattern:

``` python
NewColumn=("ExistingColumn", "function")
```

Common functions:

``` text
sum
mean
count
max
min
```

------------------------------------------------------------------------

## `sum()`

``` python
df["Amount"].sum()
```

Grouped:

``` python
df.groupby("Department")["Amount"].sum()
```

Keywords:

``` text
total
sum
overall amount
total usage
```

→ `sum()`.

------------------------------------------------------------------------

## `mean()`

``` python
df["DowntimeHours"].mean()
```

Keywords:

``` text
average
mean
avg
```

→ `mean()`.

------------------------------------------------------------------------

## `count()`

``` python
df.groupby("EquipmentID")["ServiceID"].count()
```

Keywords:

``` text
number of records
number of inspections
count
```

→ `count()`.

------------------------------------------------------------------------

## `rename()`

``` python
result.rename(
    columns={"UsageHours": "TotalUsageHours"}
)
```

Use when the aggregation creates a column with the wrong name.

------------------------------------------------------------------------

## `sort_values()`

``` python
result.sort_values("EquipmentID")
```

Multiple columns:

``` python
result.sort_values(
    ["Department", "ServiceCost"]
)
```

Question:

> Sort by A, then B, then C.

Use:

``` python
.sort_values(["A", "B", "C"])
```

------------------------------------------------------------------------

## `.round()`

``` python
result["AverageDowntime"] = (
    result["AverageDowntime"].round(2)
)
```

Question:

> Round to two decimals.

→ `.round(2)`.

------------------------------------------------------------------------

## `.astype(int)`

Converts Boolean values to 1/0.

``` python
result["NeedsAttention"] = (
    result["DowntimeHours"] > threshold
).astype(int)
```

This gives:

``` text
True  → 1
False → 0
```

------------------------------------------------------------------------

# 3. Pandas Problem Patterns

## Pattern A --- Data cleaning

``` python
valid = (
    df.notna().all(axis=1)
    & (df["UsageHours"] > 0)
    & (df["DowntimeHours"] >= 0)
    & df["ServiceStatus"].isin(
        ["Completed", "Scheduled"]
    )
)

result = (
    df.loc[valid, columns]
      .copy()
      .reset_index(drop=True)
)
```

### Translation

``` text
No missing values
AND Usage > 0
AND Downtime >= 0
AND Status is allowed
```

------------------------------------------------------------------------

## Pattern B --- Flag

``` python
result = df.copy()

result["NeedsAttention"] = (
    result["DowntimeHours"] > threshold
).astype(int)
```

### Boundary trap

"Greater than" means:

``` python
>
```

not:

``` python
>=
```

------------------------------------------------------------------------

## Pattern C --- Group summary

``` python
result = (
    df.groupby("EquipmentID", as_index=False)
      .agg(
          Count=("ID", "count"),
          Total=("UsageHours", "sum"),
          Average=("DowntimeHours", "mean")
      )
)

result["Average"] = result["Average"].round(2)

result = (
    result
    .sort_values("EquipmentID")
    .reset_index(drop=True)
)
```

------------------------------------------------------------------------

## Pattern D --- Group then threshold

Question:

> Keep equipment whose total usage is strictly less than threshold.

Think:

``` text
GROUP
 ↓
SUM
 ↓
FILTER
 ↓
SORT
```

Code:

``` python
result = (
    df.groupby("EquipmentID", as_index=False)["UsageHours"]
      .sum()
      .rename(columns={"UsageHours": "TotalUsageHours"})
)

result = result[
    result["TotalUsageHours"] < threshold
]
```

------------------------------------------------------------------------

# 4. NumPy --- Complete Function Summary

The supplied NumPy pattern consists of creating an array, validating it,
computing statistics, categorizing values, and finding a longest
consecutive warning streak. fileciteturn0file0L118-L179

## `np.asarray()`

``` python
arr = np.asarray(values)
```

With dtype:

``` python
arr = np.asarray(
    values,
    dtype=np.float64
)
```

Use when creating a NumPy array from a list.

------------------------------------------------------------------------

## `dtype=np.float64`

For a required floating-point array:

``` python
np.asarray(values, dtype=np.float64)
```

Example:

``` text
[12, 15, 18]
```

becomes:

``` text
[12.0, 15.0, 18.0]
```

------------------------------------------------------------------------

## `.reshape(-1)`

Makes an array one-dimensional.

``` python
arr.reshape(-1)
```

Useful when the question explicitly requires a 1-D array.

------------------------------------------------------------------------

## `arr.size`

Number of elements.

``` python
if arr.size == 0:
    return False
```

Use for empty-array checks.

------------------------------------------------------------------------

## `np.issubdtype()`

Checks dtype category.

``` python
np.issubdtype(
    arr.dtype,
    np.number
)
```

Use when the question says the array must be numeric.

------------------------------------------------------------------------

## `np.all()`

Checks whether all values satisfy a condition.

``` python
np.all(
    (arr >= 12)
    & (arr <= 30)
)
```

Think:

> "Are ALL values valid?"

→ `np.all()`.

------------------------------------------------------------------------

## `np.mean()`

``` python
np.mean(arr)
```

Average.

------------------------------------------------------------------------

## `np.std()`

``` python
np.std(arr)
```

Population standard deviation when using the default `ddof=0`.

------------------------------------------------------------------------

## `np.max()` / `np.min()`

``` python
np.max(arr)
np.min(arr)
```

Maximum and minimum.

------------------------------------------------------------------------

## `float()`

Converts a NumPy scalar to a Python `float`.

``` python
float(np.mean(arr))
```

Useful when the question explicitly requires Python float values.

------------------------------------------------------------------------

## `round()`

``` python
round(float(np.mean(arr)), 2)
```

Rounds to two decimal places.

------------------------------------------------------------------------

## `np.select()`

For multiple categories:

``` python
np.select(
    [
        condition_1,
        condition_2,
        condition_3
    ],
    [
        "Category1",
        "Category2",
        "Category3"
    ],
    default="Invalid"
)
```

Think:

``` text
condition 1 → category 1
condition 2 → category 2
condition 3 → category 3
otherwise   → default
```

------------------------------------------------------------------------

# 5. NumPy Validation Framework

When a question says:

> Valid only when non-empty, numeric, and all values are in range.

Use:

``` python
if arr.size == 0:
    return False

if not np.issubdtype(
    arr.dtype,
    np.number
):
    return False

return bool(
    np.all(
        (arr >= LOWER)
        & (arr <= UPPER)
    )
)
```

The sequence is:

``` text
EMPTY?
 ↓ No
NUMERIC?
 ↓ Yes
ALL VALUES IN RANGE?
 ↓ Yes
True
```

This also prevents non-numeric arrays from causing comparison errors.

------------------------------------------------------------------------

# 6. Boundary Testing

Whenever ranges appear, test:

``` text
just below lower
lower
just above lower
just below upper
upper
just above upper
```

For:

``` text
12 <= x <= 30
```

test:

``` text
11.9
12
12.1
29.9
30
30.1
```

For a strict threshold:

``` text
x < 30
```

test:

``` text
29.9
30
30.1
```

------------------------------------------------------------------------

# 7. Streak Problems

A streak means **consecutive** matches.

Example:

``` text
Warm Warm Cold Warm Warm Warm Cold
```

Longest warm streak:

``` text
3
```

Use:

``` python
current = 0
longest = 0

for value in arr:

    if condition(value):
        current += 1
        longest = max(
            longest,
            current
        )

    else:
        current = 0

return longest
```

### Key idea

``` text
MATCH → current += 1
BREAK → current = 0
MAX   → keep longest
```

Do not simply count all matching values.

------------------------------------------------------------------------

# 8. Python OOP --- Complete Function Summary

The OOP pattern uses an object containing a dictionary registry,
duplicate protection, field updates, lookup, and ordered filtering. The
source pattern explicitly specifies dictionary state and
`ValueError`/`KeyError` behavior. fileciteturn0file0L180-L243

## Dictionary state

``` python
self.loans = {}
```

Example:

``` python
self.loans = {
    "L001": {
        "book_title": "Python Basics",
        "member_name": "Meera",
        "status": "On Loan"
    }
}
```

------------------------------------------------------------------------

## Check whether a key exists

``` python
if loan_id in self.loans:
```

------------------------------------------------------------------------

## Check whether a key does not exist

``` python
if loan_id not in self.loans:
```

------------------------------------------------------------------------

## `raise ValueError`

Use for invalid operation/value conditions such as duplicate
registration.

``` python
raise ValueError(
    "Loan already registered"
)
```

------------------------------------------------------------------------

## `raise KeyError`

Use when the requested dictionary key does not exist.

``` python
raise KeyError(
    "Loan not found"
)
```

### Memory trick

``` text
Duplicate existing record → ValueError

Missing requested record  → KeyError
```

------------------------------------------------------------------------

## Insert dictionary record

``` python
self.loans[loan_id] = {
    "book_title": book_title,
    "member_name": member_name,
    "status": "On Loan"
}
```

------------------------------------------------------------------------

## Update only one field

``` python
self.loans[loan_id][
    "member_name"
] = new_member_name
```

If the question says "update only X", do not recreate all fields
unnecessarily.

------------------------------------------------------------------------

## Lookup

``` python
return self.loans[loan_id]
```

------------------------------------------------------------------------

## Iterate through dictionary

``` python
for loan_id, details in self.loans.items():
    ...
```

------------------------------------------------------------------------

## Filter dictionary records

``` python
return [
    loan_id
    for loan_id, details
    in self.loans.items()
    if details["member_name"] == member_name
]
```

Python dictionaries preserve insertion order, so this pattern naturally
preserves the order in which matching records were inserted.

------------------------------------------------------------------------

# 9. OOP Problem Framework

For every registry question, identify:

``` text
STATE
 ↓
KEY
 ↓
RECORD FIELDS
 ↓
DUPLICATE RULE
 ↓
MISSING-KEY RULE
 ↓
UPDATE RULE
 ↓
SEARCH/FILTER RULE
 ↓
RETURN VALUE
```

------------------------------------------------------------------------

# 10. SQL --- Complete Function Summary

The supplied SQL problems use three-table joins and window functions.
The original SQL question requires `AVG()` with `PARTITION BY`, while
the second requires `LAG()` partitioned by the customer and ordered by
date/ID. fileciteturn0file1L11-L34 fileciteturn0file1L44-L67

## `JOIN`

Use when required columns come from different tables.

``` sql
FROM Deliveries AS d
JOIN Routes AS r
    ON d.route_id = r.route_id
JOIN Drivers AS dr
    ON d.driver_id = dr.driver_id
```

### Mental question

> Where does each required output column live?

Then join the required tables.

------------------------------------------------------------------------

## `WHERE`

Filters rows.

``` sql
WHERE d.status = 'Completed'
```

Typical keywords:

``` text
only
exclude
must be
where
active
completed
```

→ `WHERE`.

------------------------------------------------------------------------

# 11. `GROUP BY` vs Window Functions

This distinction is extremely important.

### `GROUP BY`

``` sql
SELECT
    route_id,
    AVG(delivery_time)
FROM Deliveries
GROUP BY route_id;
```

Produces approximately:

``` text
one row per route
```

### Window function

``` sql
AVG(delivery_time) OVER(
    PARTITION BY route_id
)
```

Produces:

``` text
every delivery row
+
route average
```

### Memory trick

``` text
GROUP BY
→ collapses rows

WINDOW
→ keeps rows
  + adds calculation
```

------------------------------------------------------------------------

# 12. `AVG() OVER(PARTITION BY ...)`

Pattern:

``` sql
AVG(value) OVER (
    PARTITION BY group_id
)
```

Example:

``` sql
AVG(d.delivery_time) OVER (
    PARTITION BY d.route_id
)
```

Meaning:

> Calculate the average separately for each route while retaining each
> delivery row.

------------------------------------------------------------------------

# 13. Filtering Before Window Calculation

Suppose:

``` text
42.5 Completed
39.0 Completed
46.0 Completed
55.0 Delayed
```

If only completed deliveries count, the average must use:

``` text
42.5
39.0
46.0
```

not:

``` text
42.5
39.0
46.0
55.0
```

Therefore:

``` sql
WHERE status = 'Completed'
```

must remove the unwanted rows before the window average is calculated.

### Exam clue

If the question says:

> Excluded records must not be included in the average.

Pay special attention to the filtering stage.

------------------------------------------------------------------------

# 14. SQL `ROUND()`

``` sql
ROUND(
    AVG(d.delivery_time) OVER(
        PARTITION BY d.route_id
    ),
    2
)
```

------------------------------------------------------------------------

# 15. SQL `ORDER BY`

Question:

``` text
Sort by:
route_name
delivery_time
driver_name
```

Code:

``` sql
ORDER BY
    r.route_name,
    d.delivery_time,
    dr.driver_name;
```

Keep the exact order specified by the question.

------------------------------------------------------------------------

# 16. `LAG()`

Retrieves the previous row's value.

``` sql
LAG(appointment_date) OVER (
    PARTITION BY patient_id
    ORDER BY appointment_date, appointment_id
)
```

Conceptually:

``` text
Current Date     Previous Date
2026-08-02       NULL
2026-08-08       2026-08-02
2026-08-21       2026-08-08
```

------------------------------------------------------------------------

# 17. `PARTITION BY`

Separates the calculation into independent groups.

``` sql
PARTITION BY patient_id
```

Means:

> Never use another patient's appointment as the previous appointment.

This is essential in customer/order, patient/appointment,
employee/event, etc. problems.

------------------------------------------------------------------------

# 18. Window `ORDER BY`

This determines what "previous" means.

``` sql
ORDER BY
    appointment_date,
    appointment_id
```

If two records have the same date, the ID provides a deterministic
order.

### Rule

If the question says:

> Order by date, then ID.

Put both columns inside the window's `ORDER BY`.

------------------------------------------------------------------------

# 19. First row with `LAG()`

The first row of each partition has no previous row.

Therefore:

``` text
LAG() → NULL
```

Do not convert it to zero unless explicitly requested.

------------------------------------------------------------------------

# 20. CTE / `WITH`

A CTE is useful when the SQL problem has multiple logical stages.

Example:

``` sql
WITH ordered_appointments AS (
    SELECT
        ...,
        LAG(...) OVER(...) AS previous_date
    FROM ...
)
SELECT
    ...,
    DATEDIFF(
        appointment_date,
        previous_date
    )
FROM ordered_appointments;
```

Think:

``` text
STEP 1
Find previous value

STEP 2
Calculate using previous value
```

------------------------------------------------------------------------

# 21. `DATEDIFF()`

For MySQL-style SQL:

``` sql
DATEDIFF(
    current_date,
    previous_date
)
```

Example:

``` sql
DATEDIFF(
    appointment_date,
    previous_appointment_date
)
```

The exact date-difference syntax can differ between SQL engines, so
check the database dialect used by the assessment platform.

------------------------------------------------------------------------

# 22. SQL Decision Tree

Ask:

### Are columns from different tables?

``` text
YES → JOIN
```

### Need to remove rows?

``` text
YES → WHERE
```

### Need one result per group?

``` text
YES → GROUP BY
```

### Need group statistics while retaining every row?

``` text
YES → WINDOW FUNCTION
```

### Need average per group?

``` text
AVG() OVER(PARTITION BY ...)
```

### Need previous row?

``` text
LAG()
```

### Need next row?

``` text
LEAD()
```

### Need ranking?

``` text
ROW_NUMBER()
RANK()
DENSE_RANK()
```

### Need calculation after a window function?

``` text
CTE / subquery
```

### Need final ordering?

``` text
ORDER BY
```

------------------------------------------------------------------------

# 23. Keyword-to-Function Cheat Sheet

  Requirement wording       Function / technique
  ------------------------- ------------------------------------
  Create DataFrame          `pd.DataFrame()`
  Copy                      `df.copy()`
  Missing values            `isna()` / `notna()`
  Allowed values            `isin()`
  Keep rows                 Boolean filtering
  Select rows/columns       `.loc[]`
  Zero-based index          `reset_index(drop=True)`
  Group by                  `groupby()`
  Total                     `sum()`
  Average                   `mean()`
  Count                     `count()`
  Multiple statistics       `agg()`
  Rename                    `rename()`
  Sort                      `sort_values()`
  Round                     `round()`
  1/0 flag                  Boolean expression + `astype(int)`
  NumPy array               `np.asarray()`
  Float64                   `dtype=np.float64`
  1-D                       `reshape(-1)`
  Empty                     `arr.size`
  Numeric dtype             `np.issubdtype()`
  All values valid          `np.all()`
  NumPy average             `np.mean()`
  NumPy std                 `np.std()`
  Maximum                   `np.max()`
  Minimum                   `np.min()`
  Categories                `np.select()`
  Consecutive run           loop + `current` + `longest`
  Dictionary state          `self.records = {}`
  Duplicate                 `ValueError`
  Missing key               `KeyError`
  Multiple SQL tables       `JOIN`
  Filter                    `WHERE`
  Group result              `GROUP BY`
  Average + retain rows     `AVG() OVER()`
  Separate window groups    `PARTITION BY`
  Previous row              `LAG()`
  Next row                  `LEAD()`
  Intermediate SQL result   `WITH` / CTE
  Date gap                  `DATEDIFF()` in MySQL
  Final sorting             `ORDER BY`

------------------------------------------------------------------------

# 24. Common Mistakes

## Mistake 1 --- Pandas `and` instead of `&`

Wrong:

``` python
(df["A"] > 10) and (df["B"] < 20)
```

Correct:

``` python
(df["A"] > 10) & (df["B"] < 20)
```

------------------------------------------------------------------------

## Mistake 2 --- Missing parentheses

Wrong:

``` python
df["A"] > 10 & df["B"] < 20
```

Correct:

``` python
(df["A"] > 10) & (df["B"] < 20)
```

------------------------------------------------------------------------

## Mistake 3 --- Wrong boundary

Question:

> Strictly less than 50.

Correct:

``` python
x < 50
```

Not:

``` python
x <= 50
```

------------------------------------------------------------------------

## Mistake 4 --- Modifying input DataFrame

Question:

> Return a copy.

Use:

``` python
result = df.copy()
```

------------------------------------------------------------------------

## Mistake 5 --- Forgetting `reset_index(drop=True)`

If zero-based index is required:

``` python
.reset_index(drop=True)
```

------------------------------------------------------------------------

## Mistake 6 --- Wrong column order

Assessment output often expects:

``` text
Column A
Column B
Column C
Column D
```

not merely the correct values in an arbitrary order.

------------------------------------------------------------------------

## Mistake 7 --- Confusing `GROUP BY` with a window function

Remember:

``` text
GROUP BY → fewer rows
WINDOW   → same rows + calculation
```

------------------------------------------------------------------------

## Mistake 8 --- Forgetting `PARTITION BY`

For customer-specific previous orders:

``` sql
LAG(order_date) OVER (
    PARTITION BY customer_id
    ORDER BY order_date, order_id
)
```

------------------------------------------------------------------------

## Mistake 9 --- Wrong `LAG()` ordering

If sequence is:

``` text
date → ID
```

use:

``` sql
ORDER BY date, id
```

------------------------------------------------------------------------

# 25. Exam Strategy --- 10 Steps

## Step 1 --- Read the output first

Ask:

> What exactly must I return?

## Step 2 --- Extract operation words

Look for:

``` text
create
clean
filter
flag
group
sum
average
categorize
previous
partition
sort
```

## Step 3 --- Identify the data structure

``` text
Pandas → DataFrame
NumPy → ndarray
OOP → object + dictionary
SQL → tables
```

## Step 4 --- Translate every sentence into an operation

Example:

> Keep equipment whose total usage is strictly less than threshold.

Translate to:

``` text
groupby EquipmentID
→ sum UsageHours
→ < threshold
→ filter
```

## Step 5 --- Check boundaries

Look for:

``` text
strictly greater
greater than or equal
strictly less
less than or equal
inclusive
exclusive
```

## Step 6 --- Check edge cases

``` text
empty?
missing?
invalid?
duplicate?
first row?
no match?
```

## Step 7 --- Match exact output

Check:

``` text
column names
column order
data type
rounding
sort order
index
```

## Step 8 --- Manually test boundary values

For threshold 10:

``` text
9.99
10
10.01
```

## Step 9 --- Test one normal example manually

Calculate the expected answer by hand.

## Step 10 --- Submit only after checking every requirement

------------------------------------------------------------------------

# 26. Memory Tricks

## Pandas: C-F-G-S-R

``` text
C → Create
F → Filter
G → Group
S → Summarize
R → Reorder
```

``` python
pd.DataFrame()
filter
groupby()
sum / mean / count / agg
sort_values()
reset_index()
```

------------------------------------------------------------------------

## NumPy: A-V-S-C-S

``` text
A → Array
V → Validate
S → Statistics
C → Categorize
S → Streak
```

------------------------------------------------------------------------

## SQL AVG: J-F-W-R

``` text
J → JOIN
F → FILTER
W → WINDOW
R → RESULT/SORT
```

------------------------------------------------------------------------

## SQL LAG: P-O-L-D-S

``` text
P → PARTITION
O → ORDER
L → LAG
D → Difference
S → Sort
```

------------------------------------------------------------------------

# 27. Final Assessment Checklist

## Python

``` text
[ ] Correct class/function name
[ ] Correct parameters
[ ] Correct return type
[ ] Correct columns
[ ] Correct column order
[ ] Correct comparison operator
[ ] Missing values handled
[ ] Empty array handled
[ ] Non-numeric array handled
[ ] Original DataFrame preserved when required
[ ] Correct groupby
[ ] Correct aggregation
[ ] Correct rounding
[ ] Correct sorting
[ ] Correct index
[ ] Correct exception
[ ] Correct exception message
[ ] Boundary values checked
```

## SQL

``` text
[ ] Correct tables
[ ] Correct JOIN
[ ] Correct JOIN condition
[ ] Correct WHERE
[ ] Correct window function
[ ] Correct PARTITION BY
[ ] Correct window ORDER BY
[ ] Excluded rows don't affect calculations
[ ] Correct date calculation
[ ] Correct aliases
[ ] Correct output columns
[ ] Correct final ORDER BY
[ ] First LAG row is NULL
```

------------------------------------------------------------------------

# 28. Complete Reference Solutions

## Solution 1 --- Pandas

``` python
import pandas as pd

class HospitalEquipmentAnalyzer:

    def create_services_df(self, service_data: list) -> pd.DataFrame:
        columns = [
            "ServiceID", "EquipmentID", "Department",
            "ServiceDate", "UsageHours", "DowntimeHours",
            "ServiceStatus"
        ]

        return pd.DataFrame(
            service_data,
            columns=columns
        )

    def clean_service_data(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        valid = (
            df.notna().all(axis=1)
            & (df["UsageHours"] > 0)
            & (df["DowntimeHours"] >= 0)
            & df["ServiceStatus"].isin(
                ["Completed", "Scheduled"]
            )
        )

        columns = [
            "ServiceID", "EquipmentID", "Department",
            "ServiceDate", "UsageHours", "DowntimeHours",
            "ServiceStatus"
        ]

        return (
            df.loc[valid, columns]
              .copy()
              .reset_index(drop=True)
        )

    def add_attention_flag(
        self,
        df: pd.DataFrame,
        downtime_threshold: float
    ) -> pd.DataFrame:

        result = df.copy()

        result["NeedsAttention"] = (
            result["DowntimeHours"]
            > downtime_threshold
        ).astype(int)

        return result

    def equipment_performance_summary(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = (
            df.groupby(
                "EquipmentID",
                as_index=False
            )
            .agg(
                ServiceCount=("ServiceID", "count"),
                TotalUsageHours=("UsageHours", "sum"),
                AverageDowntime=("DowntimeHours", "mean")
            )
        )

        result["AverageDowntime"] = (
            result["AverageDowntime"].round(2)
        )

        return (
            result
            .sort_values("EquipmentID")
            .reset_index(drop=True)
        )

    def low_usage_equipment(
        self,
        df: pd.DataFrame,
        usage_threshold: float
    ) -> pd.DataFrame:

        result = (
            df.groupby(
                "EquipmentID",
                as_index=False
            )["UsageHours"]
            .sum()
            .rename(
                columns={
                    "UsageHours": "TotalUsageHours"
                }
            )
        )

        result = result[
            result["TotalUsageHours"]
            < usage_threshold
        ]

        return (
            result
            .sort_values("EquipmentID")
            .reset_index(drop=True)
        )

    def departmental_service_cost(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        completed = df[
            df["ServiceStatus"] == "Completed"
        ].copy()

        completed["ServiceCost"] = (
            completed["DowntimeHours"] * 300.0
        )

        result = (
            completed
            .groupby(
                "Department",
                as_index=False
            )["ServiceCost"]
            .sum()
        )

        return (
            result
            .sort_values("Department")
            .reset_index(drop=True)
        )
```

------------------------------------------------------------------------

## Solution 2 --- NumPy

``` python
import numpy as np


def create_water_temperature_array(
    values: list
) -> np.ndarray:

    return np.asarray(
        values,
        dtype=np.float64
    ).reshape(-1)


def validate_water_temperature_array(
    arr: np.ndarray
) -> bool:

    if arr.size == 0:
        return False

    if not np.issubdtype(
        arr.dtype,
        np.number
    ):
        return False

    return bool(
        np.all(
            (arr >= 12.0)
            & (arr <= 30.0)
        )
    )


def compute_water_temperature_stats(
    arr: np.ndarray
) -> tuple:

    return (
        round(float(np.mean(arr)), 2),
        round(float(np.std(arr)), 2),
        round(float(np.max(arr)), 2),
        round(float(np.min(arr)), 2)
    )


def categorize_water_temperatures(
    arr: np.ndarray
) -> np.ndarray:

    return np.select(
        [
            (arr >= 12.0)
            & (arr <= 18.0),

            (arr > 18.0)
            & (arr <= 26.0),

            (arr > 26.0)
            & (arr <= 30.0)
        ],
        [
            "Cold",
            "Optimal",
            "Warm"
        ],
        default="Invalid"
    )


def longest_warm_streak(
    arr: np.ndarray
) -> int:

    current = 0
    longest = 0

    for value in arr:

        if 26.0 < value <= 30.0:
            current += 1

            longest = max(
                longest,
                current
            )

        else:
            current = 0

    return longest
```

------------------------------------------------------------------------

## Solution 3 --- Python OOP

``` python
class LibraryLoanRegistry:

    def __init__(self):
        self.loans = {}

    def register_loan(
        self,
        loan_id: str,
        book_title: str,
        member_name: str
    ) -> dict:

        if loan_id in self.loans:
            raise ValueError(
                "Loan already registered"
            )

        self.loans[loan_id] = {
            "book_title": book_title,
            "member_name": member_name,
            "status": "On Loan"
        }

        return self.loans

    def change_member(
        self,
        loan_id: str,
        new_member_name: str
    ) -> dict:

        if loan_id not in self.loans:
            raise KeyError(
                "Loan not found"
            )

        self.loans[loan_id][
            "member_name"
        ] = new_member_name

        return self.loans

    def get_loan_details(
        self,
        loan_id: str
    ) -> dict:

        if loan_id not in self.loans:
            raise KeyError(
                "Loan not found"
            )

        return self.loans[loan_id]

    def loans_by_member(
        self,
        member_name: str
    ) -> list:

        return [
            loan_id
            for loan_id, details
            in self.loans.items()
            if details["member_name"]
            == member_name
        ]
```

------------------------------------------------------------------------

## Solution 4 --- SQL AVG Window

``` sql
SELECT
    r.route_name,
    dr.driver_name,
    d.delivery_time,

    ROUND(
        AVG(d.delivery_time) OVER (
            PARTITION BY d.route_id
        ),
        2
    ) AS avg_route_time

FROM Deliveries AS d

JOIN Routes AS r
    ON d.route_id = r.route_id

JOIN Drivers AS dr
    ON d.driver_id = dr.driver_id

WHERE d.status = 'Completed'

ORDER BY
    r.route_name,
    d.delivery_time,
    dr.driver_name;
```

### Logic

``` text
JOIN
  ↓
Get route + driver names

WHERE
  ↓
Keep completed rows

AVG() OVER
  ↓
Calculate route average
without collapsing delivery rows

ROUND
  ↓
2 decimals

ORDER BY
  ↓
Required final order
```

------------------------------------------------------------------------

## Solution 5 --- SQL LAG

``` sql
WITH ordered_appointments AS (

    SELECT
        p.patient_name,
        a.appointment_id,
        a.appointment_date,

        LAG(
            a.appointment_date
        ) OVER (
            PARTITION BY a.patient_id
            ORDER BY
                a.appointment_date,
                a.appointment_id
        ) AS previous_appointment_date

    FROM Appointments AS a

    JOIN Patients AS p
        ON a.patient_id = p.patient_id
)

SELECT
    patient_name,
    appointment_id,
    appointment_date,

    DATEDIFF(
        appointment_date,
        previous_appointment_date
    ) AS days_since_previous_appointment

FROM ordered_appointments

ORDER BY
    patient_name,
    appointment_date,
    appointment_id;
```

### Logic

``` text
JOIN
  ↓
Get patient name

PARTITION BY
  ↓
Separate each patient

ORDER BY
  ↓
Establish appointment sequence

LAG()
  ↓
Get previous appointment date

DATEDIFF()
  ↓
Calculate day gap

ORDER BY
  ↓
Final presentation
```

------------------------------------------------------------------------

# 29. The Most Important Lesson

Do not memorize complete solutions.

Memorize the **translation process**:

``` text
QUESTION
   ↓
Identify the noun
   ↓
Identify the action
   ↓
Identify the condition
   ↓
Identify the grouping/window
   ↓
Identify the output
   ↓
Check edge cases
```

For example:

> "Find the total usage for each equipment and keep equipment whose
> total is below a threshold."

Translate it into:

``` text
"each equipment"
        ↓
groupby EquipmentID

"total usage"
        ↓
sum UsageHours

"below threshold"
        ↓
< threshold

"sorted"
        ↓
sort_values()

"zero-based index"
        ↓
reset_index(drop=True)
```

That translation skill is much more valuable than memorizing code.

------------------------------------------------------------------------

# 30. One-Page Final Cheat Sheet

``` text
================ PYTHON / PANDAS ================

Create DataFrame       → pd.DataFrame()
Copy                   → df.copy()
Missing values         → notna() / isna()
Allowed values         → isin()
Filter                 → Boolean conditions
Select rows/columns    → loc[]
Group                  → groupby()
Total                  → sum()
Average                → mean()
Count                  → count()
Multiple aggregations  → agg()
Rename                 → rename()
Sort                   → sort_values()
Zero-based index       → reset_index(drop=True)
Round                  → round(2)
1/0 flag               → condition.astype(int)


================ NUMPY ===========================

Create array           → np.asarray()
Required float dtype   → dtype=np.float64
1-D                    → reshape(-1)
Empty                  → arr.size
Numeric dtype          → np.issubdtype()
All valid              → np.all()
Mean                   → np.mean()
Std                    → np.std()
Maximum                → np.max()
Minimum                → np.min()
Categories             → np.select()
Consecutive streak     → current + longest


================ OOP ==============================

Object state           → self.records = {}
Check exists           → key in dictionary
Check missing          → key not in dictionary
Insert                 → dictionary[key] = {...}
Update                 → dictionary[key]["field"] = value
Duplicate              → ValueError
Missing key            → KeyError
Search records         → .items() + list comprehension


================ SQL ==============================

Multiple tables        → JOIN
Filter rows            → WHERE
One row per group      → GROUP BY
Keep rows + group calc → WINDOW FUNCTION
Group average          → AVG() OVER(PARTITION BY ...)
Previous row           → LAG()
Next row               → LEAD()
Ranking                → ROW_NUMBER / RANK / DENSE_RANK
Intermediate stage     → WITH / CTE
Date gap               → DATEDIFF() [MySQL]
Final sorting          → ORDER BY
```

## Final mindset

**Don't start with syntax. Start with the requirement.**

Once you can translate a question into:

``` text
CREATE
FILTER
GROUP
AGGREGATE
TRANSFORM
COMPARE
WINDOW
SORT
RETURN
```

the correct function or SQL feature becomes much easier to identify.
