-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-715);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-715,)
*/

-- Prediction Query
WITH T1 AS (SELECT NUM, COUNT(*) OVER (PARTITION BY NUM) AS CNT_NUM FROM MYNUMBERS) SELECT MAX(T.NUM) AS NUM FROM T1 AS T WHERE T.CNT_NUM = 1;

/*
Prediction Result:
(-715,)
*/