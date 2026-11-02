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
WITH T1 AS (SELECT DISTINCT QUERY_NAME, ROUND(CAST(SUM(QUALITY) AS REAL) / COUNT(*), 2) AS TOTAL_QUALITY FROM (SELECT QUERY_NAME, CAST(RATING AS REAL) / POSITION AS QUALITY FROM QUERIES) AS TEMP GROUP BY 1), T2 AS (SELECT DISTINCT QUERY_NAME, ROUND(CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1) SELECT T1.QUERY_NAME, TOTAL_QUALITY AS QUALITY, POOR_QUERY_PERCENTAGE FROM T1 LEFT JOIN T2 ON T1.QUERY_NAME = T2.QUERY_NAME;

/*
Prediction Result:
(None, 1.75, None)
('DupTest', 1.08, 66.67)
*/