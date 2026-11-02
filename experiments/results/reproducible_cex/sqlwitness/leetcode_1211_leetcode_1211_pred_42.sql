-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default1', 'default2', 500, 4), (NULL, NULL, 101, 2), ('default2', NULL, 100, 3), (NULL, 'default1', 2, 4), ('default1', 'default2', 3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.67, 0.0)
('default2', 0.03, 0.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(CAST(100 * SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 1.01, 50.0)
('default1', 0.67, 0.0)
('default2', 0.03, 0.0)
*/