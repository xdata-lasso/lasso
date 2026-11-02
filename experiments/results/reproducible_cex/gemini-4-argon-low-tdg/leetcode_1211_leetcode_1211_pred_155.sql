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
WITH TMP AS (SELECT QUERY_NAME, ROUND(COALESCE(AVG(CAST(RATING AS REAL) / POSITION), 0.00), 2) AS QUALITY FROM QUERIES GROUP BY QUERY_NAME), TB1 AS (SELECT QUERY_NAME, COUNT(RATING) AS NUMER1 FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME), TB2 AS (SELECT QUERY_NAME, COUNT(RATING) AS DENOM FROM QUERIES GROUP BY QUERY_NAME), TB3 AS (SELECT QUERY_NAME, 0 AS NUMER2 FROM QUERIES WHERE RATING >= 3 GROUP BY QUERY_NAME), TB4 AS (SELECT QUERY_NAME, NUMER1 AS NUMER3 FROM TB1 UNION ALL SELECT QUERY_NAME, NUMER2 FROM TB3), TB5 AS (SELECT QUERY_NAME, SUM(NUMER3) AS NUMER FROM TB4 GROUP BY QUERY_NAME) SELECT TMP.QUERY_NAME, QUALITY, ROUND(COALESCE(CAST(NUMER AS REAL) / DENOM * 100, 0.00), 2) AS POOR_QUERY_PERCENTAGE FROM TMP LEFT JOIN TB5 ON TB5.QUERY_NAME = TMP.QUERY_NAME LEFT JOIN TB2 ON TMP.QUERY_NAME = TB2.QUERY_NAME;

/*
Prediction Result:
(None, 5.0, 0.0)
('Cat', 0.66, 33.33)
('Dog', 2.5, 33.33)
*/