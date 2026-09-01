# ---

# 10 Scenario-Based Pandas Problems

---

### **Common Problem-Solving Framework**

For every problem, ask:

BUSINESS QUESTION  
        ↓  
WHAT DATA DO I NEED?  
        ↓  
WHICH COLUMNS?  
        ↓  
FILTER?  
        ↓  
JOIN?  
        ↓  
TRANSFORMATION?  
        ↓  
GROUP BY?  
        ↓  
AGGREGATION?  
        ↓  
WINDOW / RANK?  
        ↓  
FINAL OUTPUT  
---

## **1\. 🛒 E-Commerce — High-Value Customers**

You are working with an e-commerce company.

You have an `orders` DataFrame:

order\_id  
customer\_id  
order\_date  
product\_id  
quantity  
unit\_price

### **Business Requirement**

Management wants to identify **high-value customers**.

A customer's total spending is:

quantity × unit\_price

Find customers whose **total spending is greater than ₹100,000**.

### **Expected Output**

customer\_id  
total\_spending

Sort from highest to lowest spending.

### **Concepts tested**

* Creating calculated columns  
* `groupby()`  
* `sum()`  
* Filtering aggregated results  
* `sort_values()`

---

# **2\. 🏦 Banking — Suspicious Transactions**

A bank provides a `transactions` DataFrame:

transaction\_id  
customer\_id  
transaction\_date  
transaction\_type  
amount  
city

### **Business Requirement**

Find customers who have:

* at least **3 transactions**  
* with each transaction amount greater than **₹50,000**

### **Expected Output**

customer\_id  
transaction\_count  
total\_amount

Sort by `total_amount` descending.

### **Concepts tested**

* Boolean filtering  
* `groupby()`  
* Multiple aggregations  
* `reset_index()`  
* Sorting

---

# **3\. 📦 Logistics — Delayed Deliveries**

You have a `deliveries` DataFrame:

delivery\_id  
customer\_id  
order\_date  
expected\_date  
actual\_delivery\_date  
delivery\_status

### **Business Requirement**

The operations team wants to know which deliveries were late.

Create:

delay\_days

where:

delay\_days \=  
actual\_delivery\_date \- expected\_date

Then find:

> Customers whose **average delivery delay is more than 3 days**.

### **Expected Output**

customer\_id  
average\_delay

Sort by highest average delay.

### **Concepts tested**

* `pd.to_datetime()`  
* Date subtraction  
* Creating calculated columns  
* `groupby()`  
* `mean()`  
* Filtering

---

# **4\. 👥 Customer Data — Duplicate Customers**

A company has a customer master DataFrame:

customer\_id  
customer\_name  
email  
phone  
city  
updated\_at

The data contains duplicate records because customers may have been updated multiple times.

### **Business Requirement**

For every `customer_id`, keep **only the most recently updated record**.

### **Expected Output**

One record per customer:

customer\_id  
customer\_name  
email  
phone  
city  
updated\_at

### **Concepts tested**

* Sorting  
* `sort_values()`  
* `drop_duplicates()`  
* `keep="last"`

### **⭐ Data Engineering angle**

This is a very common **deduplication / latest-record** pattern.

---

# **5\. 🏪 Retail — Best-Selling Products by Category**

You have:

### **`products`**

product\_id  
product\_name  
category

### **`sales`**

sale\_id  
product\_id  
quantity  
sale\_amount

### **Business Requirement**

Find the **best-selling product in every category** based on total quantity sold.

### **Expected Output**

category  
product\_name  
total\_quantity

### **Concepts tested**

* `merge()`  
* `groupby()`  
* `sum()`  
* Sorting  
* Ranking / top-N logic

### **⭐ Challenge**

If two products have the same quantity, return **both products**.

---

# **6\. 💳 Credit Card — Customer Spending Trend**

You have:

customer\_id  
transaction\_date  
amount

### **Business Requirement**

Calculate each customer's:

1. Monthly spending  
2. Previous month's spending  
3. Month-over-month change

### **Expected Output**

customer\_id  
month  
monthly\_spending  
previous\_month\_spending  
change

For example:

customer\_id | month | monthly\_spending | previous\_month | change  
101         | Jan   | 50000            | NaN            | NaN  
101         | Feb   | 65000            | 50000          | 15000  
101         | Mar   | 55000            | 65000          | \-10000

### **Concepts tested**

* Datetime  
* Month extraction  
* `groupby()`  
* `sum()`  
* `shift()`  
* `diff()`

---

# **7\. 📊 Sales — Employee Performance Against Team Average**

You have:

employee\_id  
employee\_name  
department  
sales

### **Business Requirement**

For every employee, calculate:

department\_average\_sales

Then identify employees whose sales are **greater than their department's average**.

### **Expected Output**

employee\_id  
employee\_name  
department  
sales  
department\_average\_sales

### **Concepts tested**

* `groupby()`  
* `transform("mean")`  
* Boolean filtering

### **⭐ Important**

Do **not** reduce the DataFrame using `groupby().agg()`.

You need to retain every employee row.

---

# **8\. 📈 Sales — Top 3 Employees in Every Department**

You have:

employee\_id  
employee\_name  
department  
sales

### **Business Requirement**

Management wants the **top 3 sales performers in every department**.

Expected output:

department  
employee\_id  
employee\_name  
sales  
rank

Example:

IT       Ravi     950000    1  
IT       Priya    900000    2  
IT       Arun     850000    3  
HR       Kumar    700000    1  
HR       Meena    650000    2  
HR       John     600000    3

### **Concepts tested**

* `groupby()`  
* `rank()`  
* Partitioning by groups  
* Sorting  
* Top-N per group

### **⭐ SQL connection**

Think:

RANK() OVER (  
    PARTITION BY department  
    ORDER BY sales DESC  
)  
---

# **9\. 🚚 Logistics — Running Shipment Volume**

You have:

shipment\_id  
customer\_id  
shipment\_date  
quantity

### **Business Requirement**

For every customer, calculate the **running total of quantity shipped** over time.

### **Expected Output**

customer\_id  
shipment\_date  
quantity  
running\_quantity

Example:

Customer 101

Date          Quantity     Running Quantity  
01-Jan        100          100  
05-Jan        200          300  
10-Jan        150          450  
20-Jan        300          750

### **Concepts tested**

* Sorting  
* `groupby()`  
* `cumsum()`  
* Time-series processing

### **⭐ SQL connection**

Think:

SUM(quantity) OVER (  
    PARTITION BY customer\_id  
    ORDER BY shipment\_date  
)  
---

# **10\. 🏢 Data Engineering — Build a Customer 360 Dataset ⭐⭐⭐**

This is the **capstone problem**.

You have three DataFrames.

### **`customers`**

customer\_id  
customer\_name  
city  
signup\_date

### **`orders`**

order\_id  
customer\_id  
order\_date  
quantity  
amount

### **`payments`**

payment\_id  
customer\_id  
payment\_date  
payment\_amount

### **Business Requirement**

Create a **Customer 360** dataset containing:

customer\_id  
customer\_name  
city  
total\_orders  
total\_quantity  
total\_spending  
total\_payments  
last\_order\_date

Then identify customers who:

total\_spending \> 100000

and

total\_payments \< total\_spending

These customers should be flagged as:

"Payment Pending"

Otherwise:

"Paid"

### **Expected Output**

customer\_id  
customer\_name  
city  
total\_orders  
total\_quantity  
total\_spending  
total\_payments  
last\_order\_date  
payment\_status

### **Concepts tested ⭐⭐⭐**

This single problem tests almost everything:

READ DATA  
   ↓  
INSPECT  
   ↓  
CLEAN  
   ↓  
AGGREGATE ORDERS  
   ↓  
AGGREGATE PAYMENTS  
   ↓  
MERGE  
   ↓  
HANDLE NULLS  
   ↓  
CREATE BUSINESS RULE  
   ↓  
FILTER  
   ↓  
SORT  
   ↓  
FINAL DATASET  
---

# **🎯 Difficulty Progression**

| Problem | Scenario | Difficulty |
| ----- | ----- | ----- |
| 1 | E-Commerce | ⭐⭐ |
| 2 | Banking | ⭐⭐ |
| 3 | Logistics Dates | ⭐⭐⭐ |
| 4 | Deduplication | ⭐⭐⭐ |
| 5 | Best Product | ⭐⭐⭐ |
| 6 | Monthly Trend | ⭐⭐⭐⭐ |
| 7 | Team Average | ⭐⭐⭐⭐ |
| 8 | Top 3 per Department | ⭐⭐⭐⭐ |
| 9 | Running Total | ⭐⭐⭐⭐ |
| 10 | Customer 360 | ⭐⭐⭐⭐⭐ |

### **Recommended teaching sequence**

I would use these in this order:

1 → Filtering \+ GroupBy  
2 → Multiple Conditions \+ Aggregation  
3 → Dates  
4 → Data Cleaning  
5 → Merge \+ GroupBy  
6 → Time Series \+ Shift  
7 → Transform  
8 → Rank  
9 → Cumulative Window  
10 → End-to-End Data Engineering

---

