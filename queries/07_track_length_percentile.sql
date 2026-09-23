-- Day 5
-- Business question: How does each track's length compare to others in its genre?
-- Demonstrates: window functions NTILE() and PERCENT_RANK()
-- Useful for: catalog analysis, flagging unusually short/long tracks.

SELECT
    g.Name AS genre,
    t.Name AS track_name,
    t.Milliseconds / 1000.0 AS length_seconds,
    NTILE(4) OVER (PARTITION BY g.GenreId ORDER BY t.Milliseconds) AS length_quartile,
    ROUND(PERCENT_RANK() OVER (PARTITION BY g.GenreId ORDER BY t.Milliseconds), 3) AS pct_rank_in_genre
FROM Track t
JOIN Genre g ON g.GenreId = t.GenreId
ORDER BY genre, length_seconds;
