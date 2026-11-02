-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (4, 5, -1, -1);
INSERT INTO QUERIES VALUES (NULL, 3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('4', 1.0, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(QUA), 2) AS QUALITY, ROUND(CAST(SUM(RR) AS REAL) / COUNT(QUERY_NAME) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, RESULT, POSITION, RATING, CAST(RATING AS REAL) / POSITION AS QUA, (CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS RR FROM QUERIES) AS CTE GROUP BY 1;

/*
Prediction Result:
(None, 1.0, None)
('4', 1.0, 100.0)
*/