-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES ('default2', NULL, 1, NULL), ('default1', 'default2', 101, NULL), (NULL, 'default2', 1, 2), ('default1', 'default1', 4, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', 1.0, 0.0)
('default2', None, 0.0)
*/

-- Prediction Query
WITH Q AS (SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(*), 2) AS QUALITY FROM QUERIES GROUP BY 1), P AS (SELECT QUERY_NAME, COUNT(*) AS BADNUM FROM QUERIES WHERE RATING < 3 GROUP BY 1), N AS (SELECT QUERY_NAME, COUNT(*) AS NUM FROM QUERIES GROUP BY 1) SELECT N.QUERY_NAME, Q.QUALITY, COALESCE(ROUND(CAST(P.BADNUM AS REAL) / N.NUM * 100, 2), 0) AS POOR_QUERY_PERCENTAGE FROM N LEFT JOIN P ON N.QUERY_NAME = P.QUERY_NAME JOIN Q ON Q.QUERY_NAME = N.QUERY_NAME;

/*
Prediction Result:
('default1', 0.5, 0)
('default2', None, 0)
*/