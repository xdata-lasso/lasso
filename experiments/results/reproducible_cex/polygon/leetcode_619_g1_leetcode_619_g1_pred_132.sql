-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-410);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(-410,)
*/

-- Prediction Query
WITH PRE AS (SELECT MAX(NUM) AS NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(*) = 1 ORDER BY MAX(NUM) DESC, NUM NULLS LAST LIMIT 1) SELECT CASE WHEN COUNT(*) = 0 THEN NULL ELSE NUM END AS NUM FROM PRE;

/*
Prediction Result:
(-410,)
*/