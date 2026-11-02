-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'test', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT (Q.QUERY_NAME), ROUND(AVG(Q.QUALITY), 2) AS QUALITY, ROUND((CAST(SUM(Q.QUALITY_INDEX) AS REAL) / COUNT(*)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, RATING, CAST(RATING AS REAL) / POSITION AS QUALITY, IIF(RATING < 3, 1, 0) AS QUALITY_INDEX FROM QUERIES) AS Q GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 5.0, 0.0)
*/