-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default1', NULL, 2, 4), ('default2', 'default1', 101, 3), ('default2', NULL, NULL, 3), (NULL, NULL, 101, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 2.0, 0.0)
('default2', 0.03, 0.0)
*/

-- Prediction Query
WITH NEW AS (SELECT QUERY_NAME, POSITION, RATING, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS POORORNOT, CAST(RATING AS REAL) / POSITION AS RATIO FROM QUERIES) SELECT QUERY_NAME, ROUND(AVG(RATIO), 2) AS QUALITY, ROUND(CAST(SUM(POORORNOT = 1) AS REAL) / COUNT(POORORNOT) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM NEW GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, None, 0.0)
('default1', 2.0, 0.0)
('default2', 0.03, 0.0)
*/