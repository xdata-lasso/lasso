-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES ('A', 'R1', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('A', 'R1', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('A', 2.75, 50.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(CAST(SUM(RA) AS REAL) / SUM(CNT), 2) AS QUALITY, ROUND((CAST(SUM(P) AS REAL) / SUM(CNT)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, POSITION, RATING, CAST(SUM(RATING) AS REAL) / SUM(POSITION) AS RA, SUM(RATING < 3) AS P, COUNT(QUERY_NAME) AS CNT FROM QUERIES GROUP BY RESULT) AS M GROUP BY 1;

/*
Prediction Result:
('A', 1.0, 50.0)
*/