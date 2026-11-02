-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-2);
INSERT INTO "mynumbers" ("num") VALUES (-3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-2,)
*/

-- Prediction Query
WITH NUMBER_CNT AS (SELECT NUM, COUNT(NUM) OVER (PARTITION BY NUM) AS NUM_CNT FROM MYNUMBERS) SELECT COALESCE(MAX(NUM), NULL) AS NUM FROM NUMBER_CNT WHERE NUM_CNT = 1;

/*
Prediction Result:
(-2,)
*/