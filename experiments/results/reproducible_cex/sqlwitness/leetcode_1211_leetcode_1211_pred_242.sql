-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default1', 'default1', 101, 5), (NULL, NULL, 101, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 0.05, 0.0)
*/

-- Prediction Query
WITH NUMERATOR AS (SELECT QUERY_NAME, COUNT(*) AS NUM FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME) SELECT Q.QUERY_NAME, ROUND(AVG(CAST(Q.RATING AS REAL) / Q.POSITION), 2) AS QUALITY, ROUND(COALESCE((CAST((SELECT N.NUM FROM NUMERATOR AS N WHERE N.QUERY_NAME = Q.QUERY_NAME) AS REAL) / (SELECT COUNT(*) FROM QUERIES AS Q1 WHERE Q1.QUERY_NAME = Q.QUERY_NAME)) * 100, 0), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES AS Q GROUP BY QUERY_NAME;

/*
Prediction Result:
(None, 0.05, 0.0)
('default1', 0.05, 0.0)
*/