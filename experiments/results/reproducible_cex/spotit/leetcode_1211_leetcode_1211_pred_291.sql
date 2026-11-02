-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (3, 2, -3, 6);
INSERT INTO QUERIES VALUES (3, 2, 0, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('3', -2.0, 50.0)
*/

-- Prediction Query
SELECT A.QUERY_NAME, ROUND((CAST(SUM(A.QUAL) AS REAL) / COUNT(*)), 2) AS QUALITY, ROUND((CAST(SUM(CASE WHEN A.RATING < 3 THEN 1 ELSE 0 END) * 100 AS REAL) / COUNT(*)), 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, CAST(RATING AS REAL) / POSITION AS QUAL, RATING FROM QUERIES) AS A GROUP BY A.QUERY_NAME;

/*
Prediction Result:
('3', -1.0, 50.0)
*/