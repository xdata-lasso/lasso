-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default2', 4, 2), ('default1', NULL, 1, 4), ('default2', NULL, 1, 1), (NULL, 'default1', 100, 1), (NULL, NULL, NULL, 2), ('default1', 'default2', 500, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 2.0, 50.0)
('default2', 1.0, 100.0)
*/

-- Prediction Query
WITH TMP AS (SELECT DISTINCT QUERY_NAME, RESULT, POSITION, RATING FROM QUERIES) SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(100 * AVG(RATING < 3), 2) AS POOR_QUERY_PERCENTAGE FROM TMP GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 0.26, 100.0)
('default1', 2.0, 50.0)
('default2', 1.0, 100.0)
*/