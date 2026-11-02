-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
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
SELECT CASE WHEN COUNT(*) = 0 THEN NULL ELSE T.NUM END AS NUM FROM (SELECT NUM FROM MYNUMBERS AS M GROUP BY NUM HAVING COUNT(NUM) = 1 ORDER BY NUM DESC LIMIT 1) AS T;

/*
Prediction Result:
(-3,)
*/