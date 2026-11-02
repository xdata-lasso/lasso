-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (NULL, 8, -1, 0);
INSERT INTO QUERIES VALUES (2, 3, -10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('2', None, 0.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(CAST(SUM(RA) AS REAL) / SUM(CNT), 2) AS QUALITY, ROUND((CAST(SUM(P) AS REAL) / SUM(CNT)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, POSITION, RATING, CAST(SUM(RATING) AS REAL) / SUM(POSITION) AS RA, SUM(RATING < 3) AS P, COUNT(QUERY_NAME) AS CNT FROM QUERIES GROUP BY RESULT) AS M GROUP BY 1;

/*
Prediction Result:
(None, None, None)
('2', None, None)
*/