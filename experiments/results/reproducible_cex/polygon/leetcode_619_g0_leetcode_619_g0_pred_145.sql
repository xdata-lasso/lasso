-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (NULL);
INSERT INTO "mynumbers" ("num") VALUES (-3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-3,)
*/

-- Prediction Query
WITH NUMBER_CNT AS (SELECT NUM, COUNT(NUM) OVER (PARTITION BY NUM) AS NUM_CNT FROM MYNUMBERS) SELECT MAX(NUM) AS NUM FROM NUMBER_CNT WHERE NUM_CNT = 1;

/*
Prediction Result:
(-3,)
*/