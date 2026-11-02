-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'German Shepherd', 2, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'Mule', 200, 1);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Shirazi', 5, 2);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Siamese', 3, 3);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Sphynx', 7, 4);
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'Invisible', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Cat', 0.66, 33.33)
('Dog', 2.5, 33.33)
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT QUERY_NAME, ROUND(CAST(SUM(QUALITY) AS REAL) / COUNT(*), 2) AS TOTAL_QUALITY FROM (SELECT QUERY_NAME, CAST(RATING AS REAL) / POSITION AS QUALITY FROM QUERIES) AS TEMP GROUP BY 1), T2 AS (SELECT QUERY_NAME, ROUND(CAST(POOR_COUNT AS REAL) / TOTAL_COUNT * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT DISTINCT QUERY_NAME, SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS POOR_COUNT, COUNT(*) AS TOTAL_COUNT FROM QUERIES GROUP BY 1) AS TEMP) SELECT T1.QUERY_NAME, TOTAL_QUALITY AS QUALITY, POOR_QUERY_PERCENTAGE FROM T1 LEFT JOIN T2 ON T1.QUERY_NAME = T2.QUERY_NAME;

/*
Prediction Result:
(None, 5.0, None)
('Cat', 0.66, 33.33)
('Dog', 2.5, 33.33)
*/