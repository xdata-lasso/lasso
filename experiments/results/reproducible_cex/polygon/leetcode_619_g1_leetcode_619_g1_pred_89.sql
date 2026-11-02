-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (6907);
INSERT INTO "mynumbers" ("num") VALUES (6906);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(6907,)
*/

-- Prediction Query
SELECT MAX(NUM) AS NUM FROM (SELECT NUM, COUNT(NUM) OVER (PARTITION BY NUM) AS NUM_COUNT FROM MYNUMBERS) AS T1 WHERE NUM_COUNT = 1;

/*
Prediction Result:
(6907,)
*/