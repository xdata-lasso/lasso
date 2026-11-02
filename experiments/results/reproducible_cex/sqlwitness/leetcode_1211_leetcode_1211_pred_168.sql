-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default1', 500, NULL), ('default1', 'default2', 100, 4), ('default1', NULL, 101, 1), ('default1', 'default2', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.02, 66.67)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) * 100 AS REAL) / COUNT(*)), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
(None, None, 0.0)
('default1', 0.02, 66.67)
*/