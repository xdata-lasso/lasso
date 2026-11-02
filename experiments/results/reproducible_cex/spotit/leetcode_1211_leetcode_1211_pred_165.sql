-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (2, 4, 1, NULL);
INSERT INTO QUERIES VALUES (2, 4, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('2', 1.0, 50.0)
*/

-- Prediction Query
SELECT DISTINCT (QUERY_NAME), ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND(CAST(100 * SUM(RATING < 3) AS REAL) / COUNT(RATING), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
('2', 1.0, 100.0)
*/