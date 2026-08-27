SOLUTIONS
Now the student should stop looking at the previous section.

Solutions 1–10
1
SELECT customer_id, customer_name
FROM customers;
salary does not exist in customers.

2
SELECT *
FROM customers
WHERE country = 'India';

3
SELECT *
FROM products
WHERE price > 500
AND price < 1000;

4
SELECT *
FROM products
WHERE price BETWEEN 500 AND 1000;

5
SELECT *
FROM customers
WHERE country IN ('India', 'USA');

6
SELECT *
FROM customers
WHERE customer_name LIKE 'A%';

7
SELECT *
FROM customers
WHERE sales_rep_id IS NULL;

8
SELECT DISTINCT city
FROM customers;

9
SELECT customer_name, city
FROM customers
ORDER BY city DESC;

10
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;

Solutions 11–20
11
SELECT *
FROM products
WHERE (category = 'Electronics'
       OR category = 'Furniture')
AND price > 1000;

12
SELECT *
FROM customers
WHERE country = 'India'
AND segment IN ('Consumer', 'Corporate');

13
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 1000 THEN 'Expensive'
        WHEN price >= 500 THEN 'Medium'
        ELSE 'Cheap'
    END AS price_category
FROM products;

14
SELECT
    product_name,
    price,
    cost,
    price - cost AS profit
FROM products;

15
SELECT COUNT(*) AS customer_count
FROM customers;

16
SELECT SUM(price) AS total_price
FROM products
WHERE category = 'Electronics';

17
SELECT
    category,
    AVG(price) AS avg_price
FROM products
GROUP BY category;

18
SELECT
    category,
    AVG(price) AS avg_price
FROM products
GROUP BY category;

19
SELECT
    category,
    AVG(price) AS avg_price
FROM products
GROUP BY category
HAVING AVG(price) > 1000;

20
SELECT
    category,
    COUNT(*) AS product_count
FROM products
WHERE category = 'Electronics'
GROUP BY category
HAVING COUNT(*) > 5;

Solutions 21–30
21
SELECT
    c.customer_name,
    o.order_id
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

22
SELECT
    c.customer_name,
    o.order_id
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
AND c.country IN ('India', 'USA');

23
SELECT
    c.customer_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;

24
SELECT
    c.customer_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;

25
SELECT
    c.customer_name,
    o.order_id,
    oi.quantity
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON oi.order_id = o.order_id;

26
SELECT
    o.order_id,
    p.product_name,
    oi.quantity
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;

27
SELECT
    c.customer_name,
    o.order_id,
    p.product_name,
    oi.quantity
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON p.product_id = oi.product_id
WHERE oi.quantity > 0;

28
SELECT
    c.customer_name,
    COUNT(o.order_id) AS orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2;

29
SELECT
    c.country,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.country;

30
SELECT
    e.employee_name,
    d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;

Solutions 31–40
31
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

32
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

33
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

34
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);
A safer version when NULLs might exist:
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

35
SELECT *
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);

36
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name;

37
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name;

38
The original is actually valid MySQL.
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) > 10000;

39
SELECT
    customer_id,
    SUM(CASE
        WHEN status = 'Completed' THEN 1
        ELSE 0
    END) AS completed_orders
FROM orders
GROUP BY customer_id;

40
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-01-01' AND '2026-01-31'
AND shipping_date > order_date;

Solutions 41–50
41
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(*) AS orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY year, month;

42
SELECT
    YEAR(order_date) AS order_year,
    COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(order_date);

43
SELECT
    product_name,
    price,
    cost,
    price - cost AS margin
FROM products;

44
SELECT
    product_id,
    quantity * unit_price AS gross_sales,
    quantity * unit_price
      * (1 - discount / 100) AS net_sales
FROM order_items;

45
SELECT COUNT(DISTINCT customer_id) AS customer_count
FROM orders;

46
SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;

47
SELECT
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

48
SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) > 2;

49
SELECT
    e.employee_name,
    m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;

50
SELECT
    e.employee_name,
    m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;

Solutions 51–60
51
SELECT
    d.department_name,
    AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name
HAVING AVG(e.salary) > 50000;

52
SELECT d.department_name
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

53
SELECT
    c.customer_name,
    p.product_name
FROM customers c
CROSS JOIN products p;

54
MySQL-compatible simulation:
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id

UNION

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM orders o
LEFT JOIN customers c
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

55
SELECT customer_id
FROM customers

UNION

SELECT customer_id
FROM orders;

56
SELECT customer_id
FROM customers

UNION ALL

SELECT customer_id
FROM orders;

57
MySQL-compatible approach:
SELECT DISTINCT c.customer_id
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

58
SELECT *
FROM products p
WHERE price > (
    SELECT AVG(x.price)
    FROM products x
    WHERE x.category = p.category
);

59
SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(x.salary)
    FROM employees x
    WHERE x.department_id = e.department_id
);

60
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

Solutions 61–70
61
SELECT *
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);

62
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

63
Simple solution:
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);
Window solution:
SELECT salary
FROM (
    SELECT
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) x
WHERE rnk = 2;

64
SELECT
    employee_name,
    salary,
    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS rn
FROM employees;

65
SELECT
    employee_name,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

66
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;

67
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;

68
SELECT *
FROM (
    SELECT
        employee_name,
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
) x
WHERE salary_rank <= 3;

69
SELECT
    order_id,
    order_date,
    LAG(order_date) OVER (
        ORDER BY order_date
    ) AS previous_date
FROM orders;

70
SELECT
    order_date,
    SUM(total_sales) OVER (
        ORDER BY order_date
    ) AS running_sales
FROM daily_sales;
Here daily_sales must first exist as a table/CTE. For our schema:
WITH daily_sales AS (
    SELECT
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY order_date
    ) AS running_sales
FROM daily_sales;

Solutions 71–80
71
SELECT *
FROM (
    SELECT
        employee_name,
        department_id,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) x
WHERE rnk <= 3;

72
SELECT *
FROM (
    SELECT
        employee_name,
        department_id,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) x
WHERE rnk <= 3;

73
SELECT *
FROM (
    SELECT
        product_name,
        category,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY price DESC
        ) AS rn
    FROM products
) x
WHERE rn = 1;

74
SELECT
    product_name,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM (
    SELECT
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_name
) x;

75
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS rnk
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name;

76
WITH daily_sales AS (
    SELECT
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    daily_sales,
    LAG(daily_sales) OVER (
        ORDER BY order_date
    ) AS previous_sales,
    daily_sales -
        LAG(daily_sales) OVER (
            ORDER BY order_date
        ) AS sales_difference
FROM daily_sales;

77
SELECT
    order_date,
    LEAD(order_date) OVER (
        ORDER BY order_date
    ) AS next_order_date
FROM orders;

78
WITH daily_sales AS (
    SELECT
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    daily_sales,
    SUM(daily_sales) OVER (
        ORDER BY order_date
    ) AS running_sales
FROM daily_sales;

79
WITH daily_sales AS (
    SELECT
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    daily_sales,
    AVG(daily_sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN 7 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM daily_sales;

80
WITH customer_sales AS (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
SELECT *
FROM customer_sales;

Solutions 81–90
81
WITH customer_sales AS (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
SELECT *
FROM customer_sales
WHERE total_sales > 10000;

82
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY customer_id
)
SELECT *
FROM customer_sales
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM customer_sales
);

83
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    *,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS rnk
FROM customer_sales;

84
SELECT
    employee_name,
    department_id,
    salary,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS dept_avg
FROM employees;

85
SELECT
    employee_name,
    department_id,
    salary,
    salary -
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS difference
FROM employees;

86
SELECT
    employee_name,
    department_id,
    salary,
    salary /
    SUM(salary) OVER (
        PARTITION BY department_id
    ) * 100 AS salary_percentage
FROM employees;

87
SELECT
    customer_name,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_name
HAVING COUNT(*) > 1;
If customer_id itself is the duplicate business key, investigate the data model because it is defined as a primary key.

88
SELECT *
FROM (
    SELECT
        customer_name,
        ROW_NUMBER() OVER (
            PARTITION BY customer_name
            ORDER BY customer_id
        ) AS rn
    FROM customers
) x
WHERE rn > 1;

89
SELECT
    customer_id,
    order_id,
    order_date
FROM (
    SELECT
        customer_id,
        order_id,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC, order_id DESC
        ) AS rn
    FROM orders
) x
WHERE rn = 1;

90
SELECT *
FROM (
    SELECT
        employee_name,
        department_id,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) x
WHERE rnk = 2;

Solutions 91–100
91
For reliable LAST_VALUE, explicitly define the window frame:
SELECT
    customer_id,
    order_date,

    FIRST_VALUE(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS first_order,

    LAST_VALUE(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
    ) AS last_order

FROM orders;

92
SELECT
    customer_id,
    COUNT(*) AS orders
FROM orders
GROUP BY customer_id;
Every order is naturally between the customer's minimum and maximum order date.

93
SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS order_number
FROM orders;

94
In MySQL, use a CTE because the window result should be calculated first:
WITH x AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date
    FROM orders
)
SELECT
    customer_id,
    order_date,
    DATEDIFF(
        order_date,
        previous_order_date
    ) AS days_between
FROM x;

95
Since order_value doesn't exist, first calculate it.
WITH order_values AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_id,
        o.customer_id,
        o.order_date
),
x AS (
    SELECT
        *,
        LAG(order_value) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS previous_value
    FROM order_values
)
SELECT *
FROM x
WHERE previous_value IS NOT NULL
AND order_value > previous_value;

96
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 1;

97
WITH category_sales AS (
    SELECT
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category
)
SELECT
    category,
    revenue,
    revenue /
        SUM(revenue) OVER () * 100 AS percentage
FROM category_sales;

98
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.country,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.country
),
ranked AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY country
            ORDER BY revenue DESC
        ) AS rnk
    FROM customer_sales
)
SELECT *
FROM ranked
WHERE rnk <= 3;
For the country percentage:
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.country,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.country
),
ranked AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY country
            ORDER BY revenue DESC
        ) AS rnk,
        SUM(revenue) OVER (
            PARTITION BY country
        ) AS country_revenue
    FROM customer_sales
)
SELECT
    customer_name,
    country,
    revenue,
    rnk,
    revenue / country_revenue * 100 AS country_percentage
FROM ranked
WHERE rnk <= 3;

99
The two averages in the original are identical. The second condition should be company-wide.
SELECT
    employee_name,
    department_id,
    salary
FROM employees e
WHERE salary > (
    SELECT AVG(x.salary)
    FROM employees x
    WHERE x.department_id = e.department_id
)
AND salary > (
    SELECT AVG(salary)
    FROM employees
);

Q100 — Complete Solution
This is the capstone query.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.country,
        SUM(
            oi.quantity * oi.unit_price
        ) AS revenue
    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        c.customer_id,
        c.customer_name,
        c.country
),

ranked AS (
    SELECT
        customer_id,
        customer_name,
        country,
        revenue,

        RANK() OVER (
            PARTITION BY country
            ORDER BY revenue DESC
        ) AS country_rank,

        SUM(revenue) OVER (
            PARTITION BY country
        ) AS country_total

    FROM customer_sales
)

SELECT
    customer_id,
    customer_name,
    country,
    revenue,
    country_rank,

    ROUND(
        revenue / country_total * 100,
        2
    ) AS country_percentage

FROM ranked

WHERE country_rank <= 3

ORDER BY
    country,
    country_rank;

What This 100-Query Set Actually Tests
The trainee is not merely practicing 100 random queries.
It deliberately builds this progression:
SELECT
  ↓
WHERE
  ↓
Operators
  ↓
AND / OR / NOT
  ↓
IN / BETWEEN / LIKE
  ↓
NULL
  ↓
CASE
  ↓
ORDER BY / LIMIT
  ↓
Aggregations
  ↓
GROUP BY
  ↓
HAVING
  ↓
INNER JOIN
  ↓
LEFT JOIN
  ↓
RIGHT JOIN
  ↓
SELF JOIN
  ↓
CROSS JOIN
  ↓
Multi-table JOIN
  ↓
JOIN + GROUP BY
  ↓
Subquery
  ↓
Correlated Subquery
  ↓
EXISTS / NOT EXISTS
  ↓
UNION
  ↓
CTE
  ↓
ROW_NUMBER
  ↓
RANK
  ↓
DENSE_RANK
  ↓
PARTITION BY
  ↓
LAG / LEAD
  ↓
Running Total
  ↓
Moving Average
  ↓
Top-N
  ↓
Aggregation + Window
  ↓
JOIN + Window
  ↓
CTE + Window
  ↓
Multi-level Analytical SQL
Error-training model
For each question, make the trainee follow this sequence:
1. READ THE BUSINESS REQUIREMENT
             ↓
2. READ THE SQL
             ↓
3. PREDICT THE EXPECTED RESULT
             ↓
4. FIND THE ERROR
             ↓
5. CLASSIFY THE ERROR
             ↓
   ┌─────────┼─────────┐
   ↓         ↓         ↓
 SYNTAX    LOGIC    SEMANTIC
   ↓         ↓         ↓
6. FIX IT
             ↓
7. RUN IT
             ↓
8. VALIDATE THE RESULT
The three error types
Error
Meaning
Example
Syntax
SQL grammar is invalid
GROUP category
Logic
SQL runs but gives wrong result
ORDER BY salary ASC for highest salary
Semantic
SQL doesn't represent the intended business meaning
joining product_id to order_id

For your trainee, the most valuable ones are actually the LOGIC and SEMANTIC errors. Syntax errors are relatively easy for an IDE to expose; the harder professional skill is looking at a query that successfully executes but produces the wrong business answer.

If you want, I can:
Generate next 5 practice SQL queries
Summarize key SQL error types and examples
Explain common SQL error correction strategies
https://chatgpt.com/s/t_6a8e6a27a1c88191b93389752cdd895a

