# **Problem 3**

## **W3 : Finding The Most Recent Purchase For Each SmartMart Customer**

### **📌 Problem Statement**

SmartMart wants to analyze recent customer purchasing activity by identifying the **most recent purchase made by each customer**.

The query should retrieve the **customer name, purchase date, and purchase amount**, ensuring that only the latest purchase for each customer is included in the result.

This analysis will help SmartMart understand each customer's latest shopping activity and identify when customers last made a purchase.

---

## **📌 Schema Details**

**Database: SmartMartDB**

**Customers Table**

| Column Name | Data Type | Description |
| ----- | ----- | ----- |
| customer_id | INT (PK) | Unique identifier for each customer |
| customer_name | VARCHAR(100) | Name of the customer |
| city | VARCHAR(50) | Customer's city |

**Purchases Table**

| Column Name | Data Type | Description |
| ----- | ----- | ----- |
| purchase_id | INT (PK) | Unique purchase identifier |
| customer_id | INT (FK) | Customer who made the purchase |
| purchase_date | DATE | Date when the purchase was made |
| purchase_amount | DECIMAL(10,2) | Total amount of the purchase |

---

# **📌 Sample Data**

**Customers Table**

| customer_id | customer_name | city |
| ----- | ----- | ----- |
| 101 | Rahul | Bangalore |
| 102 | Priya | Chennai |
| 103 | Arjun | Hyderabad |
| 104 | Sneha | Pune |

**Purchases Table**

| purchase_id | customer_id | purchase_date | purchase_amount |
| ----- | ----- | ----- | ----- |
| 5001 | 101 | 2025-01-10 | 1250.00 |
| 5002 | 101 | 2025-02-15 | 1850.00 |
| 5003 | 101 | 2025-03-20 | 2200.00 |
| 5004 | 102 | 2025-01-05 | 950.00 |
| 5005 | 102 | 2025-02-25 | 1750.00 |
| 5006 | 103 | 2025-01-18 | 3200.00 |
| 5007 | 103 | 2025-03-12 | 2800.00 |
| 5008 | 103 | 2025-04-05 | 4500.00 |
| 5009 | 104 | 2025-02-10 | 1500.00 |
| 5010 | 104 | 2025-03-30 | 2100.00 |

---

# **📌 Query to be Implemented**

Retrieve the **most recent purchase for each SmartMart customer** using a **single SQL query**.

The solution must ensure:

* Each customer's latest purchase is correctly identified.  
* Only the latest purchase of each customer is returned.  
* The result should contain:  
  * `customer_name`  
  * `purchase_date`  
  * `purchase_amount`

### **💡 Tip**

> **Join both tables and use a correlated subquery with `MAX()` to find each customer's latest `purchase_date`.**

---

# **📌 Expected Output**

| customer_name | purchase_date | purchase_amount |
| ----- | ----- | ----- |
| Rahul | 2025-03-20 | 2200.00 |
| Priya | 2025-02-25 | 1750.00 |
| Arjun | 2025-04-05 | 4500.00 |
| Sneha | 2025-03-30 | 2100.00 |

# ---

## **🎯 SQL Concept Being Tested**

 

