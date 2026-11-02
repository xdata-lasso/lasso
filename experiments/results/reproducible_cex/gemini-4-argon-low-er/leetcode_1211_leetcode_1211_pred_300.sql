-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'res', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT Q.QUERY_NAME, Q.QUALITY, ROUND(CAST(100 * COALESCE(P.PR, 0) AS REAL) / Q.NR, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, COUNT(RATING) AS NR FROM QUERIES GROUP BY QUERY_NAME) AS Q LEFT JOIN (SELECT QUERY_NAME, COUNT(RATING) AS PR FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME) AS P ON P.QUERY_NAME = Q.QUERY_NAME;

/*
Prediction Result:
(None, 1.0, 0.0)
*/