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
WITH T1 AS (SELECT DISTINCT QUERY_NAME, RESULT, POSITION, RATING FROM QUERIES) SELECT H1 AS QUERY_NAME, ROUND(AVG(CAST(S1 AS REAL) / S4), 2) AS QUALITY, ROUND(CAST(COUNT(S2) AS REAL) / COUNT(S1) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT T1.QUERY_NAME AS H1, Q.QUERY_NAME AS H2, T1.RATING AS S1, Q.RATING AS S2, T1.POSITION AS S4 FROM T1 LEFT JOIN (SELECT * FROM T1 WHERE RATING < 3) AS Q ON T1.QUERY_NAME = Q.QUERY_NAME AND Q.RATING = T1.RATING AND T1.RESULT = Q.RESULT) AS GAMMA GROUP BY H1;

/*
Prediction Result:
(None, 1.75, 0.0)
('DupTest', 1.13, 50.0)
*/