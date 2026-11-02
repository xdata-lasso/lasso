-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default1', 'default1', 101, 5), (NULL, 'default2', 101, 5), ('default1', NULL, NULL, 1), ('default2', NULL, 500, 2), ('default2', NULL, 100, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.05, 50.0)
('default2', 0.02, 50.0)
*/

-- Prediction Query
SELECT A.QUERY_NAME, A.QUA AS QUALITY, ROUND(POOR * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(RATING), 2) AS QUA FROM QUERIES GROUP BY QUERY_NAME) AS A JOIN (SELECT QUERY_NAME, (CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(RATING)) AS POOR FROM QUERIES GROUP BY QUERY_NAME) AS B ON A.QUERY_NAME = B.QUERY_NAME;

/*
Prediction Result:
('default1', 0.02, 50.0)
('default2', 0.02, 50.0)
*/