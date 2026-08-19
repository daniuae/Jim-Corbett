The query has **3 logical layers**:

1\. Main tables → customers \+ orders  
2\. GROUP BY \+ SUM → calculate spending per customer  
3\. HAVING \+ subquery → keep customers whose spending \> average order amount

### **Step 1 — Understand the subquery first**

Start with the innermost part:

SELECT AVG(total\_amount)  
FROM orders;

Question:

> **What question does this query answer?**

Answer:

> "What is the average order amount across all orders?"

For example:

orders

Order    Amount  
101      1000  
102      2000  
103      3000  
104      4000

The subquery produces:

Average \= 2500

So mentally replace the subquery:

HAVING SUM(o.total\_amount) \> 2500

---

## **Step 2 — Understand the JOIN**

Now look at:

FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id

Question:

> **Why do we need the JOIN?**

Because we need:

customers → customer name  
orders    → order amount

The relationship is:

customers  
   |  
   | customer\_id  
   ↓  
orders

So:

c.customer\_id \= o.customer\_id

means:

> Match each order to the customer who placed it.

---

## **Step 3 — Understand `SUM()`**

Now look at:

SELECT  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent

Ask:

> **What are we calculating?**

We are calculating:

> **How much money did each customer spend in total?**

Example:

Customer   Orders  
Arun       1000 \+ 2000 \+ 3000  
Priya      500 \+ 700

After `SUM()`:

Arun    → 6000  
Priya   → 1200  
---

## **Step 4 — Why `GROUP BY`?**

Now show:

GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name

Ask:

> **SUM of what?**

We want:

SUM per customer

Therefore SQL needs to know:

> "Group all orders belonging to the same customer."

So:

Customer 1 → Order 101  
         → Order 102  
         → Order 105

Customer 2 → Order 103  
           → Order 104

Then:

SUM(o.total\_amount)

is calculated separately for each customer.

---

# **Step 5 — Now explain HAVING**

This is where trainees often get confused.

HAVING SUM(o.total\_amount) \> (...)

Ask:

> **When do we want to filter?**

We want to filter **after calculating the SUM**.

For example:

Arun    → 6000  
Priya   → 1200  
Ravi    → 4000

If average order amount is:

2500

then:

Arun   → 6000 \> 2500 → YES  
Priya  → 1200 \> 2500 → NO  
Ravi   → 4000 \> 2500 → YES

Result:

Arun  
Ravi  
---

# **Step 6 — Put the subquery back**

Initially we simplified:

HAVING SUM(o.total\_amount) \> 2500

But where did `2500` come from?

From:

SELECT AVG(total\_amount)  
FROM orders

Therefore:

HAVING SUM(o.total\_amount) \>  
(  
   SELECT AVG(total\_amount)  
   FROM orders  
)

means:

> **Show customers whose total spending is greater than the average value of an order.**

---

# **The complete teaching flow**

I would present the query to trainees in this exact order:

                   SUBQUERY  
                      ↓  
            Average order amount  
                      ↓  
                 JOIN TABLES  
                      ↓  
            Customer \+ Orders  
                      ↓  
                   GROUP BY  
                      ↓  
            Total per customer  
                      ↓  
                   HAVING  
                      ↓  
       Total customer spending  
            \>  
       Average order amount

### **Finally, read the entire query as English**

SELECT c.first\_name, c.last\_name,  
      SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY c.customer\_id,  
        c.first\_name,  
        c.last\_name  
HAVING SUM(o.total\_amount) \>  
(  
   SELECT AVG(total\_amount)  
   FROM orders  
);

**English translation:**

> "Find each customer's total spending by joining customers with their orders. Group the orders customer-wise. Then show only those customers whose total spending is greater than the average order amount."

### **One important teaching distinction**

Tell your trainees:

WHERE  → filters individual rows BEFORE GROUP BY

HAVING → filters groups AFTER GROUP BY

Here we need `HAVING` because:

SUM(o.total\_amount)

is an **aggregate calculation** performed for each customer.

