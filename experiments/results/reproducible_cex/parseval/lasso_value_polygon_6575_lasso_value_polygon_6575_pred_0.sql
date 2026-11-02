-- Schema DDL
CREATE TABLE QUERIES (QUERY_NAME TEXT(255), RESULT TEXT(255), POSITION INTEGER, RATING INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: queries --
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -55602865, -59984348);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -664303813, -1022641847);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -1726781632, 247012447);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -1980249628, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -734455130, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', 1744686505, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -1633151678, -252690330);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', 1115440883, 1644814318);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', 1465859724, -1349201381);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_4e4e49', 1019800248, -1910425938);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_4e4e49', -845863578, -1610064545);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_4e4e49', 429706943, 462974032);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -1137908826, -918961358);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', -1602639011, -45536098);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', 1861536320, 44952191);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', 1151980946, 3);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', 1620389964, 3);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_427a60', 'que_4e4e49', 546571701, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT QUERY_NAME, ROUND(AVG(RATING / POSITION), 2) AS QUALITY, ROUND(100 * SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) / COUNT(1), 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY QUERY_NAME;

/*
Gold Result:
(None, 0.33, 66.0)
('que_427a60', 0.2, 60.0)
*/

-- Prediction Query
SELECT QUERY_NAME, ROUND(SUM(RATING / POSITION) / COUNT(*), 2) AS QUALITY, ROUND(SUM(CASE WHEN RATING < 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM QUERIES GROUP BY 1;

/*
Prediction Result:
(None, 0.0, 0.0)
('que_427a60', 0.0, 0.0)
*/