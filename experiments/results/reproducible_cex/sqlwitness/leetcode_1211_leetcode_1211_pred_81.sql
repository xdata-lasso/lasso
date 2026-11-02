-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default2', 'default1', 3, 2), ('default1', 'default2', 100, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', None, 0.0)
('default2', 0.67, 100.0)
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT QUERY_NAME, RESULT, POSITION, RATING FROM QUERIES) SELECT H1 AS QUERY_NAME, ROUND(AVG(CAST(S1 AS REAL) / S4), 2) AS QUALITY, ROUND(CAST(COUNT(S2) AS REAL) / COUNT(S1) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT T1.QUERY_NAME AS H1, Q.QUERY_NAME AS H2, T1.RATING AS S1, Q.RATING AS S2, T1.POSITION AS S4 FROM T1 LEFT JOIN (SELECT * FROM T1 WHERE RATING < 3) AS Q ON T1.QUERY_NAME = Q.QUERY_NAME AND Q.RATING = T1.RATING AND T1.RESULT = Q.RESULT) AS GAMMA GROUP BY H1;

/*
Prediction Result:
('default1', None, None)
('default2', 0.67, 100.0)
*/