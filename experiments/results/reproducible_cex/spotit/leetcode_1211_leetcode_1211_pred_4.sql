-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (5, 7, -2, -2);
INSERT INTO QUERIES VALUES (NULL, 7, -2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('5', 1.0, 100.0)
*/

-- Prediction Query
SELECT A1.QUERY_NAME, ROUND(AVG(A1.TEMP), 2) AS QUALITY, ROUND(100 * (CAST(SUM(A1.Q) AS REAL) / COUNT(A1.Q)), 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, CAST(RATING AS REAL) / POSITION AS TEMP, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS Q FROM QUERIES) AS A1 GROUP BY A1.QUERY_NAME;

/*
Prediction Result:
(None, -1.0, 100.0)
('5', 1.0, 100.0)
*/