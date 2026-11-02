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
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'Unknown', 1, 1);
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
WITH CTE AS (SELECT QUERY_NAME, RATING, POSITION, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS RATING_MIN_COUNT FROM QUERIES) SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(QUERY_NAME), 2) AS QUALITY, ROUND((CAST(SUM(RATING_MIN_COUNT) AS REAL) / COUNT(RATING)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM CTE GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, None, 100.0)
('Cat', 0.66, 33.33)
('Dog', 2.5, 33.33)
*/