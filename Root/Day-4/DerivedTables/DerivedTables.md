

1. **How many units of each product were sold?**  
2. **Which customers purchased that product?**

**“build the answer in layers”** exercise.

### **1\. Start with the business question**

Ask 

**“For every product, show the total quantity sold and the customers who purchased that product.”**

Expected output:

| product\_name | total\_quantity\_sold | customer\_name |
| ----- | ----- | ----- |
| Laptop | 15 | Arun |
| Laptop | 15 | Priya |
| Mouse | 30 | Arun |
| Mouse | 30 | Ravi |

Immediately point out:

> **Notice that `total_quantity_sold` is product-level, while `customer_name` is customer-level.**

That observation is the key to understanding the query.

---

## **2\. First solve ONLY the product-level question**

Ask:

> **“Forget customers. How do we calculate total quantity sold for each product?”**

Start with:

SELECT  
   product\_id,  
   SUM(quantity) AS total\_quantity\_sold  
FROM Order\_Items  
GROUP BY product\_id;

Explain the grain:

Order\_Items  
    ↓  
GROUP BY product\_id  
    ↓  
ONE ROW PER PRODUCT

Example:

| product\_id | total\_quantity\_sold |
| ----- | ----- |
| 101 | 15 |
| 102 | 30 |
| 103 | 8 |

Tell trainees:

> **This is our derived table. It answers: “How much of each product was sold?”**

---

# **3\. Give the derived table a name**

Now introduce:

SELECT  
   p.name AS product\_name,  
   tq.total\_quantity\_sold  
FROM Products p  
JOIN (  
   SELECT  
       product\_id,  
       SUM(quantity) AS total\_quantity\_sold  
   FROM Order\_Items  
   GROUP BY product\_id  
) tq  
   ON p.product\_id \= tq.product\_id;

Explain the purpose of the join:

Products  
  product\_id  
      │  
      │  
      ▼  
total\_quantity\_sold

The subquery knows:

product\_id → total quantity

But it doesn't know the **product name**.

So we join it with `Products`.

---

# **4\. Now introduce the second question**

Ask:

> **“We know the product and its total quantity. How do we find which customers purchased it?”**

Start from:

Product  
  ↓  
Order\_Items  
  ↓  
Orders  
  ↓  
Customers

Why?

### **Product → Order\_Items**

p.product\_id \= oi.product\_id

This tells us:

> Which order items belong to this product?

### **Order\_Items → Orders**

oi.order\_id \= o.order\_id

Now we know:

> Which order contained that product?

### **Orders → Customers**

o.customer\_id \= c.customer\_id

Now we know:

> Who placed that order?

So the relationship becomes:

Products  
  │  
  │ product\_id  
  ▼  
Order\_Items  
  │  
  │ order\_id  
  ▼  
Orders  
  │  
  │ customer\_id  
  ▼  
Customers

This visual is extremely useful for trainees.

---

# **5\. Build that part separately**

write:

SELECT  
   p.name AS product\_name,  
   c.name AS customer\_name  
FROM Products p  
JOIN Order\_Items oi  
   ON p.product\_id \= oi.product\_id  
JOIN Orders o  
   ON oi.order\_id \= o.order\_id  
JOIN Customers c  
   ON o.customer\_id \= c.customer\_id;

Now we understand:

product\_name → customer\_name

Example:

| product\_name | customer\_name |
| ----- | ----- |
| Laptop | Arun |
| Laptop | Priya |
| Mouse | Arun |
| Mouse | Ravi |

---

# **6\. Now combine the two answers**

At this point tell them:

> **We have two separate answers. Let's combine them.**

### **Answer A**

Product → Total Quantity

### **Answer B**

Product → Customer

The common key is:

product\_id

Therefore:

Products p

JOIN total\_quantity tq  
   ON p.product\_id \= tq.product\_id

JOIN Order\_Items oi  
   ON p.product\_id \= oi.product\_id

JOIN Orders o  
   ON oi.order\_id \= o.order\_id

JOIN Customers c  
   ON o.customer\_id \= c.customer\_id  
---

# **7\. Explain the most confusing part: repeated totals**

This is where trainees usually ask:

> **“Why is the total quantity repeated for every customer?”**

Suppose:

Laptop \= 15 units sold

and:

Laptop was purchased by:  
Arun  
Priya  
Ravi

The result becomes:

| Product | Total Sold | Customer |
| ----- | ----- | ----- |
| Laptop | 15 | Arun |
| Laptop | 15 | Priya |
| Laptop | 15 | Ravi |

Explain:

> `15` is **not customer-level data**. It is product-level data. Since the final result contains one row per product/customer combination, the product-level value appears on every matching customer row.

This is a very important **grain concept** to teach.

---

# **8\. Then explain the `GROUP BY`**

The final query has:

GROUP BY  
   p.name,  
   tq.total\_quantity\_sold,  
   c.name

Ask:

> **“Are we actually calculating anything in the outer query?”**

Answer:

**No.**

There is no:

SUM()  
COUNT()  
AVG()  
MAX()  
MIN()

in the outer query.

So the `GROUP BY` is not really needed for aggregation.

It is essentially being used to collapse duplicate rows.

In many cases, this can be expressed more clearly with:

SELECT DISTINCT  
   p.name AS product\_name,  
   tq.total\_quantity\_sold,  
   c.name AS customer\_name

instead of:

GROUP BY  
   p.name,  
   tq.total\_quantity\_sold,  
   c.name

For teaching, I would actually show trainees **both versions** and ask:

> **“Which one communicates the intention better?”**

For this particular query, `DISTINCT` is arguably clearer because the goal is not aggregation in the outer query.

---

# **9\. Teach the query using "grain"**

This is probably the **most valuable lesson** hidden inside this query.

Tell trainees to ask this question before writing SQL:

> **“What does one row in my final result represent?”**

Here:

ONE ROW \= ONE PRODUCT \+ ONE CUSTOMER

But:

total\_quantity\_sold

has a different grain:

ONE ROW \= ONE PRODUCT

Therefore:

Product-level data  
       \+  
Customer-level data  
       ↓  
Product \+ Customer level

This explains why the total gets repeated.

---

# **10\. A very effective classroom approach**

I would write this on the board:

BUSINESS QUESTION  
       ↓  
What is the final grain?  
       ↓  
Product \+ Customer  
       ↓  
What information do we need?  
       ↓  
1\. Product total quantity  
2\. Customer who purchased product  
       ↓  
Solve each independently  
       ↓  
Combine using product\_id

Then give them this decomposition:

PART 1  
product\_id → total\_quantity

PART 2  
product\_id → customer

COMBINE

product\_id  
   ↓  
product\_name  
total\_quantity  
customer\_name  
---

## **11\. Finally show the complete query**

SELECT  
   p.name AS product\_name,  
   tq.total\_quantity\_sold,  
   c.name AS customer\_name  
FROM Products p

JOIN (  
   SELECT  
       product\_id,  
       SUM(quantity) AS total\_quantity\_sold  
   FROM Order\_Items  
   GROUP BY product\_id  
) tq  
   ON p.product\_id \= tq.product\_id

JOIN Order\_Items oi  
   ON p.product\_id \= oi.product\_id

JOIN Orders o  
   ON oi.order\_id \= o.order\_id

JOIN Customers c  
   ON o.customer\_id \= c.customer\_id

GROUP BY  
   p.name,  
   tq.total\_quantity\_sold,  
   c.name

ORDER BY  
   p.name,  
   c.name;

### **The one sentence I would want trainees to remember**

> **“When a query looks complicated, first identify the grain of the final result, then solve each required piece independently, and finally join the pieces using the common key.”**

That teaching pattern will also help them with **nested subqueries, derived tables, window functions, and multi-table joins**.

