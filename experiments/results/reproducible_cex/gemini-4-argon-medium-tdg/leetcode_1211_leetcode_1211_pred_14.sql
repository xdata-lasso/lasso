-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, < 3 boundary condition (2, 3, 4), integer division vs float division, and rounding to 2 decimal places.
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'German Shepherd', 2, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'Mule', 200, 1);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Shirazi', 5, 2);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Siamese', 3, 3);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Sphynx', 7, 4);
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
SELECT QUERY_NAME, CAST(AVG(CAST(RATING * 1.0 AS REAL) / POSITION) AS REAL(10, 2)) AS QUALITY, CAST(AVG(CASE WHEN RATING < 3 THEN 100.0 ELSE 0 END) AS REAL(10, 2)) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
('Cat', 0.6571428571428571, 33.333333333333336)
('Dog', 2.5016666666666665, 33.333333333333336)
*/