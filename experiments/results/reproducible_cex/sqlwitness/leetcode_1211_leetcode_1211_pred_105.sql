-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default2', 500, 1), ('default1', 'default1', 101, 1), (NULL, 'default1', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.01, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(QUALITY), 2) AS QUALITY, ROUND((AVG(POOR_CHECK) * 100), 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, POSITION, RATING, (CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS POOR_CHECK, CAST(RATING AS REAL) / POSITION AS QUALITY FROM QUERIES) AS A GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 2.5, 50.0)
('default1', 0.01, 100.0)
*/