-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, NULL, 4, 2), (NULL, NULL, 100, 3), ('default1', 'default2', 3, NULL), ('default1', 'default1', 500, 2), (NULL, NULL, 101, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.0, 50.0)
*/

-- Prediction Query
WITH RES1 AS (SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(RESULT), 2) AS QUALITY, COUNT(RESULT) AS NUM FROM QUERIES GROUP BY QUERY_NAME), POOR AS (SELECT QUERY_NAME, COUNT(RATING) AS POOR_NUM FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME) SELECT RES1.QUERY_NAME, RES1.QUALITY, COALESCE(ROUND((CAST(POOR.POOR_NUM AS REAL) / RES1.NUM) * 100, 2), 0) AS POOR_QUERY_PERCENTAGE FROM RES1 LEFT JOIN POOR ON RES1.QUERY_NAME = POOR.QUERY_NAME;

/*
Prediction Result:
(None, None, 0)
('default1', 0.0, 50.0)
*/