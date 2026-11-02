-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests NULL values in 'result', 'rating', or 'position' columns to distinguish COUNT(*) from COUNT(col) and AVG() behavior.
INSERT INTO Queries (query_name, result, position, rating) VALUES ('NullCols', NULL, 2, 1);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('NullCols', 'Valid', 4, 3);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('NullCols', 'NullRating', 5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('NullCols', 0.63, 33.33)
*/

-- Prediction Query
WITH A AS (SELECT QUERY_NAME, (CAST(COUNT(CASE WHEN RATING < 3 THEN 1 ELSE NULL END) AS REAL) / COUNT(RATING)) * 100 AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME), B AS (SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(RATING), 2) AS QUALITY FROM QUERIES GROUP BY QUERY_NAME) SELECT B.QUERY_NAME, B.QUALITY, ROUND(A.POOR_QUERY_PERCENTAGE, 2) AS POOR_QUERY_PERCENTAGE FROM A JOIN B ON B.QUERY_NAME = A.QUERY_NAME;

/*
Prediction Result:
('NullCols', 0.63, 50.0)
*/