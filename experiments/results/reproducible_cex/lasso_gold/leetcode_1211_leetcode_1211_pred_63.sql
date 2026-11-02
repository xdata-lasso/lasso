-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Allison Hill', 'dog', 1001, 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Allison Hill', 1.0, 0.0)
*/

-- Prediction Query
SELECT QUERY_NAME, CAST(CAST(SUM(CAST((RATING * 1.0) AS REAL) / (POSITION * 1.0)) AS REAL) / COUNT(*) AS REAL(32, 2)) AS QUALITY, CAST(CAST((SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) * 100.00) AS REAL) / COUNT(RATING) AS REAL(32, 2)) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Prediction Result:
('Allison Hill', 1.000999000999001, 0.0)
*/