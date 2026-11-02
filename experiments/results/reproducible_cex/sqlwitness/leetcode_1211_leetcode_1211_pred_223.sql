-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default2', 3, 5), ('default2', NULL, 4, 4), ('default1', 'default2', NULL, 5), (NULL, 'default2', 1, 4), ('default1', NULL, 101, NULL), (NULL, NULL, 99, NULL), (NULL, 'default1', 101, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', None, 0.0)
('default2', 1.0, 0.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, COALESCE(ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 END) AS REAL) / COUNT(RATING)) * 100, 2), 0) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
(None, 1.9, 0)
('default1', None, 0)
('default2', 1.0, 0)
*/