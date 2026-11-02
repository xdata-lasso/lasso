-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default1', 101, 1), ('default1', 'default2', 1, 1), (NULL, 'default1', 4, NULL), (NULL, NULL, 4, NULL), ('default2', 'default1', 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 1.0, 100.0)
('default2', 3.0, 0.0)
*/

-- Prediction Query
SELECT DISTINCT QUERY_NAME, ROUND((CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(RATING)), 2) AS QUALITY, ROUND(CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) * 100 AS REAL) / COUNT(QUERY_NAME), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 0.01, None)
('default1', 1.0, 100.0)
('default2', 3.0, 0.0)
*/