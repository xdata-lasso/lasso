-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO queries (query_name, result, position, rating) VALUES (NULL, 'default2', 100, 2), (NULL, NULL, 1, 3), (NULL, 'default2', 1, 5), ('default1', 'default2', 1, NULL), ('default1', NULL, NULL, 1), (NULL, NULL, 1, NULL), ('default1', 'default1', NULL, 5), (NULL, 'default2', 500, 5), (NULL, 'default1', NULL, NULL), (NULL, 'default1', 100, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('default1', None, 33.33)
*/

-- Prediction Query
SELECT A.QUERY_NAME, A.QUALITY, B.POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, ROUND(COALESCE(AVG(CAST(RATING AS REAL) / POSITION), 0), 2) AS QUALITY FROM QUERIES GROUP BY QUERY_NAME) AS A JOIN (SELECT QUERY_NAME, ROUND(COALESCE(CAST(SUM(RATING < 3) AS REAL) / COUNT(*) * 100, 0), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME) AS B ON A.QUERY_NAME = B.QUERY_NAME;

/*
Prediction Result:
('default1', 0.0, 33.33)
*/