-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (NULL);
INSERT INTO "mynumbers" ("num") VALUES (-544);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-544,)
*/

-- Prediction Query
SELECT CASE WHEN SUM(NUM_COUNT) = 0 THEN NULL ELSE MAX(NUM_COUNT) END AS NUM FROM (SELECT CASE WHEN COUNT(NUM) = 1 THEN NUM ELSE 0 END AS NUM_COUNT FROM MYNUMBERS GROUP BY NUM) AS SUBQ;

/*
Prediction Result:
(0,)
*/