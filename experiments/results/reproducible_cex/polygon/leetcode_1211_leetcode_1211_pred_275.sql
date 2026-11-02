-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('84', '8', NULL, 2);
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('84', '9', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('84', None, 50.0)
*/

-- Prediction Query
WITH QUALITY AS (SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY FROM QUERIES GROUP BY 1), POOR_RATING AS (SELECT QUERY_NAME, SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS POOR_QUERY, COUNT(*) AS TOTAL_QUERIES FROM QUERIES GROUP BY 1) SELECT A.QUERY_NAME, A.QUALITY, ROUND((CAST(B.POOR_QUERY * 100 AS REAL) / B.TOTAL_QUERIES), 2) AS POOR_QUERY_PERCENTAGE FROM QUALITY AS A JOIN POOR_RATING AS B ON A.QUERY_NAME = B.QUERY_NAME GROUP BY 1, 2;

/*
Prediction Result:
('84', None, 50.0)
*/