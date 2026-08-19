# **1\. ROW\_NUMBER()**

### **Question**

> Give every payment a sequential number.

SELECT  
   payment\_id,  
   order\_id,  
   amount,  
   ROW\_NUMBER() OVER (  
       ORDER BY payment\_date  
   ) AS row\_num  
FROM payments;

Explain:

ROW\_NUMBER()  
    ↓  
Assigns a unique sequence  
    ↓  
Based on payment\_date  
---

# **2\. ROW\_NUMBER() with PARTITION BY**

### **Question**

> Number payments separately for each payment method.

SELECT  
   payment\_id,  
   payment\_method,  
   amount,  
   ROW\_NUMBER() OVER (  
       PARTITION BY payment\_method  
       ORDER BY amount DESC  
   ) AS payment\_rank  
FROM payments;

Example concept:

UPI  
 1  
 2  
 3  
 4

CREDIT\_CARD  
 1  
 2  
 3

The numbering **restarts for every payment method**.

---

# **3\. RANK()**

### **Question**

> Rank payments from highest amount to lowest amount.

SELECT  
   payment\_id,  
   amount,  
   RANK() OVER (  
       ORDER BY amount DESC  
   ) AS payment\_rank  
FROM payments;  
---

# **4\. DENSE\_RANK()**

SELECT  
   payment\_id,  
   amount,  
   DENSE\_RANK() OVER (  
       ORDER BY amount DESC  
   ) AS payment\_rank  
FROM payments;

Teach the difference:

RANK()  
1  
2  
2  
4

DENSE\_RANK()  
1  
2  
2  
3  
---

# **5\. RANK() by payment method**

### **Question**

> Rank payments within each payment method.

SELECT  
   payment\_id,  
   payment\_method,  
   amount,

   RANK() OVER (  
       PARTITION BY payment\_method  
       ORDER BY amount DESC  
   ) AS method\_rank

FROM payments;

This is an excellent first example of:

PARTITION BY \+ ORDER BY \+ RANK  
---

# **6\. COUNT() OVER()**

### **Question**

> Show the total number of payments on every row.

SELECT  
   payment\_id,  
   amount,

   COUNT(\*) OVER () AS total\_payments

FROM payments;

Unlike:

SELECT COUNT(\*)  
FROM payments;

the window function **does not collapse the rows**.

---

# **7\. COUNT() by payment method**

### **Question**

> How many payments were made using each payment method?

SELECT  
   payment\_id,  
   payment\_method,  
   amount,

   COUNT(\*) OVER (  
       PARTITION BY payment\_method  
   ) AS method\_payment\_count

FROM payments;  
---

# **8\. SUM() OVER()**

### **Question**

> Display the total payment amount on every row.

SELECT  
   payment\_id,  
   amount,

   SUM(amount) OVER () AS total\_payment\_amount

FROM payments;  
---

# **9\. SUM() with PARTITION BY**

### **Question**

> Calculate total payment amount for each payment method.

SELECT  
   payment\_id,  
   payment\_method,  
   amount,

   SUM(amount) OVER (  
       PARTITION BY payment\_method  
   ) AS method\_total

FROM payments;

For example:

payment\_id   method        amount     method\_total  
\---------------------------------------------------  
501          UPI           76500      ...  
503          UPI            4000       ...  
505          UPI           20000      ...

Every UPI row gets the **same UPI total**.

---

# **10\. Running Total**

This is one of the most important window-function examples.

### **Question**

> Calculate cumulative payment amount over time.

SELECT  
   payment\_id,  
   payment\_date,  
   amount,

   SUM(amount) OVER (  
       ORDER BY payment\_date  
   ) AS running\_total

FROM payments;

Conceptually:

Payment 1 →  76,500  
Payment 2 → 141,000  
Payment 3 → 145,000  
Payment 4 → 152,500  
...  
---

# **11\. Running Total by Payment Method**

SELECT  
   payment\_id,  
   payment\_method,  
   payment\_date,  
   amount,

   SUM(amount) OVER (  
       PARTITION BY payment\_method  
       ORDER BY payment\_date  
   ) AS method\_running\_total

FROM payments;

This means:

> Start a new running total for every payment method.

---

# **12\. AVG() OVER()**

### **Question**

> Display the average payment amount on every row.

SELECT  
   payment\_id,  
   amount,

   AVG(amount) OVER () AS average\_payment

FROM payments;  
---

# **13\. AVG() by Payment Method**

SELECT  
   payment\_id,  
   payment\_method,  
   amount,

   AVG(amount) OVER (  
       PARTITION BY payment\_method  
   ) AS method\_average

FROM payments;  
---

# **14\. MIN() and MAX()**

### **Question**

> Show minimum and maximum payment amounts.

SELECT  
   payment\_id,  
   amount,

   MIN(amount) OVER () AS minimum\_payment,  
   MAX(amount) OVER () AS maximum\_payment

FROM payments;

Very simple and useful for beginners.

---

# **15\. LAG()**

### **Question**

> Show the previous payment amount.

SELECT  
   payment\_id,  
   payment\_date,  
   amount,

   LAG(amount) OVER (  
       ORDER BY payment\_date  
   ) AS previous\_payment

FROM payments;

Concept:

Current payment  
      ↓  
Look backward  
      ↓  
Previous payment  
---

# **16\. LEAD()**

### **Question**

> Show the next payment amount.

SELECT  
   payment\_id,  
   payment\_date,  
   amount,

   LEAD(amount) OVER (  
       ORDER BY payment\_date  
   ) AS next\_payment

FROM payments;

Concept:

Current payment  
      ↓  
Look forward  
      ↓  
Next payment  
---

# **17\. LAG() — Calculate Difference**

This is a very good real-world example.

SELECT  
   payment\_id,  
   payment\_date,  
   amount,

   LAG(amount) OVER (  
       ORDER BY payment\_date  
   ) AS previous\_payment,

   amount  
   \-  
   LAG(amount) OVER (  
       ORDER BY payment\_date  
   ) AS difference

FROM payments;

Business question:

> How much did the payment change compared with the previous payment?

---

# **18\. FIRST\_VALUE()**

### **Question**

> Show the first payment amount on every row.

SELECT  
   payment\_id,  
   payment\_date,  
   amount,

   FIRST\_VALUE(amount) OVER (  
       ORDER BY payment\_date  
   ) AS first\_payment

FROM payments;  
---

# **19\. LAST\_VALUE()**

For `LAST_VALUE()`, explicitly specify the window frame.

SELECT  
   payment\_id,  
   payment\_date,  
   amount,

   LAST\_VALUE(amount) OVER (  
       ORDER BY payment\_date  
       ROWS BETWEEN UNBOUNDED PRECEDING  
       AND UNBOUNDED FOLLOWING  
   ) AS last\_payment

FROM payments;

This is a good opportunity to explain:

> `LAST_VALUE()` depends on the window frame.

---

# **20\. NTILE()**

### **Question**

> Divide payments into 4 groups based on payment amount.

SELECT  
   payment\_id,  
   amount,

   NTILE(4) OVER (  
       ORDER BY amount DESC  
   ) AS payment\_quartile

FROM payments;

Concept:

Group 1 → Highest payments  
Group 2 → High payments  
Group 3 → Low payments  
Group 4 → Lowest payments  
---

# **21\. Window function with INVENTORY**

Now use your `inventory` table.

### **Question**

> Rank products based on inventory quantity.

SELECT  
   inventory\_id,  
   product\_id,  
   warehouse\_name,  
   quantity,

   RANK() OVER (  
       ORDER BY quantity DESC  
   ) AS inventory\_rank

FROM inventory;  
---

# **22\. Rank inventory within each warehouse**

This is much more useful.

SELECT  
   inventory\_id,  
   product\_id,  
   warehouse\_name,  
   quantity,

   RANK() OVER (  
       PARTITION BY warehouse\_name  
       ORDER BY quantity DESC  
   ) AS warehouse\_rank

FROM inventory;

Business question:

> Which product has the highest stock in each warehouse?

---

# **23\. Warehouse total inventory**

SELECT  
   inventory\_id,  
   product\_id,  
   warehouse\_name,  
   quantity,

   SUM(quantity) OVER (  
       PARTITION BY warehouse\_name  
   ) AS warehouse\_total\_stock

FROM inventory;  
---

# **24\. Warehouse average inventory**

SELECT  
   inventory\_id,  
   product\_id,  
   warehouse\_name,  
   quantity,

   AVG(quantity) OVER (  
       PARTITION BY warehouse\_name  
   ) AS warehouse\_average\_stock

FROM inventory;  
---

# **25\. Running inventory total**

SELECT  
   inventory\_id,  
   product\_id,  
   warehouse\_name,  
   quantity,

   SUM(quantity) OVER (  
       ORDER BY inventory\_id  
   ) AS running\_inventory

FROM inventory;  
---

# **26\. LAG() for inventory**

### **Question**

> Compare current stock with the previous inventory record.

SELECT  
   inventory\_id,  
   product\_id,  
   warehouse\_name,  
   quantity,

   LAG(quantity) OVER (  
       ORDER BY inventory\_id  
   ) AS previous\_quantity

FROM inventory;  
---

# **27\. Simple moving average**

SELECT  
   payment\_id,  
   payment\_date,  
   amount,

   AVG(amount) OVER (  
       ORDER BY payment\_date  
       ROWS BETWEEN 2 PRECEDING  
       AND CURRENT ROW  
   ) AS moving\_average

FROM payments;

Explain:

Current row  
\+  
Previous row  
\+  
2nd previous row  
\=  
3-row moving average  
---

# **28\. A very good "all basics in one query"**

Once trainees understand the individual functions, use this query:

SELECT  
   payment\_id,  
   payment\_date,  
   payment\_method,  
   amount,

   /\* Ranking \*/  
   ROW\_NUMBER() OVER (  
       ORDER BY amount DESC  
   ) AS row\_number,

   RANK() OVER (  
       ORDER BY amount DESC  
   ) AS payment\_rank,

   DENSE\_RANK() OVER (  
       ORDER BY amount DESC  
   ) AS dense\_payment\_rank,

   /\* Aggregation \*/  
   SUM(amount) OVER () AS total\_amount,

   AVG(amount) OVER () AS average\_amount,

   MIN(amount) OVER () AS minimum\_amount,

   MAX(amount) OVER () AS maximum\_amount,

   /\* Navigation \*/  
   LAG(amount) OVER (  
       ORDER BY payment\_date  
   ) AS previous\_amount,

   LEAD(amount) OVER (  
       ORDER BY payment\_date  
   ) AS next\_amount,

   /\* Running total \*/  
   SUM(amount) OVER (  
       ORDER BY payment\_date  
   ) AS running\_total

FROM payments

ORDER BY payment\_date;

This single query gives you:

                   WINDOW FUNCTIONS  
                         │  
       ┌─────────────────┼─────────────────┐  
       ↓                 ↓                 ↓  
    RANKING          AGGREGATION       NAVIGATION  
       │                 │                 │  
  ROW\_NUMBER()         SUM()             LAG()  
  RANK()               AVG()             LEAD()  
  DENSE\_RANK()         MIN()  
                       MAX()  
                         │  
                         ↓  
                   RUNNING TOTAL

