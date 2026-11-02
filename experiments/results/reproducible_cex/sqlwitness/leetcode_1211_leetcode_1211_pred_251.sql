-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default2', 'default1', 99, NULL), ('3', 'default1', 100, 3), (NULL, '3', 1, 3), ('default2', 'default2', NULL, 2), ('default1', 'default2', NULL, NULL), ('default1', NULL, 100, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('3', 0.03, 0.0)
('default1', 0.01, 50.0)
('default2', None, 50.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(100 * AVG(IIF(RATING < '3', 1, 0)), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 3.0, 0.0)
('3', 0.03, 0.0)
('default1', 0.01, 50.0)
('default2', None, 50.0)
*/