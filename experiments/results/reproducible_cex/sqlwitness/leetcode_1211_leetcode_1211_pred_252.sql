-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default1', NULL, 4, NULL), ('default1', NULL, 1, NULL), ('default2', NULL, 1, 4), ('default2', 'default2', 3, 1), (NULL, 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', None, 0.0)
('default2', 2.17, 50.0)
*/

-- Prediction Query
WITH T1(QUERY_NAME, RESULT, POSITION, RATING, LOWQ) AS (SELECT QUERY_NAME, RESULT, POSITION, RATING, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS LOWQ FROM QUERIES) SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(AVG(LOWQ * 100), 2) AS POOR_QUERY_PERCENTAGE FROM T1 GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, None, 0.0)
('default1', None, 0.0)
('default2', 2.17, 50.0)
*/