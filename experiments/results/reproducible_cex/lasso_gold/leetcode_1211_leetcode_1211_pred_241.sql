-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Sean Blake', 'collection', 1006, 2);
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Gina Moore', 'source', 1007, NULL);
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Gina Moore', 'great', 1008, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('Gina Moore', 0.0, 50.0)
('Sean Blake', 0.0, 100.0)
*/

-- Prediction Query
WITH LESS_THAN3 AS (SELECT QUERY_NAME, COUNT(RATING) AS COUNT_LESS3 FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME), COUNTS AS (SELECT QUERY_NAME, COUNT(RATING) AS COUNT_RATING FROM QUERIES GROUP BY QUERY_NAME), QUAL AS (SELECT QUERY_NAME, ROUND(AVG(QUALITY), 2) AS QUALITY FROM (SELECT QUERY_NAME, CAST(RATING AS REAL) / POSITION AS QUALITY FROM QUERIES) AS Q GROUP BY QUERY_NAME) SELECT C.QUERY_NAME, Q.QUALITY, COALESCE(ROUND(100 * (CAST(T.COUNT_LESS3 AS REAL) / C.COUNT_RATING), 2), 0) AS POOR_QUERY_PERCENTAGE FROM COUNTS AS C LEFT JOIN LESS_THAN3 AS T ON C.QUERY_NAME = T.QUERY_NAME JOIN QUAL AS Q ON Q.QUERY_NAME = C.QUERY_NAME;

/*
Prediction Result:
('Gina Moore', 0.0, 100.0)
('Sean Blake', 0.0, 100.0)
*/