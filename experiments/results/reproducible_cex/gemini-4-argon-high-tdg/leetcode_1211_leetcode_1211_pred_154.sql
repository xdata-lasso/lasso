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
WITH QUALITY AS (SELECT DISTINCT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION) OVER (PARTITION BY QUERY_NAME), 2) AS QUALITY FROM QUERIES) SELECT A.QUERY_NAME, QUALITY, ROUND((CAST(SUM(A.POOR_QUERY) AS REAL) / COUNT(A.QUERY_NAME)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS POOR_QUERY FROM QUERIES) AS A LEFT JOIN QUALITY ON QUALITY.QUERY_NAME = A.QUERY_NAME GROUP BY A.QUERY_NAME, QUALITY;

/*
Prediction Result:
(None, None, None)
('Cat', 0.66, 33.33)
('Dog', 2.5, 33.33)
*/