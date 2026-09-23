-- Day 3
-- Business question: For each customer, what's their cumulative spend over time?
-- Demonstrates: window function SUM() OVER (PARTITION BY ... ORDER BY ...)
-- Useful for: tracking customer lifetime value growth, cohort analysis.

WITH customer_invoices AS (
    SELECT
        c.CustomerId,
        c.FirstName || ' ' || c.LastName AS customer_name,
        i.InvoiceDate,
        i.Total
    FROM Customer c
    JOIN Invoice i ON i.CustomerId = c.CustomerId
)
SELECT
    CustomerId,
    customer_name,
    InvoiceDate,
    Total,
    ROUND(SUM(Total) OVER (
        PARTITION BY CustomerId
        ORDER BY InvoiceDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS running_total
FROM customer_invoices
ORDER BY CustomerId, InvoiceDate;
