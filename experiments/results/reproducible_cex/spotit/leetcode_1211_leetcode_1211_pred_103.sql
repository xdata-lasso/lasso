-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (3, 4, -1, -1);
INSERT INTO QUERIES VALUES (NULL, 4, 0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('3', 1.0, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(QUA), 2) AS QUALITY, ROUND(AVG(POOR_QUERY) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, RATING, CAST(RATING AS REAL) / POSITION AS QUA, IIF(RATING >= 3, 0, 1) AS POOR_QUERY FROM QUERIES) AS TEMP GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, None, 100.0)
('3', 1.0, 100.0)
*/