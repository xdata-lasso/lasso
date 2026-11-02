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
SELECT DISTINCT QUERY_NAME, QUALITY, ROUND(CAST(NUM_GOOD_RESULTS * 100 AS REAL) / NUM_QUERY_RESULTS, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT *, ROUND(AVG(CAST(RATING AS REAL) / POSITION) OVER (PARTITION BY QUERY_NAME), 2) AS QUALITY, COUNT(RESULT) OVER (PARTITION BY QUERY_NAME) AS NUM_QUERY_RESULTS, COUNT(CASE WHEN RATING < 3 THEN 1 END) OVER (PARTITION BY QUERY_NAME) AS NUM_GOOD_RESULTS FROM QUERIES) AS QUERY_RESULTS_TABLE;

/*
Prediction Result:
(None, 1.75, 50.0)
('DupTest', 1.08, 66.67)
*/