-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: queries --
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -55602865, -59984348);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -664303813, -1022641847);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -1726781632, 247012447);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -1980249628, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -734455130, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', 1744686505, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -1633151678, -252690330);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', 1115440883, 1644814318);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', 1465859724, -1349201381);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', 1019800248, -1910425938);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', -845863578, -1610064545);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', 429706943, 462974032);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -1137908826, -918961358);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', -1602639011, -45536098);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', 1861536320, 44952191);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', 1151980946, 3);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', 1620389964, 3);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0cbfab', 'que_504299', 546571701, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('que_0cbfab', 0.27, 60.0)
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT QUERY_NAME, RESULT, POSITION, RATING FROM QUERIES) SELECT H1 AS QUERY_NAME, ROUND(AVG(CAST(S1 AS REAL) / S4), 2) AS QUALITY, ROUND(CAST(COUNT(S2) AS REAL) / COUNT(S1) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT T1.QUERY_NAME AS H1, Q.QUERY_NAME AS H2, T1.RATING AS S1, Q.RATING AS S2, T1.POSITION AS S4 FROM T1 LEFT JOIN (SELECT * FROM T1 WHERE RATING < 3) AS Q ON T1.QUERY_NAME = Q.QUERY_NAME AND Q.RATING = T1.RATING AND T1.RESULT = Q.RESULT) AS GAMMA GROUP BY H1;

/*
Prediction Result:
(None, 0.37, 0.0)
('que_0cbfab', 0.19, 71.43)
*/