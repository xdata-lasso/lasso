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
SELECT IIF(COUNT(*) = 0, NULL, NUM) AS NUM FROM (SELECT NUM, COUNT(*) AS CNT FROM MYNUMBERS GROUP BY NUM HAVING CNT = 1 ORDER BY NUM DESC, CNT NULLS LAST LIMIT 1) AS S;

/*
Prediction Result:
(-3,)
*/