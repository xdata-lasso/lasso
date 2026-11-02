-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Q1', 'R1', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Q1', 'R2', NULL, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Q1', 5.0, 0.0)
*/

-- Prediction Query
WITH QUERY_QUALITY AS (SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(*), 2) AS QUALITY FROM QUERIES GROUP BY 1), QUERY_POOR_PERCET AS (SELECT QUERY_NAME, ROUND(CAST(100 * SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1) SELECT T1.*, T2.POOR_QUERY_PERCENTAGE FROM QUERY_QUALITY AS T1 INNER JOIN QUERY_POOR_PERCET AS T2 ON T1.QUERY_NAME = T2.QUERY_NAME;

/*
Prediction Result:
('Q1', 2.5, 0.0)
*/