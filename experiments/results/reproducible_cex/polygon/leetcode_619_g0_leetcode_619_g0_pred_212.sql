-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-2617);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-2617,)
*/

-- Prediction Query
WITH SBN AS (SELECT NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = 1 ORDER BY NUM DESC LIMIT 1) SELECT (CASE WHEN COUNT(*) = 0 THEN NULL ELSE NUM END) AS NUM FROM SBN;

/*
Prediction Result:
(-2617,)
*/