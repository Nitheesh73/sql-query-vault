-- Day 4
-- Business question: How many of our customers are repeat buyers vs. one-time?
-- Demonstrates: CTE + CASE classification.
-- Useful for: retention analysis, understanding customer loyalty mix.

WITH order_counts AS (
    SELECT
        CustomerId,
        COUNT(InvoiceId) AS num_orders
    FROM Invoice
    GROUP BY CustomerId
),
classified AS (
    SELECT
        CustomerId,
        num_orders,
        CASE
            WHEN num_orders = 1 THEN 'one-time'
            ELSE 'repeat'
        END AS customer_type
    FROM order_counts
)
SELECT
    customer_type,
    COUNT(*) AS num_customers,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM order_counts), 1) AS pct_of_customers
FROM classified
GROUP BY customer_type;
