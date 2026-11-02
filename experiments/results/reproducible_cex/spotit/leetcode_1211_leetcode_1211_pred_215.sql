-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (5, 6, 0, NULL);
INSERT INTO QUERIES VALUES (2, 4, -3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('2', -1.0, 0.0)
('5', None, 0.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(COALESCE(AVG(CAST(RATING AS REAL) / POSITION), 0), 2) AS QUALITY, ROUND(100 * (CAST(COUNT(CASE WHEN RATING < 3 THEN 1 ELSE NULL END) AS REAL) / COUNT(RATING)), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
('2', -1.0, 0.0)
('5', 0.0, None)
*/