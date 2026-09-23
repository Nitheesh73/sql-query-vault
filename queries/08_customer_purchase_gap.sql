-- Day 5
-- Business question: How many days pass between each customer's consecutive purchases?
-- Demonstrates: window function LAG() for gap/churn analysis.
-- Useful for: flagging customers going quiet (rising churn risk).

WITH ordered_invoices AS (
    SELECT
        CustomerId,
        InvoiceDate,
        LAG(InvoiceDate) OVER (
            PARTITION BY CustomerId
            ORDER BY InvoiceDate
        ) AS prev_invoice_date
    FROM Invoice
)
SELECT
    CustomerId,
    InvoiceDate,
    prev_invoice_date,
    CAST(julianday(InvoiceDate) - julianday(prev_invoice_date) AS INTEGER) AS days_since_last_purchase
FROM ordered_invoices
WHERE prev_invoice_date IS NOT NULL
ORDER BY CustomerId, InvoiceDate;
