-- Schema DDL
CREATE TABLE "Queries" ("query_name" TEXT(255), "result" TEXT(255), "position" INTEGER, "rating" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: queries --
INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', 1, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', -55602865, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', 1, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', -59984348, 2);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', 1, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_e0930d', 'que_504299', 1, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', -664303813, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', -1022641847, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', 1, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('A', 'que_504299', -1726781632, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('Q', 'que_504299', 247012447, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', 1, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', -1980249628, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES (NULL, 'que_504299', -734455130, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', 1, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', 1744686505, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', -1633151678, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', NULL, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', NULL, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', NULL, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_0ade2e', 'que_504299', 1, 1);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', -252690330, NULL);

INSERT INTO "queries" ("query_name", "result", "position", "rating") VALUES ('que_f37c3c', 'que_504299', 1115440883, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT query_name, ROUND(AVG(CAST(rating AS REAL) / position), 2) AS quality, ROUND(CAST(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) * 100, 2) AS poor_query_percentage FROM Queries WHERE NOT query_name IS NULL GROUP BY query_name;

/*
Gold Result:
('A', None, 0.0)
('Q', None, 0.0)
('que_0ade2e', 1.0, 87.5)
('que_e0930d', 1.0, 100.0)
('que_f37c3c', -0.0, 40.0)
*/

-- Prediction Query
SELECT T.QUERY_NAME, ROUND(AVG(QUALITY), 2) AS QUALITY, ROUND(CAST(SUM(CASE WHEN R.RATING < 3 THEN 1 ELSE 0 END) AS REAL) / COUNT(R.RATING) * 100, 2) AS POOR_QUERY_PERCENTAGE FROM (SELECT QUERY_NAME, CAST(RATING AS REAL) / POSITION AS QUALITY FROM QUERIES) AS T CROSS JOIN QUERIES AS R WHERE R.QUERY_NAME = T.QUERY_NAME GROUP BY T.QUERY_NAME;

/*
Prediction Result:
('A', None, None)
('Q', None, None)
('que_0ade2e', 1.0, 100.0)
('que_e0930d', 1.0, 100.0)
('que_f37c3c', -0.0, 100.0)
*/