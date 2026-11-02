-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default2', 2, NULL), ('default2', NULL, 4, 3), ('default1', 'default2', 99, 1), ('default2', 'default2', 500, NULL), ('default2', 'default1', 1, 1), ('default2', 'default2', NULL, NULL), ('default2', NULL, 2, NULL), ('default2', 'default2', 99, 3), ('default2', 'default1', 2, 2), ('default1', 'default2', 99, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.01, 50.0)
('default2', 0.7, 28.57)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(CAST(SUM(IIF(RATING < 3, 100, 0)) AS REAL) / COUNT(RATING), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
(None, None, None)
('default1', 0.01, 100.0)
('default2', 0.7, 50.0)
*/