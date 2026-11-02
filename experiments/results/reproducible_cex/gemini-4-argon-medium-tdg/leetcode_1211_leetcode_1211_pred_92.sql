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
SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(*), 2) AS QUALITY, COALESCE(ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) * 100 AS REAL) / COUNT(*)), 2), 0) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
(None, 1.75, 50.0)
('DupTest', 1.08, 66.67)
*/