-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('103', '8', 2, NULL);
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('103', '9', 7, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('103', 0.14, 50.0)
*/

-- Prediction Query
WITH QUALITY_RESULTS AS (SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY FROM QUERIES GROUP BY QUERY_NAME), POOR_QUERY_PERC AS (SELECT QUERY_NAME, ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(RATING)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME) SELECT R.QUERY_NAME, QUALITY, POOR_QUERY_PERCENTAGE FROM QUALITY_RESULTS AS R CROSS JOIN POOR_QUERY_PERC AS P WHERE R.QUERY_NAME = P.QUERY_NAME;

/*
Prediction Result:
('103', 0.14, 100.0)
*/