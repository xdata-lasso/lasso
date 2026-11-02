-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests filtering of NULL query_name, and handling of duplicate (query_name, result) or identical rows (testing DISTINCT vs ALL).
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'NullQuery1', 1, 1);
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'NullQuery2', 2, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('DupTest', 'SameResult', 2, 2);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('DupTest', 'SameResult', 2, 2);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('DupTest', 'DiffResult', 4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('DupTest', 1.08, 66.67)
*/

-- Prediction Query
WITH TMP AS (SELECT QUERY_NAME, ROUND(COALESCE(AVG(CAST(RATING AS REAL) / POSITION), 0.00), 2) AS QUALITY FROM QUERIES GROUP BY QUERY_NAME), TB1 AS (SELECT QUERY_NAME, COUNT(RATING) AS NUMER1 FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME), TB2 AS (SELECT QUERY_NAME, COUNT(RATING) AS DENOM FROM QUERIES GROUP BY QUERY_NAME), TB3 AS (SELECT QUERY_NAME, 0 AS NUMER2 FROM QUERIES WHERE RATING >= 3 GROUP BY QUERY_NAME), TB4 AS (SELECT QUERY_NAME, NUMER1 AS NUMER3 FROM TB1 UNION ALL SELECT QUERY_NAME, NUMER2 FROM TB3), TB5 AS (SELECT QUERY_NAME, SUM(NUMER3) AS NUMER FROM TB4 GROUP BY QUERY_NAME) SELECT TMP.QUERY_NAME, QUALITY, ROUND(COALESCE(CAST(NUMER AS REAL) / DENOM * 100, 0.00), 2) AS POOR_QUERY_PERCENTAGE FROM TMP LEFT JOIN TB5 ON TB5.QUERY_NAME = TMP.QUERY_NAME LEFT JOIN TB2 ON TMP.QUERY_NAME = TB2.QUERY_NAME;

/*
Prediction Result:
(None, 1.75, 0.0)
('DupTest', 1.08, 66.67)
*/