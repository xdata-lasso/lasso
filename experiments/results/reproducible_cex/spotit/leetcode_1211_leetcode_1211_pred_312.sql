-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (NULL, 7, NULL, 3);
INSERT INTO QUERIES VALUES (NULL, 6, -4, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
*/

-- Prediction Query
WITH TMP AS (SELECT DISTINCT QUERY_NAME, RESULT, POSITION, RATING FROM QUERIES) SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(100 * AVG(RATING < 3), 2) AS POOR_QUERY_PERCENTAGE FROM TMP GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, -1.0, 0.0)
*/