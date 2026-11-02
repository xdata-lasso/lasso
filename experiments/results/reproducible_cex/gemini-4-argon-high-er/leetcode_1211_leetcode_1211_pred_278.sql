-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'Golden Retriever', 1, 5);
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Dog', 2.0, 100.0)
*/

-- Prediction Query
SELECT A.QUERY_NAME, ROUND(CAST(SUM(CAST(A.RATING AS REAL) / A.POSITION) AS REAL) / COUNT(A.RESULT), 2) AS QUALITY, ROUND(CAST(COUNT(CASE WHEN A.RATING < 3 THEN A.RESULT END) * 100 AS REAL) / COUNT(A.RESULT), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES AS A GROUP BY 1;

/*
Prediction Result:
(None, 5.0, 0.0)
('Dog', None, None)
*/