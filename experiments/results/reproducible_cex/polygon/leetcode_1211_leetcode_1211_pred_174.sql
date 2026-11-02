-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('7', '8', 2, 2);
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('7', '9', 6, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('7', 0.92, 50.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY, ROUND((CAST(SUM(POOR_COUNT) AS REAL) / TOTAL * 100), 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, POSITION, RATING, COUNT(QUERY_NAME) OVER (PARTITION BY (QUERY_NAME)) AS TOTAL, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS POOR_COUNT FROM QUERIES) AS A GROUP BY QUERY_NAME;

/*
Prediction Result:
('7', 0.92, 50.0)
*/