-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('11', NULL, 2, 3);
INSERT INTO "Queries" ("query_name", "result", "position", "rating") VALUES ('13', NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('11', 1.5, 0.0)
('13', 1.0, 100.0)
*/

-- Prediction Query
WITH QUALITY AS (SELECT QUERY_NAME, ROUND(AVG(CAST(RATING AS REAL) / POSITION), 2) AS QUALITY FROM QUERIES GROUP BY 1), PQP AS (SELECT Q1.QUERY_NAME, ROUND((CAST(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) AS REAL) / RES) * 100, 2) AS PQP FROM QUERIES AS Q1 JOIN (SELECT QUERY_NAME, COUNT(RESULT) AS RES FROM QUERIES GROUP BY QUERY_NAME) AS Q ON Q1.QUERY_NAME = Q.QUERY_NAME GROUP BY 1) SELECT QUALITY.QUERY_NAME, QUALITY.QUALITY, PQP.PQP AS POOR_QUERY_PERCENTAGE FROM QUALITY JOIN PQP ON QUALITY.QUERY_NAME = PQP.QUERY_NAME;

/*
Prediction Result:
('11', 1.5, None)
('13', 1.0, None)
*/