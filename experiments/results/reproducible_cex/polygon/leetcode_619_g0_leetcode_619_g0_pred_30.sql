-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-715);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-715,)
*/

-- Prediction Query
SELECT MAX(NUM) AS NUM FROM (SELECT NUM, COUNT(*) OVER (PARTITION BY NUM ORDER BY NUM DESC) AS COUNT_NUM FROM MYNUMBERS) AS SUB WHERE COUNT_NUM = 1;

/*
Prediction Result:
(-715,)
*/