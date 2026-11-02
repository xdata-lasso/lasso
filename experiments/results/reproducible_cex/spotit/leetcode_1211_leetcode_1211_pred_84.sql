-- Schema DDL
CREATE TABLE "QUERIES" (
    "QUERY_NAME" TEXT,
    "RESULT" TEXT,
    "POSITION" INT,
    "RATING" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO QUERIES VALUES (8, 9, 1, 1);
INSERT INTO QUERIES VALUES (6, 7, -1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('6', -3.0, 0.0)
('8', 1.0, 100.0)
*/

-- Prediction Query
SELECT A.QUERY_NAME, ROUND(AVG(CAST(A.RATING AS REAL) / A.POSITION), 2) AS QUALITY, ROUND(CAST(100 * (SELECT COUNT(*) FROM QUERIES AS B WHERE B.QUERY_NAME = A.QUERY_NAME AND B.RATING < 3) AS REAL) / COUNT(*), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES AS A GROUP BY A.QUERY_NAME;

/*
Prediction Result:
('6', -3.0, 0.0)
('8', 1.0, 100.0)
*/