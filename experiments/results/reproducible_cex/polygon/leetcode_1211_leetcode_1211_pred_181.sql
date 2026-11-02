-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('56', '55', 253, NULL);
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('56', '57', 2, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('56', 2.0, 0.0)
*/

-- Prediction Query
WITH A AS (SELECT QUERY_NAME, COUNT(CASE WHEN RATING < 3 THEN 1 END) AS POOR_RATING_COUNT FROM QUERIES GROUP BY QUERY_NAME) SELECT QUERIES.QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(QUERIES.QUERY_NAME), 2) AS QUALITY, ROUND(CAST(A.POOR_RATING_COUNT AS REAL) / COUNT(QUERIES.QUERY_NAME) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES CROSS JOIN A WHERE A.QUERY_NAME = QUERIES.QUERY_NAME GROUP BY QUERIES.QUERY_NAME;

/*
Prediction Result:
('56', 1.0, 0.0)
*/