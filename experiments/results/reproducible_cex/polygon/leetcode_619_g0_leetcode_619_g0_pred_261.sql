-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-715);
INSERT INTO "mynumbers" ("num") VALUES (-716);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-715,)
*/

-- Prediction Query
WITH TEMP AS (SELECT NUM, COUNT(*) AS CNT FROM MYNUMBERS GROUP BY NUM) SELECT T.NUM FROM (SELECT 1 AS CNT FROM TEMP) AS O LEFT JOIN TEMP AS T ON O.CNT = T.CNT ORDER BY T.NUM DESC LIMIT 1;

/*
Prediction Result:
(-715,)
*/