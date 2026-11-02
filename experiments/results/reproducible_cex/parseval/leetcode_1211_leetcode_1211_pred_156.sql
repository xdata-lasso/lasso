-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: queries --
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', -55602865, -59984348);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', -664303813, -1022641847);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', -1726781632, 247012447);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', -1980249628, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', -734455130, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 1744686505, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', -1633151678, -252690330);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 1115440883, 1644814318);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 1465859724, -1349201381);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 1019800248, -1910425938);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', -845863578, -1610064545);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 429706943, 462974032);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', -1137908826, -918961358);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', -1602639011, -45536098);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', 1861536320, 44952191);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 1151980946, 3);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 1620389964, 3);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_4b6015', 'que_504299', 546571701, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('que_4b6015', 0.29, 60.0)
*/

-- Prediction Query
WITH X AS (SELECT QUERY_NAME, ROUND(CAST(SUM(CAST(RATING AS REAL) / POSITION) AS REAL) / COUNT(*), 2) AS QUALITY FROM QUERIES GROUP BY 1), Y AS (SELECT Q.QUERY_NAME, ROUND((CAST(COUNT(RATING) AS REAL) / (SELECT COUNT(*) FROM QUERIES WHERE Q.QUERY_NAME = QUERY_NAME GROUP BY QUERY_NAME)) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES AS Q WHERE RATING < 3 GROUP BY 1) SELECT X.QUERY_NAME, X.QUALITY, CASE WHEN Y.POOR_QUERY_PERCENTAGE IS NULL THEN 0 ELSE Y.POOR_QUERY_PERCENTAGE END AS POOR_QUERY_PERCENTAGE FROM X LEFT JOIN Y ON X.QUERY_NAME = Y.QUERY_NAME;

/*
Prediction Result:
(None, 0.29, 0)
('que_4b6015', 0.29, 60.0)
*/