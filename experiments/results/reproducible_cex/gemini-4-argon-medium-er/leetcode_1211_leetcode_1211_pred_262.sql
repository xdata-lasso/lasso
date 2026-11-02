-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'A', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'B', 3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Dog', 1.67, 0.0)
*/

-- Prediction Query
SELECT QUERY_NAME, COALESCE(CAST(CAST(SUM(CAST(RATING * 1.0 AS REAL) / POSITION) AS REAL) / COUNT(RATING) AS REAL(10, 2)), 0) AS QUALITY, COALESCE(CAST(CAST(SUM(CASE WHEN RATING < 3 THEN 1 END) * 100 AS REAL) / COUNT(POSITION) AS REAL(10, 2)), 0) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 5.0, 0)
('Dog', 1.6666666666666667, 0)
*/