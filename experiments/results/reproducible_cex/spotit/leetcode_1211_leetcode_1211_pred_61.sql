-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (3, 4, 0, NULL);
INSERT INTO QUERIES VALUES (3, 4, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('3', 2.0, 50.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(QUERY_NAME), 2) AS QUALITY, ROUND(CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(QUERY_NAME) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
('3', 1.0, 50.0)
*/