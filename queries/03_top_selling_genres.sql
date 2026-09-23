-- Day 3
-- Business question: Which music genres generate the most revenue?
-- Useful for: catalog/inventory decisions, marketing focus.

SELECT
    g.Name AS genre,
    COUNT(il.InvoiceLineId) AS tracks_sold,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS revenue
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
JOIN Genre g ON g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY revenue DESC;
