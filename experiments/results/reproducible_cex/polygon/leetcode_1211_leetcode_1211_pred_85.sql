-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('9', '10', 3, 5);
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES (NULL, '12', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('9', 1.67, 0.0)
*/

-- Prediction Query
SELECT A.QUERY_NAME, ROUND(AVG(CAST(A.RATING AS REAL) / A.POSITION), 2) AS QUALITY, COALESCE(ROUND(CAST(B.COUN AS REAL) / COUNT(*) * 100, 2), 0.00) AS POOR_QUERY_PERCENTAGE FROM QUERIES AS A LEFT JOIN (SELECT QUERY_NAME, COUNT(*) AS COUN FROM QUERIES WHERE RATING < 3 GROUP BY QUERY_NAME) AS B ON A.QUERY_NAME = B.QUERY_NAME GROUP BY A.QUERY_NAME;

/*
Prediction Result:
(None, 0.33, 0.0)
('9', 1.67, 0.0)
*/