-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default1', 'default2', NULL, 2), (NULL, 'default1', 101, NULL), ('default2', 'default2', 101, 2), ('default1', 'default1', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.33, 100.0)
('default2', 0.02, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(CAST((SELECT COUNT(QUERY_NAME) FROM QUERIES WHERE RATING < 3 AND QUERY_NAME = Q.QUERY_NAME) AS REAL) / COUNT(QUERY_NAME) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES AS Q GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, None, None)
('default1', 0.33, 100.0)
('default2', 0.02, 100.0)
*/