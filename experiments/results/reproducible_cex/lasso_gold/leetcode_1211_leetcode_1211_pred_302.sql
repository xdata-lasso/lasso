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
SELECT SUB.QUERY_NAME, ROUND(AVG(SUB.QUALITY), 2) AS QUALITY, ROUND(CAST(100 * SUM(POOR_QUAL_OR_NOT) AS REAL) / COUNT(SUB.POSITION), 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, POSITION, CAST(RATING AS REAL) / POSITION AS QUALITY, CASE WHEN RATING < 3 THEN 1 ELSE 0 END AS POOR_QUAL_OR_NOT FROM QUERIES) AS SUB GROUP BY 1;

/*
Prediction Result:
('Brandon Davis', None, None)
('Gina Moore', 1.0, 0.0)
*/