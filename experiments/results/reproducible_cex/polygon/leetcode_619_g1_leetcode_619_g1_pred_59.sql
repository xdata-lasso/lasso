-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (9532);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(9532,)
*/

-- Prediction Query
SELECT CASE WHEN COUNT(*) = 0 THEN NULL ELSE T.NUM END AS NUM FROM (SELECT NUM FROM MYNUMBERS AS M GROUP BY NUM HAVING COUNT(NUM) = 1 ORDER BY NUM DESC LIMIT 1) AS T;

/*
Prediction Result:
(9532,)
*/