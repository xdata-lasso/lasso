-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'res', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT QUERY_NAME, RATING, POSITION, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS RATING_MIN_COUNT FROM QUERIES) SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(QUERY_NAME), 2) AS QUALITY, ROUND((CAST(SUM(RATING_MIN_COUNT) AS REAL) / COUNT(RATING)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM CTE GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, None, 0.0)
*/