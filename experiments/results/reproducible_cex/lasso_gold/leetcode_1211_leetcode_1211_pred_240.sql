-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Brian Yang', 'offer', 1005, 1004);
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Brian Yang', 'offer', 1008, 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Brian Yang', 1.0, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT QUERY_NAME, ROUND(CAST(SUM((CAST(RATING AS REAL) / POSITION)) AS REAL) / COUNT(DISTINCT RESULT), 2) AS QUALITY, ROUND(((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT RESULT)) * 100), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME) SELECT QUERY_NAME, QUALITY, POOR_QUERY_PERCENTAGE FROM CTE ORDER BY QUERY_NAME DESC, QUALITY NULLS LAST, POOR_QUERY_PERCENTAGE NULLS LAST;

/*
Prediction Result:
('Brian Yang', 2.0, 0.0)
*/