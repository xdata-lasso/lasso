-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'res1', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'res2', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Dog', 0.33, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, CAST(AVG(CAST(RATING AS REAL) / POSITION) AS REAL(5, 2)) AS QUALITY, CAST(CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS REAL(10, 4)) * 100 AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 5.0, 0.0)
('Dog', 0.3333333333333333, 100.0)
*/