-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES ('A', 'R1', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('A', 'R1', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('A', 'R2', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('A', 3.67, 33.33)
*/

-- Prediction Query
SELECT QUERY_NAME, COALESCE(ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2), 0) AS QUALITY, COALESCE(ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) * 100, 2), 0) AS POOR_QUERY_PERCENTAGE FROM (SELECT DISTINCT QUERY_NAME, RESULT, POSITION, RATING FROM QUERIES) AS Q GROUP BY QUERY_NAME;

/*
Prediction Result:
('A', 3.0, 50.0)
*/