-- Day 2
-- Business question: What does our monthly revenue trend look like over time?
-- Useful for: spotting seasonality, growth/decline, reporting to leadership.

SELECT
    strftime('%Y-%m', InvoiceDate) AS year_month,
    COUNT(*) AS num_invoices,
    ROUND(SUM(Total), 2) AS monthly_revenue
FROM Invoice
GROUP BY year_month
ORDER BY year_month;
