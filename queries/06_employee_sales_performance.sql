-- Day 4
-- Business question: How do our sales support reps rank by revenue generated?
-- Demonstrates: window function RANK() OVER (ORDER BY ...)
-- Useful for: performance reviews, incentive planning.

WITH rep_sales AS (
    SELECT
        e.EmployeeId,
        e.FirstName || ' ' || e.LastName AS rep_name,
        ROUND(SUM(i.Total), 2) AS total_sales
    FROM Employee e
    JOIN Customer c ON c.SupportRepId = e.EmployeeId
    JOIN Invoice i ON i.CustomerId = c.CustomerId
    GROUP BY e.EmployeeId, rep_name
)
SELECT
    rep_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM rep_sales
ORDER BY sales_rank;
