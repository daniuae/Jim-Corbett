SELECT category_id, category_name, description FROM categories;

SELECT
    product_id,
    product_name,
    category_id,
    price,
    stock_quantity,
    product_status
FROM products;

SELECT
    product_id,
    product_name,
    category_id,
    price,
    stock_quantity,
    product_status
FROM products;

SELECT
    payment_id,
    order_id,
    amount,
    ROW_NUMBER() OVER (
        ORDER BY payment_date
    ) AS row_num
FROM payments;

-- SELECT
--     payment_id,
--     payment_method,
--     amount,
--     ROW_NUMBER() OVER (
--         PARTITION BY
--             payment_method
--         ORDER BY amount DESC
--     ) AS payment_rank
-- FROM payments;

SELECT
    payment_id,
    amount,
    RANK() OVER (
        ORDER BY amount DESC
    ) AS payment_rank
FROM payments;

SELECT
    payment_id,
    amount,
    DENSE_RANK() OVER (
        ORDER BY amount DESC
    ) AS payment_rank
FROM payments;

SELECT
    payment_id,
    payment_date,
    amount,
    LAG(amount) OVER (
        ORDER BY payment_date
    ) AS previous_payment
FROM payments;

SELECT
    payment_id,
    payment_date,
    amount,
    LEAD(amount) OVER (
        ORDER BY payment_date
    ) AS next_payment
FROM payments;

SELECT
    payment_id,
    payment_date,
    amount,
    FIRST_VALUE(amount) OVER (
        ORDER BY payment_date
    ) AS first_payment
FROM payments;

SELECT
    payment_id,
    payment_date,
    amount,
    LAST_VALUE(amount) OVER (
        ORDER BY
            payment_date ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
    ) AS last_payment
FROM payments;
