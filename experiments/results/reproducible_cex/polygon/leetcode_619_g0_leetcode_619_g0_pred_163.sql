-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (3504);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(3504,)
*/

-- Prediction Query
SELECT CASE WHEN COUNT_NUM IS NULL THEN NULL ELSE MAX(NUM) END AS NUM FROM (SELECT NUM, COUNT(NUM) AS COUNT_NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT_NUM = 1) AS S;

/*
Prediction Result:
(3504,)
*/