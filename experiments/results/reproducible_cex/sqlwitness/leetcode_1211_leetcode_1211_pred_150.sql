-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, NULL, 101, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT QUERY_NAME, COUNT(*) AS TOTAL_COUNT, SUM(CAST(RATING AS REAL) / POSITION) AS TOTAL_POSITION, SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS TOTAL_RATING FROM QUERIES GROUP BY QUERY_NAME) SELECT QUERY_NAME, ROUND((CAST(TOTAL_POSITION AS REAL) / TOTAL_COUNT), 2) AS QUALITY, ROUND((CAST(TOTAL_RATING AS REAL) / TOTAL_COUNT) * 100.00, 2) AS POOR_QUERY_PERCENTAGE FROM CTE;

/*
Prediction Result:
(None, 0.02, 100.0)
*/