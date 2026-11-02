-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default2', 'default2', NULL, 1), (NULL, 'default1', 101, NULL), (NULL, 'default2', 2, 4), ('default2', 'default2', 100, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default2', 0.03, 50.0)
*/

-- Prediction Query
WITH METRICS AS (SELECT *, CAST(RATING * 1.0 AS REAL) / POSITION AS QUALITY, IIF(RATING < 3, 1, 0) AS IS_POOR_QUERY FROM QUERIES) SELECT QUERY_NAME, ROUND(AVG(QUALITY), 2) AS QUALITY, ROUND(AVG(IS_POOR_QUERY) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM METRICS GROUP BY 1;

/*
Prediction Result:
(None, 2.0, 0.0)
('default2', 0.03, 50.0)
*/