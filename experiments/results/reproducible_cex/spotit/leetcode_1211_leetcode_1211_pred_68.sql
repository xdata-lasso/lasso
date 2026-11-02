-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (NULL, 7, 1, NULL);
INSERT INTO QUERIES VALUES (4, NULL, -1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('4', -3.0, 0.0)
*/

-- Prediction Query
SELECT T1.QUERY_NAME, ROUND(AVG(CAST(T1.RATING AS REAL) / T1.POSITION), 2) AS QUALITY, ROUND((CAST(COUNT(CASE WHEN T1.RATING < 3 THEN 1 END) AS REAL) / COUNT(*)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT DISTINCT * FROM QUERIES) AS T1 GROUP BY T1.QUERY_NAME;

/*
Prediction Result:
(None, None, 0.0)
('4', -3.0, 0.0)
*/