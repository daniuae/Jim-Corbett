# MySQL Data Functions — Complete Tutorial

## 1. What are Data Functions?

Data functions are built-in MySQL functions used to manipulate different types of data.

| Category | Purpose |
|---|---|
| String functions | Work with text |
| Numeric functions | Perform mathematical operations |
| Date & Time functions | Work with dates/times |
| Conversion functions | Convert one data type into another |
| Formatting functions | Display data in a required format |
| Extraction functions | Extract parts of values |
| NULL functions | Handle missing values |
| Conditional functions | Apply business logic |
| JSON functions | Work with JSON data |
| Regular expression functions | Search and validate text |

A useful mental model:

> **Input → Transform → Extract → Format → Output**

---

# 2. String Data Functions

```sql
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'John', 'Smith', 'john.smith@gmail.com', 'IT'),
(2, 'Sarah', 'Wilson', 'sarah.wilson@gmail.com', 'HR'),
(3, 'David', 'Brown', 'david.brown@gmail.com', 'Finance'),
(4, 'Mary', 'Taylor', 'mary.taylor@gmail.com', 'IT');
```

## 2.1 LENGTH()

Returns the number of bytes in a string.

```sql
SELECT LENGTH('Hello');
```

Output:

```text
5
```

Example:

```sql
SELECT
    first_name,
    LENGTH(first_name) AS name_length
FROM employees;
```

---

## 2.2 CHAR_LENGTH()

Returns the number of characters.

```sql
SELECT CHAR_LENGTH('Hello');
```

Difference:

- `LENGTH()` counts bytes.
- `CHAR_LENGTH()` counts characters.

This matters when working with Unicode/multibyte characters.

---

## 2.3 UPPER()

Converts text to uppercase.

```sql
SELECT UPPER('mysql');
```

Output:

```text
MYSQL
```

Example:

```sql
SELECT
    first_name,
    UPPER(first_name) AS upper_name
FROM employees;
```

---

## 2.4 LOWER()

Converts text to lowercase.

```sql
SELECT LOWER('MYSQL');
```

Output:

```text
mysql
```

Example:

```sql
SELECT
    first_name,
    LOWER(first_name) AS lower_name
FROM employees;
```

---

## 2.5 CONCAT()

Combines multiple strings.

```sql
SELECT CONCAT('John', ' ', 'Smith');
```

Output:

```text
John Smith
```

Example:

```sql
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;
```

---

## 2.6 CONCAT_WS()

`WS` means **With Separator**.

```sql
SELECT CONCAT_WS('-', '2026', '08', '20');
```

Output:

```text
2026-08-20
```

Example:

```sql
SELECT
    CONCAT_WS(' ', first_name, last_name) AS full_name
FROM employees;
```

---

## 2.7 SUBSTRING()

Extracts part of a string.

Syntax:

```sql
SUBSTRING(string, start_position, length)
```

Example:

```sql
SELECT SUBSTRING('ABCDEFGHIJ', 2, 4);
```

Output:

```text
BCDE
```

Important:

> MySQL string positions start at **1**, not 0.

---

## 2.8 LEFT()

Extracts characters from the beginning.

```sql
SELECT LEFT('ABCDEFGHIJ', 4);
```

Output:

```text
ABCD
```

Example:

```sql
SELECT
    email,
    LEFT(email, 5) AS first_five
FROM employees;
```

---

## 2.9 RIGHT()

Extracts characters from the end.

```sql
SELECT RIGHT('ABCDEFGHIJ', 4);
```

Output:

```text
GHIJ
```

---

## 2.10 SUBSTRING_INDEX()

Extracts text before or after a delimiter.

For:

```text
john.smith@gmail.com
```

Extract username:

```sql
SELECT SUBSTRING_INDEX(
    'john.smith@gmail.com',
    '@',
    1
);
```

Output:

```text
john.smith
```

Extract domain:

```sql
SELECT SUBSTRING_INDEX(
    'john.smith@gmail.com',
    '@',
    -1
);
```

Output:

```text
gmail.com
```

Employee example:

```sql
SELECT
    email,
    SUBSTRING_INDEX(email, '@', 1) AS username,
    SUBSTRING_INDEX(email, '@', -1) AS domain
FROM employees;
```

---

## 2.11 TRIM()

Removes spaces from both sides.

```sql
SELECT TRIM('   Hello   ');
```

Output:

```text
Hello
```

Very useful during ETL:

```sql
SELECT
    TRIM(first_name)
FROM employees;
```

---

## 2.12 LTRIM()

Removes spaces from the left.

```sql
SELECT LTRIM('   Hello');
```

---

## 2.13 RTRIM()

Removes spaces from the right.

```sql
SELECT RTRIM('Hello   ');
```

---

## 2.14 REPLACE()

Replaces one piece of text with another.

```sql
SELECT REPLACE(
    'Hello World',
    'World',
    'MySQL'
);
```

Output:

```text
Hello MySQL
```

Example:

```sql
SELECT
    REPLACE(email, '@gmail.com', '@company.com')
FROM employees;
```

---

## 2.15 REVERSE()

```sql
SELECT REVERSE('MYSQL');
```

Output:

```text
LQSYM
```

---

## 2.16 LPAD()

Adds characters to the left.

```sql
SELECT LPAD('123', 5, '0');
```

Output:

```text
00123
```

Useful for formatting IDs:

```sql
SELECT
    LPAD(employee_id, 5, '0') AS employee_code
FROM employees;
```

---

## 2.17 RPAD()

Adds characters to the right.

```sql
SELECT RPAD('ABC', 6, '-');
```

Output:

```text
ABC---
```

---

## 2.18 LOCATE()

Finds the position of a substring.

```sql
SELECT LOCATE('@', 'john@gmail.com');
```

Output:

```text
10
```

Example:

```sql
SELECT
    email,
    LOCATE('@', email) AS at_position
FROM employees;
```

---

## 2.19 INSTR()

Similar to `LOCATE()`.

```sql
SELECT INSTR('john@gmail.com', '@');
```

---

# 3. Numeric Functions

Consider:

```sql
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT
);

INSERT INTO products VALUES
(1, 'Laptop', 74999.75, 2),
(2, 'Mouse', 799.49, 10),
(3, 'Keyboard', 1499.95, 5),
(4, 'Monitor', 15999.80, 3);
```

---

## 3.1 ROUND()

Rounds a number.

```sql
SELECT ROUND(123.4567);
```

Output:

```text
123
```

Specify decimal places:

```sql
SELECT ROUND(123.4567, 2);
```

Output:

```text
123.46
```

---

## 3.2 CEIL()

Rounds upward.

```sql
SELECT CEIL(12.1);
```

Output:

```text
13
```

---

## 3.3 FLOOR()

Rounds downward.

```sql
SELECT FLOOR(12.9);
```

Output:

```text
12
```

---

## 3.4 TRUNCATE()

Removes decimal digits without rounding.

```sql
SELECT TRUNCATE(123.4567, 2);
```

Output:

```text
123.45
```

Compare:

```sql
SELECT ROUND(123.4567, 2);
```

Result:

```text
123.46
```

```sql
SELECT TRUNCATE(123.4567, 2);
```

Result:

```text
123.45
```

---

## 3.5 ABS()

Returns absolute value.

```sql
SELECT ABS(-100);
```

Output:

```text
100
```

---

## 3.6 MOD()

Returns remainder.

```sql
SELECT MOD(10, 3);
```

Output:

```text
1
```

Alternative:

```sql
SELECT 10 % 3;
```

---

## 3.7 POWER()

```sql
SELECT POWER(2, 3);
```

Output:

```text
8
```

---

## 3.8 SQRT()

```sql
SELECT SQRT(64);
```

Output:

```text
8
```

---

# 4. Date and Time Functions

Consider:

```sql
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATETIME,
    amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(101, 1, '2026-01-15 10:30:00', 5000),
(102, 2, '2026-02-20 14:45:00', 7500),
(103, 3, '2026-03-10 09:15:00', 3200),
(104, 1, '2026-03-25 18:30:00', 9000);
```

---

## 4.1 CURRENT_DATE()

Returns today's date.

```sql
SELECT CURRENT_DATE();
```

---

## 4.2 CURRENT_TIME()

Returns current time.

```sql
SELECT CURRENT_TIME();
```

---

## 4.3 NOW()

Returns current date and time.

```sql
SELECT NOW();
```

---

## 4.4 CURDATE()

Returns current date.

```sql
SELECT CURDATE();
```

---

## 4.5 CURTIME()

Returns current time.

```sql
SELECT CURTIME();
```

---

# 5. Date Extraction Functions

Suppose:

```text
2026-08-20 10:30:45
```

## YEAR()

```sql
SELECT YEAR('2026-08-20');
```

Result:

```text
2026
```

## MONTH()

```sql
SELECT MONTH('2026-08-20');
```

Result:

```text
8
```

## DAY()

```sql
SELECT DAY('2026-08-20');
```

Result:

```text
20
```

## HOUR()

```sql
SELECT HOUR('2026-08-20 10:30:45');
```

Result:

```text
10
```

## MINUTE()

```sql
SELECT MINUTE('2026-08-20 10:30:45');
```

## SECOND()

```sql
SELECT SECOND('2026-08-20 10:30:45');
```

---

# 6. EXTRACT()

A generic date-part extraction function.

```sql
SELECT EXTRACT(YEAR FROM '2026-08-20');
```

```sql
SELECT EXTRACT(MONTH FROM '2026-08-20');
```

```sql
SELECT EXTRACT(DAY FROM '2026-08-20');
```

You can also use:

```sql
SELECT EXTRACT(
    YEAR_MONTH
    FROM '2026-08-20'
);
```

---

# 7. DAYNAME()

Returns weekday name.

```sql
SELECT DAYNAME('2026-08-20');
```

Example result:

```text
Thursday
```

---

# 8. MONTHNAME()

```sql
SELECT MONTHNAME('2026-08-20');
```

Output:

```text
August
```

---

# 9. DAYOFWEEK()

Returns numeric weekday.

```sql
SELECT DAYOFWEEK('2026-08-20');
```

---

# 10. WEEKDAY()

Returns weekday index where Monday is 0.

```sql
SELECT WEEKDAY('2026-08-20');
```

---

# 11. WEEK()

Returns week number.

```sql
SELECT WEEK('2026-08-20');
```

---

# 12. QUARTER()

Returns quarter.

```sql
SELECT QUARTER('2026-08-20');
```

Output:

```text
3
```

August belongs to Q3.

---

# 13. LAST_DAY()

Returns the last day of a month.

```sql
SELECT LAST_DAY('2026-02-10');
```

Result:

```text
2026-02-28
```

Very useful for month-end reporting.

---

# 14. DATE_ADD()

Adds time to a date.

```sql
SELECT DATE_ADD(
    '2026-08-20',
    INTERVAL 10 DAY
);
```

Output:

```text
2026-08-30
```

Months:

```sql
SELECT DATE_ADD(
    '2026-08-20',
    INTERVAL 2 MONTH
);
```

Years:

```sql
SELECT DATE_ADD(
    '2026-08-20',
    INTERVAL 1 YEAR
);
```

---

# 15. DATE_SUB()

Subtracts time.

```sql
SELECT DATE_SUB(
    '2026-08-20',
    INTERVAL 10 DAY
);
```

---

# 16. DATEDIFF()

Returns difference between two dates.

```sql
SELECT DATEDIFF(
    '2026-08-20',
    '2026-08-01'
);
```

Result:

```text
19
```

Important:

> `DATEDIFF()` works at the date level, not full time precision.

---

# 17. TIMESTAMPDIFF()

Useful when you need a specific unit.

```sql
SELECT TIMESTAMPDIFF(
    DAY,
    '2026-08-01',
    '2026-08-20'
);
```

Months:

```sql
SELECT TIMESTAMPDIFF(
    MONTH,
    '2025-08-20',
    '2026-08-20'
);
```

Years:

```sql
SELECT TIMESTAMPDIFF(
    YEAR,
    '2020-08-20',
    '2026-08-20'
);
```

---

# 18. Date Formatting — DATE_FORMAT()

One of the most important MySQL functions.

```sql
SELECT DATE_FORMAT(
    '2026-08-20',
    '%d-%m-%Y'
);
```

Output:

```text
20-08-2026
```

Common format specifiers:

| Format | Meaning | Example |
|---|---|---|
| `%Y` | 4-digit year | 2026 |
| `%y` | 2-digit year | 26 |
| `%m` | Month number | 08 |
| `%M` | Month name | August |
| `%b` | Short month | Aug |
| `%d` | Day | 20 |
| `%D` | Day with suffix | 20th |
| `%W` | Weekday name | Thursday |
| `%a` | Short weekday | Thu |
| `%H` | Hour 00–23 | 14 |
| `%h` | Hour 01–12 | 02 |
| `%i` | Minutes | 30 |
| `%s` | Seconds | 45 |
| `%p` | AM/PM | PM |

Example:

```sql
SELECT DATE_FORMAT(
    '2026-08-20 14:30:45',
    '%d %M %Y'
);
```

Output:

```text
20 August 2026
```

Another:

```sql
SELECT DATE_FORMAT(
    '2026-08-20 14:30:45',
    '%W, %d %M %Y %h:%i %p'
);
```

Output:

```text
Thursday, 20 August 2026 02:30 PM
```

---

# 19. STR_TO_DATE()

Converts a formatted string into a date/datetime value.

Input:

```text
20-08-2026
```

Convert it:

```sql
SELECT STR_TO_DATE(
    '20-08-2026',
    '%d-%m-%Y'
);
```

Result:

```text
2026-08-20
```

Another example:

```sql
SELECT STR_TO_DATE(
    '20/08/2026 14:30',
    '%d/%m/%Y %H:%i'
);
```

---

# 20. DATE() and TIME()

If:

```text
2026-08-20 14:30:45
```

then:

```sql
SELECT DATE('2026-08-20 14:30:45');
```

returns:

```text
2026-08-20
```

And:

```sql
SELECT TIME('2026-08-20 14:30:45');
```

returns:

```text
14:30:45
```

---

# 21. CAST()

`CAST()` converts one data type into another.

Syntax:

```sql
CAST(expression AS datatype)
```

## String → Integer

```sql
SELECT CAST('100' AS SIGNED);
```

Result:

```text
100
```

## String → Decimal

```sql
SELECT CAST(
    '123.45'
    AS DECIMAL(10,2)
);
```

## Number → Character

```sql
SELECT CAST(
    12345
    AS CHAR
);
```

## String → DATE

```sql
SELECT CAST(
    '2026-08-20'
    AS DATE
);
```

## DATETIME → DATE

```sql
SELECT CAST(
    '2026-08-20 14:30:00'
    AS DATE
);
```

Output:

```text
2026-08-20
```

## DATETIME → TIME

```sql
SELECT CAST(
    '2026-08-20 14:30:00'
    AS TIME
);
```

Output:

```text
14:30:00
```

---

# 22. CONVERT()

MySQL also provides `CONVERT()`.

Syntax:

```sql
CONVERT(expression, datatype)
```

Example:

```sql
SELECT CONVERT(
    '123',
    SIGNED
);
```

Date:

```sql
SELECT CONVERT(
    '2026-08-20',
    DATE
);
```

---

# 23. CAST vs CONVERT

| CAST | CONVERT |
|---|---|
| Standard SQL syntax | MySQL-specific syntax available |
| `CAST(x AS type)` | `CONVERT(x, type)` |
| More portable | Convenient in MySQL |
| Easy to teach | Useful in MySQL |

For teaching:

> Prefer `CAST()` when portability matters.

---

# 24. Formatting Numbers — FORMAT()

Example:

```sql
SELECT FORMAT(
    1234567.89,
    2
);
```

Result:

```text
1,234,567.89
```

This is primarily a **presentation function**.

Example:

```sql
SELECT
    product_name,
    FORMAT(price, 2) AS formatted_price
FROM products;
```

---

# 25. ROUND vs FORMAT

```sql
SELECT ROUND(1234567.891, 2);
```

Produces a numeric result:

```text
1234567.89
```

Whereas:

```sql
SELECT FORMAT(1234567.891, 2);
```

Produces formatted text:

```text
1,234,567.89
```

Important distinction:

> **ROUND = calculation**

> **FORMAT = presentation**

---

# 26. NULL Functions

NULL means missing, unknown, or unavailable value.

Consider:

```sql
CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(100),
    phone VARCHAR(20)
);

INSERT INTO customers VALUES
(1, 'John', '9876543210'),
(2, 'Sarah', NULL),
(3, 'David', '9123456780');
```

---

## 26.1 IFNULL()

```sql
SELECT
    customer_name,
    IFNULL(phone, 'Not Available') AS phone
FROM customers;
```

---

## 26.2 COALESCE()

Returns the first non-NULL value.

```sql
SELECT COALESCE(
    NULL,
    NULL,
    'Hello',
    'World'
);
```

Output:

```text
Hello
```

Real-world:

```sql
SELECT
    customer_name,
    COALESCE(
        phone,
        'Not Available'
    ) AS phone
FROM customers;
```

---

## 26.3 NULLIF()

Returns NULL if two values are equal.

```sql
SELECT NULLIF(10, 10);
```

Result:

```text
NULL
```

Otherwise:

```sql
SELECT NULLIF(10, 20);
```

Result:

```text
10
```

Useful for avoiding division by zero:

```sql
SELECT
    sales / NULLIF(quantity, 0)
FROM sales;
```

---

# 27. Conditional Functions

## IF()

```sql
SELECT
    employee_id,
    IF(
        department = 'IT',
        'Technical',
        'Non-Technical'
    ) AS employee_type
FROM employees;
```

---

## CASE

For more complex business logic, use `CASE`.

```sql
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 50000 THEN 'Expensive'
        WHEN price >= 10000 THEN 'Medium'
        ELSE 'Affordable'
    END AS price_category
FROM products;
```

---

# 28. GREATEST()

Returns largest value.

```sql
SELECT GREATEST(10, 50, 20);
```

Output:

```text
50
```

---

# 29. LEAST()

```sql
SELECT LEAST(10, 50, 20);
```

Output:

```text
10
```

---

# 30. UUID()

Generates a UUID.

```sql
SELECT UUID();
```

Useful when generating unique identifiers.

---

# 31. JSON Functions

Modern MySQL applications frequently use JSON.

Example:

```sql
CREATE TABLE customers_json (
    customer_id INT,
    customer_data JSON
);

INSERT INTO customers_json VALUES
(
    1,
    '{"name":"John","age":30,"city":"Chennai"}'
);
```

---

## 31.1 JSON_EXTRACT()

```sql
SELECT JSON_EXTRACT(
    customer_data,
    '$.name'
)
FROM customers_json;
```

---

## 31.2 JSON_UNQUOTE()

```sql
SELECT JSON_UNQUOTE(
    JSON_EXTRACT(
        customer_data,
        '$.name'
    )
)
FROM customers_json;
```

Output:

```text
John
```

Shortcut:

```sql
SELECT
    customer_data ->> '$.name'
FROM customers_json;
```

---

## 31.3 JSON_OBJECT()

Creates JSON.

```sql
SELECT JSON_OBJECT(
    'name', 'John',
    'age', 30,
    'city', 'Chennai'
);
```

---

## 31.4 JSON_ARRAY()

```sql
SELECT JSON_ARRAY(
    'SQL',
    'Python',
    'Spark'
);
```

---

# 32. Regular Expressions

MySQL supports regular expression operations.

Find Gmail addresses:

```sql
SELECT
    email
FROM employees
WHERE email REGEXP '@gmail\\.com$';
```

Find names beginning with J:

```sql
SELECT *
FROM employees
WHERE first_name REGEXP '^J';
```

Find names ending with n:

```sql
SELECT *
FROM employees
WHERE first_name REGEXP 'n$';
```

---

# 33. Important Data Extraction Patterns

## Extract domain from email

```sql
SELECT
    SUBSTRING_INDEX(email, '@', -1)
FROM employees;
```

## Extract username

```sql
SELECT
    SUBSTRING_INDEX(email, '@', 1)
FROM employees;
```

## Extract year from date

```sql
SELECT YEAR(order_date)
FROM orders;
```

## Extract month

```sql
SELECT MONTH(order_date)
FROM orders;
```

## Extract month name

```sql
SELECT MONTHNAME(order_date)
FROM orders;
```

## Extract quarter

```sql
SELECT QUARTER(order_date)
FROM orders;
```

## Extract weekday

```sql
SELECT DAYNAME(order_date)
FROM orders;
```

## Extract date from datetime

```sql
SELECT DATE(order_date)
FROM orders;
```

## Extract time from datetime

```sql
SELECT TIME(order_date)
FROM orders;
```

---

# 34. Practical Data Transformation

Suppose we receive messy customer data:

```text
'   JOHN SMITH   '
```

We can clean it:

```sql
SELECT
    UPPER(
        TRIM('   john smith   ')
    );
```

Result:

```text
JOHN SMITH
```

Another example:

```sql
SELECT
    LOWER(
        TRIM(email)
    )
FROM employees;
```

This is a typical ETL transformation.

---

# 35. Combining Multiple Functions

The real power comes from combining functions.

Example:

```sql
SELECT
    UPPER(
        SUBSTRING_INDEX(
            email,
            '@',
            1
        )
    ) AS username
FROM employees;
```

For:

```text
john.smith@gmail.com
```

Result:

```text
JOHN.SMITH
```

---

# 36. Data Cleaning Example

Suppose source data contains:

```text
'  John Smith  '
```

We want:

```text
JOHN SMITH
```

Query:

```sql
SELECT
    UPPER(
        TRIM(customer_name)
    ) AS cleaned_name
FROM customers;
```

Pipeline:

```text
Raw Data
   ↓
TRIM()
   ↓
UPPER()
   ↓
Clean Data
```

---

# 37. Date Transformation Example

Suppose:

```text
2026-08-20 14:35:22
```

We want:

```text
August 2026
```

Query:

```sql
SELECT
    DATE_FORMAT(
        order_date,
        '%M %Y'
    ) AS month_year
FROM orders;
```

Output:

```text
August 2026
```

---

# 38. Monthly Revenue Example

This is important for analytics.

```sql
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(amount) AS revenue
FROM orders
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m');
```

Example result:

```text
month       revenue
----------  -------
2026-01     5000
2026-02     7500
2026-03     12200
```

---

# 39. Year and Month Separately

```sql
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(amount) AS revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date);
```

---

# 40. First Day of Month

A common reporting requirement.

```sql
SELECT
    DATE_FORMAT(
        order_date,
        '%Y-%m-01'
    ) AS month_start
FROM orders;
```

A date-arithmetic approach:

```sql
SELECT
    DATE_SUB(
        DATE(order_date),
        INTERVAL DAYOFMONTH(order_date) - 1 DAY
    ) AS month_start
FROM orders;
```

---

# 41. Last Day of Month

```sql
SELECT
    LAST_DAY(order_date) AS month_end
FROM orders;
```

---

# 42. Age Calculation

Suppose:

```text
birth_date = '1990-05-10'
```

Age:

```sql
SELECT TIMESTAMPDIFF(
    YEAR,
    '1990-05-10',
    CURDATE()
) AS age;
```

This is better than simply doing:

```sql
YEAR(CURDATE()) - YEAR(birth_date)
```

because `TIMESTAMPDIFF()` handles whether the birthday has occurred this year.

---

# 43. Days Since Order

```sql
SELECT
    order_id,
    DATEDIFF(
        CURDATE(),
        DATE(order_date)
    ) AS days_since_order
FROM orders;
```

---

# 44. Orders from Last 30 Days

```sql
SELECT *
FROM orders
WHERE order_date >=
      DATE_SUB(NOW(), INTERVAL 30 DAY);
```

---

# 45. Current Month

```sql
SELECT *
FROM orders
WHERE YEAR(order_date) = YEAR(CURDATE())
  AND MONTH(order_date) = MONTH(CURDATE());
```

A range-based approach can be preferable for indexed datetime columns:

```sql
SELECT *
FROM orders
WHERE order_date >=
      DATE_FORMAT(CURDATE(), '%Y-%m-01')
  AND order_date <
      DATE_FORMAT(
          DATE_ADD(CURDATE(), INTERVAL 1 MONTH),
          '%Y-%m-01'
      );
```

---

# 46. Conversion vs Formatting vs Extraction

This distinction is extremely important.

| Operation | Question | Functions |
|---|---|---|
| Conversion | What data type should this become? | `CAST`, `CONVERT` |
| Formatting | How should it be displayed? | `DATE_FORMAT`, `FORMAT` |
| Extraction | What part do I need? | `YEAR`, `MONTH`, `DAY`, `SUBSTRING` |
| Cleaning | How do I remove/replace unwanted data? | `TRIM`, `REPLACE` |
| Calculation | What value should I calculate? | `ROUND`, `ABS`, `DATEDIFF` |
| Conditional | What value depends on a condition? | `IF`, `CASE` |
| NULL handling | What should happen if value is NULL? | `COALESCE`, `IFNULL`, `NULLIF` |

---

# 47. One Important Teaching Model

### Requirement:

> Convert `"123.45"` into a number.

Think:

```text
Conversion
   ↓
CAST()
```

```sql
SELECT CAST('123.45' AS DECIMAL(10,2));
```

### Requirement:

> Display 1234567.89 as 1,234,567.89.

Think:

```text
Formatting
   ↓
FORMAT()
```

```sql
SELECT FORMAT(1234567.89, 2);
```

### Requirement:

> Extract the year from order_date.

Think:

```text
Extraction
   ↓
YEAR()
```

```sql
SELECT YEAR(order_date);
```

### Requirement:

> Remove spaces around customer name.

Think:

```text
Cleaning
   ↓
TRIM()
```

### Requirement:

> Replace Gmail with company email.

Think:

```text
Transformation
   ↓
REPLACE()
```

---

# 48. Function Decision Map

```text
                DATA
                  |
        +---------+---------+
        |         |         |
      TEXT      NUMBER     DATE
        |         |         |
   +----+----+    |    +----+-----+
   |    |    |    |    |    |     |
TRIM UPPER SUBSTRING ROUND YEAR MONTH
   |    |    |         |    |     |
REPLACE CONCAT       FORMAT DAY  QUARTER
```

Another useful decision model:

```text
Need to change datatype?
        ↓
     CAST()

Need presentation format?
        ↓
 DATE_FORMAT()
 FORMAT()

Need a portion?
        ↓
 SUBSTRING()
 YEAR()
 MONTH()

Need calculation?
        ↓
 ROUND()
 ABS()
 DATEDIFF()
 TIMESTAMPDIFF()

Need missing-value handling?
        ↓
 COALESCE()
 IFNULL()
 NULLIF()

Need business logic?
        ↓
 CASE
 IF
```

---

# 49. Most Important Functions to Master

## Tier 1 — Must Know

```text
CONCAT
CONCAT_WS
UPPER
LOWER
TRIM
SUBSTRING
SUBSTRING_INDEX
REPLACE
ROUND
CAST
CONVERT
DATE
TIME
YEAR
MONTH
DAY
DATE_FORMAT
STR_TO_DATE
DATE_ADD
DATE_SUB
DATEDIFF
TIMESTAMPDIFF
COALESCE
IFNULL
CASE
```

## Tier 2 — Very Useful

```text
LEFT
RIGHT
LENGTH
CHAR_LENGTH
LOCATE
INSTR
LPAD
RPAD
CEIL
FLOOR
TRUNCATE
ABS
MOD
QUARTER
WEEK
DAYNAME
MONTHNAME
LAST_DAY
NULLIF
GREATEST
LEAST
```

## Tier 3 — Advanced

```text
REGEXP
REGEXP_LIKE
JSON_EXTRACT
JSON_OBJECT
JSON_ARRAY
JSON_UNQUOTE
UUID
```

---

# 50. Real-World Data Transformation Pipeline

A realistic SQL transformation:

```sql
SELECT
    employee_id,

    UPPER(
        TRIM(
            CONCAT(first_name, ' ', last_name)
        )
    ) AS employee_name,

    LOWER(
        TRIM(email)
    ) AS email,

    SUBSTRING_INDEX(
        LOWER(TRIM(email)),
        '@',
        -1
    ) AS email_domain

FROM employees;
```

Transformations:

```text
first_name
      +
last_name
      ↓
CONCAT()
      ↓
TRIM()
      ↓
UPPER()
      ↓
employee_name
```

And:

```text
email
 ↓
TRIM()
 ↓
LOWER()
 ↓
SUBSTRING_INDEX()
 ↓
email_domain
```

This is close to what you encounter in ETL/data engineering pipelines.

---

# 51. Practical Master Example

Suppose we have:

```text
Order Date:
2026-08-20 14:35:42

Customer:
"  john smith  "

Email:
" JOHN.SMITH@GMAIL.COM "

Amount:
1234567.891
```

We want:

```text
Customer Name: John Smith
Email: john.smith@gmail.com
Domain: gmail.com
Order Date: 20-Aug-2026
Month: August
Year: 2026
Amount: 1,234,567.89
```

Query:

```sql
SELECT

    CONCAT(
        UPPER(LEFT(TRIM('  john smith  '), 1)),
        LOWER(
            SUBSTRING(
                TRIM('  john smith  '),
                2
            )
        )
    ) AS customer_name,

    LOWER(
        TRIM(' JOHN.SMITH@GMAIL.COM ')
    ) AS email,

    SUBSTRING_INDEX(
        LOWER(
            TRIM(' JOHN.SMITH@GMAIL.COM ')
        ),
        '@',
        -1
    ) AS domain,

    DATE_FORMAT(
        '2026-08-20 14:35:42',
        '%d-%b-%Y'
    ) AS order_date,

    MONTHNAME(
        '2026-08-20'
    ) AS month_name,

    YEAR(
        '2026-08-20'
    ) AS order_year,

    FORMAT(
        1234567.891,
        2
    ) AS amount;
```

This demonstrates:

```text
Cleaning
   ↓
TRIM()

Case transformation
   ↓
UPPER() / LOWER()

String extraction
   ↓
SUBSTRING()
SUBSTRING_INDEX()

Date extraction
   ↓
YEAR()
MONTHNAME()

Date formatting
   ↓
DATE_FORMAT()

Number formatting
   ↓
FORMAT()
```

---

# 52. Golden Rule for Data Functions

When solving SQL problems, don't start by memorizing functions.

First identify **what transformation is required**.

Use this thought process:

```text
What is my input?
       ↓
What should my output look like?
       ↓
Is this:
       |
       +-- Conversion?
       |
       +-- Formatting?
       |
       +-- Extraction?
       |
       +-- Cleaning?
       |
       +-- Calculation?
       |
       +-- Conditional logic?
       |
       +-- NULL handling?
       ↓
Choose the appropriate function
```

The key distinctions are:

> **CAST changes the data type.**

> **FORMAT changes how the value is displayed.**

> **EXTRACT/YEAR/MONTH/SUBSTRING obtains a portion of the value.**

> **TRIM/REPLACE cleans or transforms the value.**

> **DATE_ADD/ROUND/ABS/DATEDIFF calculates a new value.**
