-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default2', NULL, NULL, 1), ('default1', NULL, 4, 2), (NULL, NULL, 500, 1), ('default1', NULL, 1, 3), (NULL, 'default1', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 1.75, 50.0)
('default2', None, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(*), 2) AS QUALITY, ROUND((CAST(SUM(IIF(RATING < 3, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 0.17, 100.0)
('default1', 1.75, 50.0)
('default2', None, 100.0)
*/