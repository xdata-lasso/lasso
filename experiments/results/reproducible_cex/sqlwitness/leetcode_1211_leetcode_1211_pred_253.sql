-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default1', 100, 5), ('default2', NULL, 101, 1), ('default2', 'default2', 500, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default2', 0.01, 100.0)
*/

-- Prediction Query
SELECT Q.QUERY_NAME, Q.QUALITY, ROUND(CAST(100 * COALESCE(Q.PR, 0) AS REAL) / Q.NR, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, COUNT(RATING) AS NR, SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS PR FROM QUERIES GROUP BY QUERY_NAME) AS Q;

/*
Prediction Result:
(None, 0.05, 0.0)
('default2', 0.01, 100.0)
*/