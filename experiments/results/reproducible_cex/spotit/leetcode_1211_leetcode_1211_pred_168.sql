-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (6, 7, 1, 1);
INSERT INTO QUERIES VALUES (NULL, 5, -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('6', 1.0, 100.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) * 100 AS REAL) / COUNT(*)), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
(None, None, 0.0)
('6', 1.0, 100.0)
*/