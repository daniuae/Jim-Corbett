# **  – Library Lending Analyzer**

## **Class**

class LibraryLendingAnalyzer:

### **Methods**

| Method | Input | Output | Purpose |
| ----- | ----- | ----- | ----- |
| `create_lending_df()` | `list` | `DataFrame` | Converts list into DataFrame |
| `compute_monthly_return_rate()` | `DataFrame` | `DataFrame` | Calculates monthly return percentage |
| `add_overdue_flag()` | `DataFrame` | `DataFrame` | Creates 0/1 overdue flag |
| `high_overdue_members()` | `DataFrame`, `int` | `DataFrame` | Finds members above overdue threshold |
| `category_lending_summary()` | `DataFrame` | `DataFrame` | Creates category/status summary |

---

# **`create_lending_df()`**

def create\_lending\_df(  
    self,  
    data: list  
) \-\> pd.DataFrame:

### **Main function**

pd.DataFrame()

Creates a Pandas DataFrame.

Pattern:

columns \= \["MemberID", "Category", "Date", "Status"\]

df \= pd.DataFrame(  
    data,  
    columns=columns  
)

### **Pattern**

List  
 ↓  
pd.DataFrame()  
 ↓  
DataFrame  
---

# **`compute_monthly_return_rate()`**

This is the **most important Q330 method** because it combines several Pandas operations.

### **1\. `copy()`**

df \= df.copy()

Creates a copy of the DataFrame.

---

### **2\. `.str[:7]`**

df\["Month"\] \= df\["Date"\].str\[:7\]

Extracts:

2024-06-15

into:

2024-06  
---

### **3\. `groupby()`**

df.groupby(\["MemberID", "Month"\])

Groups data by member and month.

---

### **4\. `size()`**

.size()

Counts records in each group.

---

### **5\. `reset_index()`**

.reset\_index(name="Total")

Converts the grouped result back into a DataFrame.

---

### **6\. Filtering**

df\[df\["Status"\] \== "Returned"\]

Selects only returned records.

---

### **7\. `merge()`**

total.merge(  
    returned,  
    on=\["MemberID", "Month"\],  
    how="left"  
)

Combines total and returned counts.

---

### **8\. `fillna()`**

result\["Returned"\] \= result\["Returned"\].fillna(0)

Replaces missing values with `0`.

---

### **9\. Percentage calculation**

(result\["Returned"\] / result\["Total"\]) \* 100

Calculates:

Return Rate \=  
Returned / Total × 100  
---

# **`add_overdue_flag()`**

### **Main pattern**

(df\["Status"\] \== "Overdue").astype(int)

First:

df\["Status"\] \== "Overdue"

produces:

True  
False  
True

Then:

.astype(int)

converts:

True  → 1  
False → 0

### **Pattern**

Condition  
 ↓  
True / False  
 ↓  
astype(int)  
 ↓  
1 / 0  
---

# **`high_overdue_members()`**

### **Operations used**

#### **Filter**

df\[df\["Status"\] \== "Overdue"\]

#### **Group**

.groupby("MemberID")

#### **Count**

.size()

#### **Convert to DataFrame**

.reset\_index(name="Overdue Count")

#### **Apply threshold**

result\[result\["Overdue Count"\] \> threshold\]

### **Pattern**

Filter  
 ↓  
GroupBy  
 ↓  
Count  
 ↓  
Threshold  
 ↓  
Result  
---

# **`category_lending_summary()`**

This method introduces an important Pandas function:

## **`pd.crosstab()`**

pd.crosstab(  
    df\["Category"\],  
    df\["Status"\]  
)

It creates a frequency table.

Example:

Status      Borrowed  Returned  Overdue  
Category  
Fiction          3         2        1  
Science          2         3        0

### **`reindex()`**

result.reindex(  
    columns=\["Borrowed", "Returned", "Overdue"\],  
    fill\_value=0  
)

Ensures the required columns exist and missing values are represented as `0`.

### **`reset_index()`**

result.reset\_index()

Converts the index back into a normal column.

---

# **🔥 Consolidated Python Functions**

| Function | Used In | Purpose |
| ----- | ----- | ----- |
| `lower()` | Q331 | Convert text to lowercase |
| `re.sub()` | Q331 | Remove punctuation |
| `split()` | Q331 | Convert text into words |
| `get()` | Q331 | Safely retrieve dictionary value |
| `max()` | Q331 | Find maximum-frequency word |
| `lambda` | Q331 | Define comparison logic |
| `items()` | Q331 | Iterate through dictionary key/value pairs |
| `pd.DataFrame()` | Q330 | Create DataFrame |
| `copy()` | Q330 | Copy DataFrame |
| `.str[:7]` | Q330 | Extract year-month |
| `groupby()` | Q330 | Group records |
| `size()` | Q330 | Count records |
| `reset_index()` | Q330 | Restore DataFrame index |
| `merge()` | Q330 | Combine DataFrames |
| `fillna()` | Q330 | Replace missing values |
| `astype(int)` | Q330 | Convert Boolean to 0/1 |
| `pd.crosstab()` | Q330 | Create frequency summary |
| `reindex()` | Q330 | Select/order columns and fill missing ones |

---

# **🧠 Ultimate Cheat Sheet**

                Q331  
                  │  
          Customer Sentiment  
                  │  
       ┌──────────┼──────────┐  
       ↓          ↓          ↓  
    String      List      Dictionary  
       │          │          │  
    lower()     split()     get()  
    re.sub()     for        items()  
                              │  
                             max()  
                              │  
                            lambda  
                Q330  
                  │  
           Library Lending  
                  │  
                  ↓  
             DataFrame  
                  │  
       ┌──────────┼───────────┐  
       ↓          ↓           ↓  
    groupby     filter      crosstab  
       │          │           │  
     size()      \[\]        reindex()  
       │                      │  
   reset\_index()         fill\_value=0  
       │  
     merge()  
       │  
    fillna()  
       │  
  calculation

## **⭐ What to Memorize for the Assessment**

If you have limited time, focus on these **10 patterns**:

text.lower()

re.sub(r'\[^\\w\\s\]', '', text)

text.split()

d.get(key, 0\) \+ 1

max(d, key=lambda x: d\[x\])

d.items()

pd.DataFrame(data, columns=columns)

df.groupby(...).size()

df\[df\["column"\] \== "value"\]

pd.crosstab(df\["column1"\], df\["column2"\])

These cover a large portion of the actual programming logic required by **both Q331 and Q330**.

