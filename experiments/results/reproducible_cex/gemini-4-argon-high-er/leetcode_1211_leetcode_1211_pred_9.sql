-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES ('q1', 'a', 1, 1);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('q1', 'a', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('q1', 3.0, 50.0)
*/

-- Prediction Query
SELECT Q1.QUERY_NAME, ROUND(AVG(CAST(Q1.RATING AS REAL) / Q1.POSITION), 2) AS QUALITY, ROUND(CAST(COUNT(DISTINCT Q2.RESULT) AS REAL) / COUNT(DISTINCT Q1.RESULT) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES AS Q1 LEFT JOIN (SELECT QUERY_NAME, RESULT FROM QUERIES WHERE RATING < 3) AS Q2 ON Q1.QUERY_NAME = Q2.QUERY_NAME GROUP BY Q1.QUERY_NAME;

/*
Prediction Result:
('q1', 3.0, 100.0)
*/