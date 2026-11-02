-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (3, NULL, -300, 300);
INSERT INTO QUERIES VALUES (3, 4, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('3', -1.0, 50.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG((CAST(RATING AS REAL) / POSITION)), 2) AS QUALITY, ROUND(CAST(COUNT(CASE WHEN RATING < 3 THEN RESULT END) AS REAL) / COUNT(DISTINCT RESULT) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
('3', -1.0, 100.0)
*/