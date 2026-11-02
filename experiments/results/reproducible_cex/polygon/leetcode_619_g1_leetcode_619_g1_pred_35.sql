-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(-3,)
*/

-- Prediction Query
SELECT CASE WHEN COUNT(A.NUM) > 0 THEN A.NUM ELSE NULL END AS NUM FROM (SELECT NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(*) = 1 ORDER BY NUM DESC LIMIT 1) AS A;

/*
Prediction Result:
(-3,)
*/