\# SmartMart SQL — Basic to Intermediate Complete Practice

\#\# Database

\`\`\`sql  
USE smartdb;  
---

# **1\. SQL FUNCTIONALITY MAP**

SMARTMART SQL  
│  
├── 01\. Database Operations  
│   ├── CREATE  
│   ├── USE  
│   └── DROP  
│  
├── 02\. Table Operations  
│   ├── CREATE TABLE  
│   ├── ALTER TABLE  
│   ├── RENAME  
│   └── DROP TABLE  
│  
├── 03\. Data Retrieval  
│   ├── SELECT  
│   ├── DISTINCT  
│   ├── Column aliases  
│   └── Expressions  
│  
├── 04\. Filtering  
│   ├── WHERE  
│   ├── AND  
│   ├── OR  
│   ├── NOT  
│   ├── IN  
│   ├── NOT IN  
│   ├── BETWEEN  
│   ├── LIKE  
│   ├── IS NULL  
│   └── IS NOT NULL  
│  
├── 05\. Sorting  
│   ├── ORDER BY ASC  
│   ├── ORDER BY DESC  
│   └── Multiple-column sorting  
│  
├── 06\. Limiting  
│   ├── LIMIT  
│   └── LIMIT \+ OFFSET  
│  
├── 07\. Aggregate Functions  
│   ├── COUNT  
│   ├── SUM  
│   ├── AVG  
│   ├── MIN  
│   └── MAX  
│  
├── 08\. GROUP BY  
│   ├── Single column  
│   ├── Multiple columns  
│   └── GROUP BY \+ JOIN  
│  
├── 09\. HAVING  
│   ├── HAVING \+ COUNT  
│   ├── HAVING \+ SUM  
│   ├── HAVING \+ AVG  
│   └── HAVING \+ JOIN  
│  
├── 10\. String Functions  
│   ├── CONCAT  
│   ├── UPPER  
│   ├── LOWER  
│   ├── LENGTH  
│   ├── SUBSTRING  
│   └── TRIM  
│  
├── 11\. Numeric Functions  
│   ├── ROUND  
│   ├── CEIL  
│   ├── FLOOR  
│   └── ABS  
---

# **2\. BASIC SELECT OPERATIONS**

## **2.1 Select All Columns**

SELECT \*  
FROM customers;

## **2.2 Select Specific Columns**

SELECT customer\_id,  
      first\_name,  
      last\_name  
FROM customers;

## **2.3 Select Product Information**

SELECT product\_id,  
      product\_name,  
      price  
FROM products;

## **2.4 Select Orders**

SELECT order\_id,  
      customer\_id,  
      order\_date,  
      total\_amount  
FROM orders;

## **2.5 Column Alias**

SELECT  
   product\_name AS product,  
   price AS product\_price  
FROM products;

## **2.6 Multiple Aliases**

SELECT  
   customer\_id AS id,  
   first\_name AS first\_name,  
   last\_name AS last\_name,  
   customer\_status AS status  
FROM customers;

## **2.7 Calculated Column**

SELECT  
   product\_name,  
   price,  
   price \* 0.18 AS gst  
FROM products;

## **2.8 Calculated Selling Price**

SELECT  
   product\_name,  
   price,  
   price \+ (price \* 0.18) AS price\_with\_gst  
FROM products;

## **2.9 Order Item Value**

SELECT  
   order\_id,  
   product\_id,  
   quantity,  
   unit\_price,  
   quantity \* unit\_price AS item\_value  
FROM order\_items;

## **2.10 Order Item Value After Discount**

SELECT  
   order\_id,  
   product\_id,  
   quantity,  
   unit\_price,  
   discount,  
   (quantity \* unit\_price) \- discount AS net\_value  
FROM order\_items;  
---

# **3\. DISTINCT**

## **3.1 Unique Customer Cities**

SELECT DISTINCT city  
FROM customers;

## **3.2 Unique States**

SELECT DISTINCT state  
FROM customers;

## **3.3 Unique Order Statuses**

SELECT DISTINCT order\_status  
FROM orders;

## **3.4 Unique Payment Methods**

SELECT DISTINCT payment\_method  
FROM payments;

## **3.5 Unique Warehouses**

SELECT DISTINCT warehouse\_name  
FROM inventory;  
---

# **4\. WHERE FILTERING**

## **4.1 Active Customers**

SELECT \*  
FROM customers  
WHERE customer\_status \= 'ACTIVE';

## **4.2 Inactive Customers**

SELECT \*  
FROM customers  
WHERE customer\_status \= 'INACTIVE';

## **4.3 Products Above ₹10,000**

SELECT product\_name,  
      price  
FROM products  
WHERE price \> 10000;

## **4.4 Products Below ₹5,000**

SELECT product\_name,  
      price  
FROM products  
WHERE price \< 5000;

## **4.5 Products Equal to ₹7,500**

SELECT product\_name,  
      price  
FROM products  
WHERE price \= 7500;

## **4.6 Orders Greater Than ₹50,000**

SELECT \*  
FROM orders  
WHERE total\_amount \> 50000;

## **4.7 Delivered Orders**

SELECT \*  
FROM orders  
WHERE order\_status \= 'DELIVERED';  
---

# **5\. AND / OR / NOT**

## **5.1 Active Customers From Tamil Nadu**

SELECT \*  
FROM customers  
WHERE customer\_status \= 'ACTIVE'  
 AND state \= 'Tamil Nadu';

## **5.2 Products Above ₹10,000 and Active**

SELECT \*  
FROM products  
WHERE price \> 10000  
 AND product\_status \= 'ACTIVE';

## **5.3 Chennai or Bangalore Customers**

SELECT \*  
FROM customers  
WHERE city \= 'Chennai'  
  OR city \= 'Bangalore';

## **5.4 Delivered or Shipped Orders**

SELECT \*  
FROM orders  
WHERE order\_status \= 'DELIVERED'  
  OR order\_status \= 'SHIPPED';

## **5.5 Products That Are Not Inactive**

SELECT \*  
FROM products  
WHERE NOT product\_status \= 'INACTIVE';

## **5.6 Combined AND / OR**

SELECT \*  
FROM orders  
WHERE order\_status \= 'DELIVERED'  
 AND (  
     total\_amount \> 50000  
     OR customer\_id \= 201  
 );  
---

# **6\. BETWEEN**

## **6.1 Products Between ₹5,000 and ₹20,000**

SELECT product\_name,  
      price  
FROM products  
WHERE price BETWEEN 5000 AND 20000;

## **6.2 Orders Between ₹10,000 and ₹80,000**

SELECT \*  
FROM orders  
WHERE total\_amount BETWEEN 10000 AND 80000;

## **6.3 Orders Within a Date Range**

SELECT \*  
FROM orders  
WHERE order\_date BETWEEN '2023-08-01'  
                     AND '2023-08-15';  
---

# **7\. IN / NOT IN**

## **7.1 Customers From Selected Cities**

SELECT \*  
FROM customers  
WHERE city IN (  
   'Chennai',  
   'Bangalore',  
   'Coimbatore'  
);

## **7.2 Orders With Selected Statuses**

SELECT \*  
FROM orders  
WHERE order\_status IN (  
   'DELIVERED',  
   'SHIPPED'  
);

## **7.3 Products From Selected Categories**

SELECT \*  
FROM products  
WHERE category\_id IN (  
   1,  
   2  
);

## **7.4 Customers Not From Selected Cities**

SELECT \*  
FROM customers  
WHERE city NOT IN (  
   'Chennai',  
   'Bangalore'  
);  
---

# **8\. LIKE**

## **8.1 Customers Whose First Name Starts With J**

SELECT \*  
FROM customers  
WHERE first\_name LIKE 'J%';

## **8.2 Products Ending With "Mouse"**

SELECT \*  
FROM products  
WHERE product\_name LIKE '%Mouse';

## **8.3 Products Containing "Phone"**

SELECT \*  
FROM products  
WHERE product\_name LIKE '%Phone%';

## **8.4 Customers Whose Name Contains "a"**

SELECT \*  
FROM customers  
WHERE first\_name LIKE '%a%';

## **8.5 Email Addresses From Gmail**

SELECT \*  
FROM customers  
WHERE email LIKE '%@gmail.com';  
---

# **9\. NULL OPERATIONS**

## **9.1 Customers Without Last Name**

SELECT \*  
FROM customers  
WHERE last\_name IS NULL;

## **9.2 Customers With Last Name**

SELECT \*  
FROM customers  
WHERE last\_name IS NOT NULL;

## **9.3 Products With Zero Stock**

SELECT \*  
FROM products  
WHERE stock\_quantity \= 0;

## **9.4 Inventory With Missing Quantity**

SELECT \*  
FROM inventory  
WHERE quantity IS NULL;  
---

# **10\. ORDER BY**

## **10.1 Products by Price Ascending**

SELECT product\_name,  
      price  
FROM products  
ORDER BY price ASC;

## **10.2 Products by Price Descending**

SELECT product\_name,  
      price  
FROM products  
ORDER BY price DESC;

## **10.3 Customers by Name**

SELECT first\_name,  
      last\_name  
FROM customers  
ORDER BY first\_name ASC;

## **10.4 Orders by Date**

SELECT \*  
FROM orders  
ORDER BY order\_date DESC;

## **10.5 Multiple-Column Sorting**

SELECT \*  
FROM products  
ORDER BY category\_id ASC,  
        price DESC;  
---

# **11\. LIMIT**

## **11.1 Top 5 Most Expensive Products**

SELECT product\_name,  
      price  
FROM products  
ORDER BY price DESC  
LIMIT 5;

## **11.2 Top 3 Orders**

SELECT \*  
FROM orders  
ORDER BY total\_amount DESC  
LIMIT 3;

## **11.3 Second Page of Products**

SELECT \*  
FROM products  
ORDER BY product\_id  
LIMIT 5 OFFSET 5;  
---

# **12\. AGGREGATE FUNCTIONS**

## **12.1 Count Customers**

SELECT COUNT(\*) AS customer\_count  
FROM customers;

## **12.2 Count Products**

SELECT COUNT(\*) AS product\_count  
FROM products;

## **12.3 Total Order Amount**

SELECT SUM(total\_amount) AS total\_sales  
FROM orders;

## **12.4 Average Order Amount**

SELECT AVG(total\_amount) AS average\_order  
FROM orders;

## **12.5 Highest Order**

SELECT MAX(total\_amount) AS highest\_order  
FROM orders;

## **12.6 Lowest Order**

SELECT MIN(total\_amount) AS lowest\_order  
FROM orders;

## **12.7 Multiple Aggregates**

SELECT  
   COUNT(\*) AS order\_count,  
   SUM(total\_amount) AS total\_sales,  
   AVG(total\_amount) AS average\_order,  
   MIN(total\_amount) AS minimum\_order,  
   MAX(total\_amount) AS maximum\_order  
FROM orders;  
---

# **13\. COUNT Variations**

## **13.1 Count Customer IDs**

SELECT COUNT(customer\_id)  
FROM customers;

## **13.2 Count Distinct Cities**

SELECT COUNT(DISTINCT city) AS city\_count  
FROM customers;

## **13.3 Count Distinct Products Ordered**

SELECT COUNT(DISTINCT product\_id) AS product\_count  
FROM order\_items;  
---

# **14\. GROUP BY**

## **14.1 Customers by City**

SELECT  
   city,  
   COUNT(\*) AS customer\_count  
FROM customers  
GROUP BY city;

## **14.2 Customers by State**

SELECT  
   state,  
   COUNT(\*) AS customer\_count  
FROM customers  
GROUP BY state;

## **14.3 Orders by Status**

SELECT  
   order\_status,  
   COUNT(\*) AS order\_count  
FROM orders  
GROUP BY order\_status;

## **14.4 Sales by Customer**

SELECT  
   customer\_id,  
   SUM(total\_amount) AS total\_spent  
FROM orders  
GROUP BY customer\_id;

## **14.5 Sales by Customer and Status**

SELECT  
   customer\_id,  
   order\_status,  
   SUM(total\_amount) AS total\_amount  
FROM orders  
GROUP BY customer\_id,  
        order\_status;

## **14.6 Products by Category**

SELECT  
   category\_id,  
   COUNT(\*) AS product\_count  
FROM products  
GROUP BY category\_id;  
---

# **15\. HAVING**

## **15.1 Customers With More Than One Order**

SELECT  
   customer\_id,  
   COUNT(\*) AS order\_count  
FROM orders  
GROUP BY customer\_id  
HAVING COUNT(\*) \> 1;

## **15.2 Customers Spending More Than ₹50,000**

SELECT  
   customer\_id,  
   SUM(total\_amount) AS total\_spent  
FROM orders  
GROUP BY customer\_id  
HAVING SUM(total\_amount) \> 50000;

## **15.3 Product Categories With More Than Two Products**

SELECT  
   category\_id,  
   COUNT(\*) AS product\_count  
FROM products  
GROUP BY category\_id  
HAVING COUNT(\*) \> 2;

## **15.4 Average Product Price Above ₹10,000**

SELECT  
   category\_id,  
   AVG(price) AS average\_price  
FROM products  
GROUP BY category\_id  
HAVING AVG(price) \> 10000;  
---

# **16\. WHERE \+ GROUP BY \+ HAVING**

## **16.1 Delivered Orders Per Customer Above ₹50,000**

SELECT  
   customer\_id,  
   SUM(total\_amount) AS delivered\_amount  
FROM orders  
WHERE order\_status \= 'DELIVERED'  
GROUP BY customer\_id  
HAVING SUM(total\_amount) \> 50000;  
---

# **17\. STRING FUNCTIONS**

## **17.1 Combine First and Last Name**

SELECT  
   CONCAT(first\_name, ' ', last\_name) AS full\_name  
FROM customers;

## **17.2 Convert Product Names to Uppercase**

SELECT  
   UPPER(product\_name) AS product\_name  
FROM products;

## **17.3 Convert Product Names to Lowercase**

SELECT  
   LOWER(product\_name) AS product\_name  
FROM products;

## **17.4 Product Name Length**

SELECT  
   product\_name,  
   LENGTH(product\_name) AS name\_length  
FROM products;

## **17.5 First Five Characters**

SELECT  
   product\_name,  
   SUBSTRING(product\_name, 1, 5\) AS short\_name  
FROM products;

## **17.6 Trim Customer Names**

SELECT  
   TRIM(first\_name) AS first\_name  
FROM customers;  
---

# **18\. NUMERIC FUNCTIONS**

## **18.1 Round Product Price**

SELECT  
   product\_name,  
   ROUND(price, 0\) AS rounded\_price  
FROM products;

## **18.2 Ceiling Price**

SELECT  
   product\_name,  
   CEIL(price) AS ceiling\_price  
FROM products;

## **18.3 Floor Price**

SELECT  
   product\_name,  
   FLOOR(price) AS floor\_price  
FROM products;

## **18.4 Absolute Discount**

SELECT  
   order\_item\_id,  
   ABS(discount) AS absolute\_discount  
FROM order\_items;  
---

# **19\. DATE FUNCTIONS**

## **19.1 Extract Order Year**

SELECT  
   order\_id,  
   YEAR(order\_date) AS order\_year  
FROM orders;

## **19.2 Extract Order Month**

SELECT  
   order\_id,  
   MONTH(order\_date) AS order\_month  
FROM orders;

## **19.3 Extract Order Day**

SELECT  
   order\_id,  
   DAY(order\_date) AS order\_day  
FROM orders;

## **19.4 Days Since Order**

SELECT  
   order\_id,  
   DATEDIFF(CURRENT\_DATE, order\_date) AS days\_since\_order  
FROM orders;

## **19.5 Format Order Date**

SELECT  
   order\_id,  
   DATE\_FORMAT(order\_date, '%d-%m-%Y') AS formatted\_date  
FROM orders;  
---

# **20\. DATE FILTERING**

## **20.1 Orders After August 10**

SELECT \*  
FROM orders  
WHERE order\_date \> '2023-08-10';

## **20.2 Orders Before August 15**

SELECT \*  
FROM orders  
WHERE order\_date \< '2023-08-15';

## **20.3 Orders Between August 1 and August 15**

SELECT \*  
FROM orders  
WHERE order\_date BETWEEN '2023-08-01'  
                     AND '2023-08-15';  
---

# **21\. CASE EXPRESSIONS**

## **21.1 Categorize Products by Price**

SELECT  
   product\_name,  
   price,  
   CASE  
       WHEN price \>= 50000 THEN 'EXPENSIVE'  
       WHEN price \>= 10000 THEN 'MEDIUM'  
       ELSE 'LOW'  
   END AS price\_category  
FROM products;

## **21.2 Categorize Orders**

SELECT  
   order\_id,  
   total\_amount,  
   CASE  
       WHEN total\_amount \>= 50000 THEN 'HIGH'  
       WHEN total\_amount \>= 10000 THEN 'MEDIUM'  
       ELSE 'LOW'  
   END AS order\_category  
FROM orders;

## **21.3 Order Status Description**

SELECT  
   order\_id,  
   order\_status,  
   CASE  
       WHEN order\_status \= 'DELIVERED' THEN 'Completed'  
       WHEN order\_status \= 'SHIPPED' THEN 'In Transit'  
       WHEN order\_status \= 'PLACED' THEN 'New Order'  
       WHEN order\_status \= 'CANCELLED' THEN 'Cancelled'  
       ELSE 'Unknown'  
   END AS status\_description  
FROM orders;  
---

# **22\. INNER JOIN**

## **22.1 Customers and Orders**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   o.order\_date,  
   o.total\_amount  
FROM customers c  
INNER JOIN orders o  
   ON c.customer\_id \= o.customer\_id;

## **22.2 Products and Categories**

SELECT  
   p.product\_name,  
   p.price,  
   c.category\_name  
FROM products p  
INNER JOIN categories c  
   ON p.category\_id \= c.category\_id;

## **22.3 Orders and Payments**

SELECT  
   o.order\_id,  
   o.total\_amount,  
   p.payment\_method,  
   p.amount  
FROM orders o  
INNER JOIN payments p  
   ON o.order\_id \= p.order\_id;  
---

# **23\. LEFT JOIN**

## **23.1 All Customers Including Customers Without Orders**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   o.order\_id  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id;

## **23.2 Customers Without Orders**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
WHERE o.order\_id IS NULL;

## **23.3 All Products Including Products Never Ordered**

SELECT  
   p.product\_id,  
   p.product\_name,  
   oi.order\_id  
FROM products p  
LEFT JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id;  
---

# **24\. RIGHT JOIN**

## **24.1 Categories and Products**

SELECT  
   p.product\_name,  
   c.category\_name  
FROM products p  
RIGHT JOIN categories c  
   ON p.category\_id \= c.category\_id;  
---

# **25\. MULTI-TABLE JOINS**

## **25.1 Customer → Order → Order Item**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   oi.product\_id,  
   oi.quantity  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id;

## **25.2 Customer → Order → Product**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   p.product\_name,  
   oi.quantity  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
JOIN products p  
   ON oi.product\_id \= p.product\_id;

## **25.3 Customer → Order → Product → Category**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   p.product\_name,  
   ca.category\_name,  
   oi.quantity  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
JOIN products p  
   ON oi.product\_id \= p.product\_id  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id;

## **25.4 Customer → Order → Payment**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   o.total\_amount,  
   p.payment\_method,  
   p.payment\_status  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN payments p  
   ON o.order\_id \= p.order\_id;

## **25.5 Product → Category → Inventory**

SELECT  
   p.product\_name,  
   ca.category\_name,  
   i.warehouse\_name,  
   i.quantity  
FROM products p  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id  
JOIN inventory i  
   ON p.product\_id \= i.product\_id;  
---

# **26\. JOIN \+ WHERE**

## **26.1 Electronics Products**

SELECT  
   p.product\_name,  
   p.price,  
   ca.category\_name  
FROM products p  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id  
WHERE ca.category\_name \= 'Electronics';

## **26.2 Electronics Above ₹5,000**

SELECT  
   p.product\_name,  
   p.price  
FROM products p  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id  
WHERE ca.category\_name \= 'Electronics'  
 AND p.price \> 5000;

## **26.3 Delivered Orders With Customer Details**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   o.total\_amount  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
WHERE o.order\_status \= 'DELIVERED';  
---

# **27\. JOIN \+ GROUP BY**

## **27.1 Total Spending Per Customer**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name;

## **27.2 Number of Orders Per Customer**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   COUNT(o.order\_id) AS order\_count  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name;

## **27.3 Total Quantity Sold Per Product**

SELECT  
   p.product\_id,  
   p.product\_name,  
   SUM(oi.quantity) AS total\_quantity  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name;

## **27.4 Sales by Category**

SELECT  
   ca.category\_name,  
   SUM(oi.quantity \* oi.unit\_price) AS total\_sales  
FROM categories ca  
JOIN products p  
   ON ca.category\_id \= p.category\_id  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY ca.category\_id,  
        ca.category\_name;  
---

# **28\. JOIN \+ HAVING**

## **28.1 Customers Spending More Than ₹50,000**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING SUM(o.total\_amount) \> 50000;

## **28.2 Customers With More Than One Order**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   COUNT(o.order\_id) AS order\_count  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING COUNT(o.order\_id) \> 1;

## **28.3 Categories With Sales Greater Than ₹10,000**

SELECT  
   ca.category\_name,  
   SUM(oi.quantity \* oi.unit\_price) AS total\_sales  
FROM categories ca  
JOIN products p  
   ON ca.category\_id \= p.category\_id  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   ca.category\_id,  
   ca.category\_name  
HAVING SUM(oi.quantity \* oi.unit\_price) \> 10000;  
---

# **29\. JOIN \+ CASE**

## **29.1 Customer Order Classification**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   o.total\_amount,  
   CASE  
       WHEN o.total\_amount \>= 50000 THEN 'HIGH VALUE'  
       WHEN o.total\_amount \>= 10000 THEN 'MEDIUM VALUE'  
       ELSE 'LOW VALUE'  
   END AS order\_category  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id;  
---

# **30\. SUBQUERIES**

## **30.1 Products Above Average Price**

SELECT  
   product\_name,  
   price  
FROM products  
WHERE price \> (  
   SELECT AVG(price)  
   FROM products  
);

## **30.2 Most Expensive Product**

SELECT  
   product\_name,  
   price  
FROM products  
WHERE price \= (  
   SELECT MAX(price)  
   FROM products  
);

## **30.3 Cheapest Product**

SELECT  
   product\_name,  
   price  
FROM products  
WHERE price \= (  
   SELECT MIN(price)  
   FROM products  
);

## **30.4 Orders Above Average**

SELECT  
   order\_id,  
   total\_amount  
FROM orders  
WHERE total\_amount \> (  
   SELECT AVG(total\_amount)  
   FROM orders  
);  
---

# **31\. IN SUBQUERIES**

## **31.1 Customers Who Placed Orders**

SELECT  
   customer\_id,  
   first\_name,  
   last\_name  
FROM customers  
WHERE customer\_id IN (  
   SELECT customer\_id  
   FROM orders  
);

## **31.2 Products That Have Been Ordered**

SELECT  
   product\_id,  
   product\_name  
FROM products  
WHERE product\_id IN (  
   SELECT product\_id  
   FROM order\_items  
);

## **31.3 Customers Who Purchased Electronics**

SELECT DISTINCT  
   c.first\_name,  
   c.last\_name  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
WHERE oi.product\_id IN (  
   SELECT p.product\_id  
   FROM products p  
   JOIN categories ca  
       ON p.category\_id \= ca.category\_id  
   WHERE ca.category\_name \= 'Electronics'  
);  
---

# **32\. NOT IN SUBQUERIES**

## **32.1 Customers Who Never Ordered**

SELECT  
   customer\_id,  
   first\_name,  
   last\_name  
FROM customers  
WHERE customer\_id NOT IN (  
   SELECT customer\_id  
   FROM orders  
);

## **32.2 Products Never Ordered**

SELECT  
   product\_id,  
   product\_name  
FROM products  
WHERE product\_id NOT IN (  
   SELECT product\_id  
   FROM order\_items  
);  
---

# **33\. EXISTS**

## **33.1 Customers With At Least One Order**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
FROM customers c  
WHERE EXISTS (  
   SELECT 1  
   FROM orders o  
   WHERE o.customer\_id \= c.customer\_id  
);

## **33.2 Products That Have Been Ordered**

SELECT  
   p.product\_id,  
   p.product\_name  
FROM products p  
WHERE EXISTS (  
   SELECT 1  
   FROM order\_items oi  
   WHERE oi.product\_id \= p.product\_id  
);  
---

# **34\. NOT EXISTS**

## **34.1 Customers Without Orders**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
FROM customers c  
WHERE NOT EXISTS (  
   SELECT 1  
   FROM orders o  
   WHERE o.customer\_id \= c.customer\_id  
);

## **34.2 Products Never Ordered**

SELECT  
   p.product\_id,  
   p.product\_name  
FROM products p  
WHERE NOT EXISTS (  
   SELECT 1  
   FROM order\_items oi  
   WHERE oi.product\_id \= p.product\_id  
);  
---

# **35\. CORRELATED SUBQUERIES**

## **35.1 Products Above Their Category Average**

SELECT  
   p.product\_name,  
   p.category\_id,  
   p.price  
FROM products p  
WHERE p.price \> (  
   SELECT AVG(p2.price)  
   FROM products p2  
   WHERE p2.category\_id \= p.category\_id  
);

## **35.2 Orders Above Customer Average**

SELECT  
   o.order\_id,  
   o.customer\_id,  
   o.total\_amount  
FROM orders o  
WHERE o.total\_amount \> (  
   SELECT AVG(o2.total\_amount)  
   FROM orders o2  
   WHERE o2.customer\_id \= o.customer\_id  
);

## **35.3 Most Expensive Product Per Category**

SELECT  
   p.product\_name,  
   p.category\_id,  
   p.price  
FROM products p  
WHERE p.price \= (  
   SELECT MAX(p2.price)  
   FROM products p2  
   WHERE p2.category\_id \= p.category\_id  
);  
---

# **36\. NESTED SUBQUERIES**

## **36.1 Customers Who Purchased the Most Expensive Product**

SELECT DISTINCT  
   c.first\_name,  
   c.last\_name  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
WHERE oi.product\_id \= (  
   SELECT product\_id  
   FROM products  
   WHERE price \= (  
       SELECT MAX(price)  
       FROM products  
   )  
);

## **36.2 Orders Containing the Cheapest Product**

SELECT DISTINCT  
   o.order\_id,  
   o.customer\_id  
FROM orders o  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
WHERE oi.product\_id \= (  
   SELECT product\_id  
   FROM products  
   WHERE price \= (  
       SELECT MIN(price)  
       FROM products  
   )  
);  
---

# **37\. DERIVED TABLES**

## **37.1 Customer Total Spending**

SELECT  
   customer\_id,  
   total\_spent  
FROM (  
   SELECT  
       customer\_id,  
       SUM(total\_amount) AS total\_spent  
   FROM orders  
   GROUP BY customer\_id  
) AS customer\_sales;

## **37.2 Customers Spending Above Average**

SELECT  
   customer\_id,  
   total\_spent  
FROM (  
   SELECT  
       customer\_id,  
       SUM(total\_amount) AS total\_spent  
   FROM orders  
   GROUP BY customer\_id  
) AS customer\_sales  
WHERE total\_spent \> (  
   SELECT AVG(total\_spent)  
   FROM (  
       SELECT  
           customer\_id,  
           SUM(total\_amount) AS total\_spent  
       FROM orders  
       GROUP BY customer\_id  
   ) AS x  
);  
---

# **38\. JOIN \+ SUBQUERY \+ GROUP BY**

## **38.1 Customers Spending Above Average Order Amount**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING SUM(o.total\_amount) \> (  
   SELECT AVG(total\_amount)  
   FROM orders  
);

## **38.2 Products With Quantity Above Average**

SELECT  
   p.product\_id,  
   p.product\_name,  
   SUM(oi.quantity) AS total\_quantity  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name  
HAVING SUM(oi.quantity) \> (  
   SELECT AVG(total\_quantity)  
   FROM (  
       SELECT  
           product\_id,  
           SUM(quantity) AS total\_quantity  
       FROM order\_items  
       GROUP BY product\_id  
   ) AS x  
);  
---

# **39\. UNION**

## **39.1 Customer Cities From Two Queries**

SELECT city  
FROM customers  
WHERE state \= 'Tamil Nadu'

UNION

SELECT city  
FROM customers  
WHERE state \= 'Maharashtra';

## **39.2 Active and Inactive Customer Cities**

SELECT city  
FROM customers  
WHERE customer\_status \= 'ACTIVE'

UNION

SELECT city  
FROM customers  
WHERE customer\_status \= 'INACTIVE';  
---

# **40\. UNION ALL**

## **40.1 Combine Customer Cities Without Removing Duplicates**

SELECT city  
FROM customers  
WHERE state \= 'Tamil Nadu'

UNION ALL

SELECT city  
FROM customers  
WHERE state \= 'Maharashtra';  
---

# **41\. INSERT OPERATIONS**

## **41.1 Insert a Customer**

INSERT INTO customers  
(  
   first\_name,  
   last\_name,  
   email,  
   phone,  
   city,  
   state,  
   customer\_status  
)  
VALUES  
(  
   'Arun',  
   'Kumar',  
   'arun@example.com',  
   '9876500000',  
   'Chennai',  
   'Tamil Nadu',  
   'ACTIVE'  
);

## **41.2 Insert a Product**

INSERT INTO products  
(  
   product\_name,  
   category\_id,  
   price,  
   stock\_quantity,  
   product\_status  
)  
VALUES  
(  
   'Bluetooth Speaker',  
   1,  
   3000.00,  
   25,  
   'ACTIVE'  
);  
---

# **42\. UPDATE OPERATIONS**

## **42.1 Update Product Price**

UPDATE products  
SET price \= 8000  
WHERE product\_name \= 'Office Chair';

## **42.2 Increase All Product Prices by 10%**

UPDATE products  
SET price \= price \* 1.10;

## **42.3 Update Product Stock**

UPDATE products  
SET stock\_quantity \= stock\_quantity \+ 10  
WHERE product\_id \= 301;

## **42.4 Change Customer Status**

UPDATE customers  
SET customer\_status \= 'INACTIVE'  
WHERE customer\_id \= 208;  
---

# **43\. DELETE OPERATIONS**

## **43.1 Delete a Specific Customer**

DELETE FROM customers  
WHERE customer\_id \= 208;

## **43.2 Delete Cancelled Orders**

DELETE FROM orders  
WHERE order\_status \= 'CANCELLED';

## **43.3 Delete Products With Zero Stock**

DELETE FROM products  
WHERE stock\_quantity \= 0;

> Be careful with DELETE operations because foreign-key relationships may prevent deletion.

---

# **44\. UPDATE \+ SUBQUERY**

## **44.1 Increase Price of Products in Electronics**

UPDATE products  
SET price \= price \* 1.10  
WHERE category\_id \= (  
   SELECT category\_id  
   FROM categories  
   WHERE category\_name \= 'Electronics'  
);  
---

# **45\. CASE \+ AGGREGATION**

## **45.1 Categorize Customers by Spending**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent,  
   CASE  
       WHEN SUM(o.total\_amount) \>= 100000 THEN 'VIP'  
       WHEN SUM(o.total\_amount) \>= 50000 THEN 'PREMIUM'  
       ELSE 'REGULAR'  
   END AS customer\_segment  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name;  
---

# **46\. INVENTORY ANALYSIS**

## **46.1 Products Below Reorder Level**

SELECT  
   p.product\_name,  
   i.quantity,  
   i.reorder\_level  
FROM products p  
JOIN inventory i  
   ON p.product\_id \= i.product\_id  
WHERE i.quantity \< i.reorder\_level;

## **46.2 Products At or Below Reorder Level**

SELECT  
   p.product\_name,  
   i.quantity,  
   i.reorder\_level  
FROM products p  
JOIN inventory i  
   ON p.product\_id \= i.product\_id  
WHERE i.quantity \<= i.reorder\_level;

## **46.3 Inventory Status**

SELECT  
   p.product\_name,  
   i.quantity,  
   i.reorder\_level,  
   CASE  
       WHEN i.quantity \<= i.reorder\_level THEN 'REORDER'  
       ELSE 'SUFFICIENT'  
   END AS inventory\_status  
FROM products p  
JOIN inventory i  
   ON p.product\_id \= i.product\_id;  
---

# **47\. PAYMENT ANALYSIS**

## **47.1 Successful Payments**

SELECT \*  
FROM payments  
WHERE payment\_status \= 'SUCCESS';

## **47.2 Refunded Payments**

SELECT \*  
FROM payments  
WHERE payment\_status \= 'REFUNDED';

## **47.3 Total Successful Payments**

SELECT  
   SUM(amount) AS successful\_payment\_amount  
FROM payments  
WHERE payment\_status \= 'SUCCESS';

## **47.4 Payment Method Summary**

SELECT  
   payment\_method,  
   COUNT(\*) AS payment\_count,  
   SUM(amount) AS total\_amount  
FROM payments  
GROUP BY payment\_method;  
---

# **48\. ORDER ANALYSIS**

## **48.1 Orders Per Status**

SELECT  
   order\_status,  
   COUNT(\*) AS order\_count  
FROM orders  
GROUP BY order\_status;

## **48.2 Revenue Per Status**

SELECT  
   order\_status,  
   SUM(total\_amount) AS total\_amount  
FROM orders  
GROUP BY order\_status;

## **48.3 Delivered Revenue**

SELECT  
   SUM(total\_amount) AS delivered\_revenue  
FROM orders  
WHERE order\_status \= 'DELIVERED';  
---

# **49\. CUSTOMER ANALYSIS**

## **49.1 Customers and Number of Orders**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   COUNT(o.order\_id) AS order\_count  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name;

## **49.2 Customers and Total Spending**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   COALESCE(SUM(o.total\_amount), 0\) AS total\_spent  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name;

## **49.3 Highest-Spending Customer**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
ORDER BY total\_spent DESC  
LIMIT 1;  
---

# **50\. PRODUCT ANALYSIS**

## **50.1 Product Sales Quantity**

SELECT  
   p.product\_name,  
   SUM(oi.quantity) AS quantity\_sold  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name;

## **50.2 Best-Selling Product**

SELECT  
   p.product\_name,  
   SUM(oi.quantity) AS quantity\_sold  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name  
ORDER BY quantity\_sold DESC  
LIMIT 1;

## **50.3 Product Revenue**

SELECT  
   p.product\_name,  
   SUM(oi.quantity \* oi.unit\_price) AS revenue  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name;

## **50.4 Highest-Revenue Product**

SELECT  
   p.product\_name,  
   SUM(oi.quantity \* oi.unit\_price) AS revenue  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name  
ORDER BY revenue DESC  
LIMIT 1;  
---

# **51\. CATEGORY ANALYSIS**

## **51.1 Number of Products Per Category**

SELECT  
   ca.category\_name,  
   COUNT(p.product\_id) AS product\_count  
FROM categories ca  
LEFT JOIN products p  
   ON ca.category\_id \= p.category\_id  
GROUP BY  
   ca.category\_id,  
   ca.category\_name;

## **51.2 Average Price Per Category**

SELECT  
   ca.category\_name,  
   AVG(p.price) AS average\_price  
FROM categories ca  
JOIN products p  
   ON ca.category\_id \= p.category\_id  
GROUP BY  
   ca.category\_id,  
   ca.category\_name;

## **51.3 Most Expensive Category Average**

SELECT  
   ca.category\_name,  
   AVG(p.price) AS average\_price  
FROM categories ca  
JOIN products p  
   ON ca.category\_id \= p.category\_id  
GROUP BY  
   ca.category\_id,  
   ca.category\_name  
ORDER BY average\_price DESC  
LIMIT 1;  
---

# **52\. ADDRESS ANALYSIS**

## **52.1 Customers and Their Addresses**

SELECT  
   c.first\_name,  
   c.last\_name,  
   a.address\_line1,  
   a.city,  
   a.state,  
   a.pincode  
FROM customers c  
JOIN addresses a  
   ON c.customer\_id \= a.customer\_id;

## **52.2 Customers With Office Addresses**

SELECT  
   c.first\_name,  
   c.last\_name,  
   a.address\_line1,  
   a.city  
FROM customers c  
JOIN addresses a  
   ON c.customer\_id \= a.customer\_id  
WHERE a.address\_type \= 'OFFICE';  
---

# **53\. BUSINESS COMBINATIONS**

## **53.1 Customers Who Purchased Electronics**

SELECT DISTINCT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
JOIN products p  
   ON oi.product\_id \= p.product\_id  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id  
WHERE ca.category\_name \= 'Electronics';

## **53.2 Customers Who Purchased Products Above ₹50,000**

SELECT DISTINCT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
JOIN products p  
   ON oi.product\_id \= p.product\_id  
WHERE p.price \> 50000;

## **53.3 Customers With Delivered Orders Above ₹50,000**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   o.total\_amount  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
WHERE o.order\_status \= 'DELIVERED'  
 AND o.total\_amount \> 50000;

## **53.4 Customers With Successful Payments Above ₹50,000**

SELECT  
   c.first\_name,  
   c.last\_name,  
   o.order\_id,  
   p.amount  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN payments p  
   ON o.order\_id \= p.order\_id  
WHERE p.payment\_status \= 'SUCCESS'  
 AND p.amount \> 50000;  
---

# **54\. INTERMEDIATE BUSINESS QUERIES**

## **54.1 Customers Spending More Than Average Customer**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING SUM(o.total\_amount) \> (  
   SELECT AVG(customer\_total)  
   FROM (  
       SELECT  
           customer\_id,  
           SUM(total\_amount) AS customer\_total  
       FROM orders  
       GROUP BY customer\_id  
   ) x  
);

## **54.2 Products More Expensive Than Their Category Average**

SELECT  
   p.product\_name,  
   ca.category\_name,  
   p.price  
FROM products p  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id  
WHERE p.price \> (  
   SELECT AVG(p2.price)  
   FROM products p2  
   WHERE p2.category\_id \= p.category\_id  
);

## **54.3 Customers Who Purchased More Than One Product**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   COUNT(DISTINCT oi.product\_id) AS product\_count  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING COUNT(DISTINCT oi.product\_id) \> 1;

## **54.4 Customers With More Than One Order**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   COUNT(o.order\_id) AS order\_count  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING COUNT(o.order\_id) \> 1;

## **54.5 Products Never Ordered**

SELECT  
   p.product\_id,  
   p.product\_name  
FROM products p  
LEFT JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
WHERE oi.product\_id IS NULL;

## **54.6 Customers Never Ordered**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
WHERE o.order\_id IS NULL;  
---

# **55\. TOP-N BUSINESS QUERIES**

## **55.1 Top 3 Customers by Spending**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
ORDER BY total\_spent DESC  
LIMIT 3;

## **55.2 Top 3 Products by Revenue**

SELECT  
   p.product\_name,  
   SUM(oi.quantity \* oi.unit\_price) AS revenue  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name  
ORDER BY revenue DESC  
LIMIT 3;

## **55.3 Top 3 Products by Quantity Sold**

SELECT  
   p.product\_name,  
   SUM(oi.quantity) AS quantity\_sold  
FROM products p  
JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name  
ORDER BY quantity\_sold DESC  
LIMIT 3;  
---

# **56\. COMPLETE QUERY COMBINATIONS**

## **56.1 SELECT \+ WHERE \+ ORDER BY**

SELECT  
   product\_name,  
   price  
FROM products  
WHERE price \> 5000  
ORDER BY price DESC;

## **56.2 SELECT \+ WHERE \+ ORDER BY \+ LIMIT**

SELECT  
   product\_name,  
   price  
FROM products  
WHERE price \> 5000  
ORDER BY price DESC  
LIMIT 5;

## **56.3 JOIN \+ WHERE \+ ORDER BY**

SELECT  
   p.product\_name,  
   ca.category\_name,  
   p.price  
FROM products p  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id  
WHERE p.price \> 5000  
ORDER BY p.price DESC;

## **56.4 JOIN \+ GROUP BY \+ ORDER BY**

SELECT  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
ORDER BY total\_spent DESC;

## **56.5 JOIN \+ GROUP BY \+ HAVING \+ ORDER BY**

SELECT  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING SUM(o.total\_amount) \> 50000  
ORDER BY total\_spent DESC;

## **56.6 JOIN \+ WHERE \+ GROUP BY \+ HAVING \+ ORDER BY**

SELECT  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
WHERE o.order\_status \= 'DELIVERED'  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING SUM(o.total\_amount) \> 50000  
ORDER BY total\_spent DESC;

## **56.7 JOIN \+ CASE \+ GROUP BY \+ HAVING \+ ORDER BY**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent,  
   CASE  
       WHEN SUM(o.total\_amount) \>= 100000 THEN 'VIP'  
       WHEN SUM(o.total\_amount) \>= 50000 THEN 'PREMIUM'  
       ELSE 'REGULAR'  
   END AS customer\_segment  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING SUM(o.total\_amount) \> 10000  
ORDER BY total\_spent DESC;

## **56.8 JOIN \+ SUBQUERY \+ GROUP BY \+ HAVING \+ ORDER BY**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
HAVING SUM(o.total\_amount) \> (  
   SELECT AVG(total\_amount)  
   FROM orders  
)  
ORDER BY total\_spent DESC;  
---

# **57\. NULL \+ COALESCE**

## **57.1 Customers With Zero Spending**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   COALESCE(SUM(o.total\_amount), 0\) AS total\_spent  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name;  
---

# **58\. DATA VALIDATION QUERIES**

## **58.1 Check Duplicate Emails**

SELECT  
   email,  
   COUNT(\*) AS email\_count  
FROM customers  
GROUP BY email  
HAVING COUNT(\*) \> 1;

## **58.2 Check Duplicate Product Names**

SELECT  
   product\_name,  
   COUNT(\*) AS product\_count  
FROM products  
GROUP BY product\_name  
HAVING COUNT(\*) \> 1;

## **58.3 Check Orders Without Valid Customers**

SELECT o.\*  
FROM orders o  
LEFT JOIN customers c  
   ON o.customer\_id \= c.customer\_id  
WHERE c.customer\_id IS NULL;

## **58.4 Check Order Items Without Valid Products**

SELECT oi.\*  
FROM order\_items oi  
LEFT JOIN products p  
   ON oi.product\_id \= p.product\_id  
WHERE p.product\_id IS NULL;  
---

# **59\. INTERVIEW-STYLE BASIC QUESTIONS**

## **59.1 Find the Second Highest Product Price**

SELECT MAX(price) AS second\_highest\_price  
FROM products  
WHERE price \< (  
   SELECT MAX(price)  
   FROM products  
);

## **59.2 Find the Second Highest Order**

SELECT MAX(total\_amount) AS second\_highest\_order  
FROM orders  
WHERE total\_amount \< (  
   SELECT MAX(total\_amount)  
   FROM orders  
);

## **59.3 Find Products With Maximum Price**

SELECT \*  
FROM products  
WHERE price \= (  
   SELECT MAX(price)  
   FROM products  
);

## **59.4 Find Customers With Maximum Spending**

SELECT  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name,  
   SUM(o.total\_amount) AS total\_spent  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
ORDER BY total\_spent DESC  
LIMIT 1;  
---

# **60\. SMARTMART END-TO-END QUERIES**

## **60.1 Customer Purchase Report**

SELECT  
   c.customer\_id,  
   CONCAT(c.first\_name, ' ', c.last\_name) AS customer\_name,  
   o.order\_id,  
   o.order\_date,  
   p.product\_name,  
   ca.category\_name,  
   oi.quantity,  
   oi.unit\_price,  
   oi.discount,  
   (oi.quantity \* oi.unit\_price) \- oi.discount AS net\_value  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
JOIN order\_items oi  
   ON o.order\_id \= oi.order\_id  
JOIN products p  
   ON oi.product\_id \= p.product\_id  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id;

## **60.2 Complete Customer Revenue Report**

SELECT  
   c.customer\_id,  
   CONCAT(c.first\_name, ' ', c.last\_name) AS customer\_name,  
   COUNT(DISTINCT o.order\_id) AS order\_count,  
   SUM(o.total\_amount) AS total\_spent,  
   AVG(o.total\_amount) AS average\_order,  
   MAX(o.total\_amount) AS highest\_order,  
   MIN(o.total\_amount) AS lowest\_order  
FROM customers c  
LEFT JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
GROUP BY  
   c.customer\_id,  
   c.first\_name,  
   c.last\_name  
ORDER BY total\_spent DESC;

## **60.3 Product Performance Report**

SELECT  
   p.product\_id,  
   p.product\_name,  
   ca.category\_name,  
   p.price,  
   p.stock\_quantity,  
   COALESCE(SUM(oi.quantity), 0\) AS quantity\_sold,  
   COALESCE(  
       SUM(oi.quantity \* oi.unit\_price),  
       0  
   ) AS revenue  
FROM products p  
JOIN categories ca  
   ON p.category\_id \= ca.category\_id  
LEFT JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name,  
   ca.category\_name,  
   p.price,  
   p.stock\_quantity  
ORDER BY revenue DESC;

## **60.4 Inventory \+ Sales Analysis**

SELECT  
   p.product\_name,  
   i.warehouse\_name,  
   i.quantity AS inventory\_quantity,  
   i.reorder\_level,  
   COALESCE(SUM(oi.quantity), 0\) AS quantity\_sold,  
   CASE  
       WHEN i.quantity \<= i.reorder\_level  
           THEN 'REORDER'  
       ELSE 'SUFFICIENT'  
   END AS inventory\_status  
FROM products p  
JOIN inventory i  
   ON p.product\_id \= i.product\_id  
LEFT JOIN order\_items oi  
   ON p.product\_id \= oi.product\_id  
GROUP BY  
   p.product\_id,  
   p.product\_name,  
   i.warehouse\_name,  
   i.quantity,  
   i.reorder\_level;

## **60.5 Customer \+ Order \+ Payment Report**

SELECT  
   c.customer\_id,  
   CONCAT(c.first\_name, ' ', c.last\_name) AS customer\_name,  
   o.order\_id,  
   o.order\_date,  
   o.order\_status,  
   o.total\_amount,  
   p.payment\_method,  
   p.payment\_status,  
   p.amount AS payment\_amount  
FROM customers c  
JOIN orders o  
   ON c.customer\_id \= o.customer\_id  
LEFT JOIN payments p  
   ON o.order\_id \= p.order\_id;  
---

# **61\. SQL COMBINATION MATRIX**

| Level | Combination |
| ----- | ----- |
| Basic | SELECT |
| Basic | SELECT \+ WHERE |
| Basic | SELECT \+ ORDER BY |
| Basic | SELECT \+ LIMIT |
| Basic | WHERE \+ AND |
| Basic | WHERE \+ OR |
| Basic | WHERE \+ IN |
| Basic | WHERE \+ BETWEEN |
| Basic | WHERE \+ LIKE |
| Basic | WHERE \+ IS NULL |
| Basic | DISTINCT \+ WHERE |
| Basic | WHERE \+ ORDER BY |
| Basic | WHERE \+ ORDER BY \+ LIMIT |
| Basic | Aggregate |
| Basic | GROUP BY |
| Basic | GROUP BY \+ HAVING |
| Basic | GROUP BY \+ ORDER BY |
| Basic | GROUP BY \+ HAVING \+ ORDER BY |
| Basic | CASE |
| Basic | CASE \+ WHERE |
| Basic | CASE \+ GROUP BY |
| Basic | String functions |
| Basic | Date functions |
| Basic | Numeric functions |
| Basic | INSERT |
| Basic | UPDATE |
| Basic | DELETE |
| Intermediate | INNER JOIN |
| Intermediate | LEFT JOIN |
| Intermediate | RIGHT JOIN |
| Intermediate | Two-table JOIN |
| Intermediate | Three-table JOIN |
| Intermediate | Four-table JOIN |
| Intermediate | JOIN \+ WHERE |
| Intermediate | JOIN \+ ORDER BY |
| Intermediate | JOIN \+ GROUP BY |
| Intermediate | JOIN \+ HAVING |
| Intermediate | JOIN \+ CASE |
| Intermediate | JOIN \+ Aggregate |
| Intermediate | JOIN \+ Subquery |
| Intermediate | JOIN \+ IN |
| Intermediate | JOIN \+ NOT IN |
| Intermediate | JOIN \+ EXISTS |
| Intermediate | JOIN \+ NOT EXISTS |
| Intermediate | Correlated Subquery |
| Intermediate | Nested Subquery |
| Intermediate | Derived Table |
| Intermediate | Derived Table \+ GROUP BY |
| Intermediate | Derived Table \+ HAVING |
| Intermediate | UNION |
| Intermediate | UNION ALL |
| Intermediate | CASE \+ Aggregate |
| Intermediate | JOIN \+ CASE \+ GROUP BY |
| Intermediate | JOIN \+ GROUP BY \+ HAVING |
| Intermediate | JOIN \+ Subquery \+ GROUP BY |
| Intermediate | JOIN \+ Subquery \+ HAVING |
| Intermediate | JOIN \+ CASE \+ Subquery |
| Intermediate | JOIN \+ Aggregate \+ Subquery |
| Intermediate | Multi-level Nested Query |

---

# **62\. RECOMMENDED LEARNING ORDER**

01\. SELECT  
     ↓  
02\. DISTINCT  
     ↓  
03\. WHERE  
     ↓  
04\. AND / OR / NOT  
     ↓  
05\. IN / NOT IN  
     ↓  
06\. BETWEEN  
     ↓  
07\. LIKE  
     ↓  
08\. IS NULL / IS NOT NULL  
     ↓  
09\. ORDER BY  
     ↓  
10\. LIMIT  
     ↓  
11\. Aggregate Functions  
     ↓  
12\. GROUP BY  
     ↓  
13\. HAVING  
     ↓  
14\. CASE  
     ↓  
15\. String Functions  
     ↓  
16\. Date Functions  
     ↓  
17\. Numeric Functions  
     ↓  
18\. INNER JOIN  
     ↓  
19\. LEFT JOIN  
     ↓  
20\. Multiple JOINs  
     ↓  
21\. JOIN \+ WHERE  
     ↓  
22\. JOIN \+ GROUP BY  
     ↓  
23\. JOIN \+ HAVING  
     ↓  
24\. Subqueries  
     ↓  
25\. IN / NOT IN Subqueries  
     ↓  
26\. EXISTS / NOT EXISTS  
     ↓  
27\. Correlated Subqueries  
     ↓  
28\. Nested Subqueries  
     ↓  
29\. Derived Tables  
     ↓  
30\. JOIN \+ Subquery  
     ↓  
31\. JOIN \+ Subquery \+ GROUP BY  
     ↓  
32\. JOIN \+ Subquery \+ HAVING  
     ↓  
33\. UNION / UNION ALL  
     ↓  
34\. Intermediate Business Queries  
---

# **63\. IMPORTANT MYSQL NOTES**

\-- MySQL's ONLY\_FULL\_GROUP\_BY mode can reject queries where  
\-- selected nonaggregated columns are not grouped or functionally  
\-- dependent on the GROUP BY columns.

\-- Prefer:  
\-- WHERE for filtering individual rows.  
\-- HAVING for filtering groups/aggregate results.

\-- Example:

SELECT  
customer\_id,  
SUM(total\_amount) AS total\_spent  
FROM orders  
WHERE order\_status \= 'DELIVERED'  
GROUP BY customer\_id  
HAVING SUM(total\_amount) \> 50000;

\-- Logical query processing concept:

FROM  
 ↓  
JOIN  
 ↓  
WHERE  
 ↓  
GROUP BY  
 ↓  
HAVING  
 ↓  
SELECT  
 ↓  
DISTINCT  
 ↓  
ORDER BY  
 ↓  
LIMIT  
---

# **64\. FINAL SMARTMART SQL CHECKLIST**

## **Basic SQL**

* SELECT  
* DISTINCT  
* Aliases  
* Expressions  
* WHERE  
* AND  
* OR  
* NOT  
* IN  
* NOT IN  
* BETWEEN  
* LIKE  
* IS NULL  
* IS NOT NULL  
* ORDER BY  
* LIMIT

## **Aggregation**

* COUNT  
* COUNT DISTINCT  
* SUM  
* AVG  
* MIN  
* MAX  
* GROUP BY  
* HAVING

## **Functions**

* CONCAT  
* UPPER  
* LOWER  
* LENGTH  
* SUBSTRING  
* TRIM  
* ROUND  
* CEIL  
* FLOOR  
* ABS  
* YEAR  
* MONTH  
* DAY  
* DATEDIFF  
* DATE\_FORMAT  
* COALESCE

## **Conditional Logic**

* CASE  
* WHEN  
* THEN  
* ELSE  
* END

## **Joins**

* INNER JOIN  
* LEFT JOIN  
* RIGHT JOIN  
* Multiple JOINs  
* JOIN \+ WHERE  
* JOIN \+ GROUP BY  
* JOIN \+ HAVING  
* JOIN \+ CASE

## **Subqueries**

* Scalar Subquery  
* IN Subquery  
* NOT IN Subquery  
* EXISTS  
* NOT EXISTS  
* Correlated Subquery  
* Nested Subquery  
* Derived Table

## **Set Operations**

* UNION  
* UNION ALL

## **DML**

* INSERT  
* UPDATE  
* DELETE

## **Intermediate Combinations**

* JOIN \+ Aggregate  
* JOIN \+ WHERE \+ GROUP BY  
* JOIN \+ GROUP BY \+ HAVING  
* JOIN \+ CASE \+ GROUP BY  
* JOIN \+ Subquery  
* JOIN \+ IN Subquery  
* JOIN \+ EXISTS  
* JOIN \+ Correlated Subquery  
* JOIN \+ Subquery \+ GROUP BY  
* JOIN \+ Subquery \+ HAVING  
* Derived Table \+ Aggregate  
* Derived Table \+ HAVING  
* Multiple Nested Subqueries

# **END OF SMARTMART SQL BASIC \+ INTERMEDIATE PRACTICE**

