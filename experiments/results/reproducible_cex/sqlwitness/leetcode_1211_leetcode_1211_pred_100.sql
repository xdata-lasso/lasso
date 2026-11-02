-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default1', 4, 3), ('default1', NULL, 3, 1), (NULL, NULL, 500, 3), ('default2', NULL, 2, 2), (NULL, 'default1', 2, NULL), (NULL, 'default1', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.33, 100.0)
('default2', 1.0, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND((CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(*)), 2) AS QUALITY, COALESCE(ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE NULL END) AS REAL) / COUNT(*)) * 100, 2), 0) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 0.19, 25.0)
('default1', 0.33, 100.0)
('default2', 1.0, 100.0)
*/