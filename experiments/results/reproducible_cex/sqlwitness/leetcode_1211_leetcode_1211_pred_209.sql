-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT QUERY_NAME, SUM(CAST(RATING AS REAL) / POSITION) AS QUALITY, COUNT(*) AS CNT, SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS POOR_QUALITY FROM QUERIES GROUP BY 1) SELECT QUERY_NAME, ROUND(CAST(QUALITY AS REAL) / CNT, 2) AS POOR_QUERY_PERCENTAGE, ROUND((CAST(POOR_QUALITY AS REAL) / CNT) * 100, 2) AS QUALITY FROM CTE;

/*
Prediction Result:
(None, None, 0.0)
*/