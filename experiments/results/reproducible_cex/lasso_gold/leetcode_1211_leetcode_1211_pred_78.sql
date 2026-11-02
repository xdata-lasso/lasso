-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Gina Moore', 'source', 1013, 1014);
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Brandon Davis', 'throw', NULL, 1016);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Brandon Davis', None, 0.0)
('Gina Moore', 1.0, 0.0)
*/

-- Prediction Query
WITH Q AS (SELECT QUERY_NAME, ROUND(COALESCE(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(*), 0), 2) AS QUALITY, COUNT(*) AS N_QUERIES FROM QUERIES GROUP BY QUERY_NAME), P AS (SELECT QUERY_NAME, COUNT(*) AS POOR_QUERIES FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME) SELECT N.QUERY_NAME, QUALITY, ROUND(COALESCE(CAST(POOR_QUERIES AS REAL) / N_QUERIES * 100, 0), 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT DISTINCT QUERY_NAME FROM QUERIES) AS N LEFT JOIN P USING (QUERY_NAME) LEFT JOIN Q USING (QUERY_NAME);

/*
Prediction Result:
('Gina Moore', 1.0, 0.0)
('Brandon Davis', 0.0, 0.0)
*/