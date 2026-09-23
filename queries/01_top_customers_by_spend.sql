-- Day 2
-- Business question: Who are our top 10 customers by total lifetime spend?
-- Useful for: identifying VIP customers for retention/loyalty programs.

SELECT
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS customer_name,
    c.Country,
    COUNT(DISTINCT i.InvoiceId) AS num_orders,
    ROUND(SUM(i.Total), 2) AS total_spend
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId, customer_name, c.Country
ORDER BY total_spend DESC
LIMIT 10;
