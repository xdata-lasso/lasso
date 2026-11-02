-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-715);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(-715,)
*/

-- Prediction Query
WITH MIN_COUNTS AS (SELECT NUM, DENSE_RANK() OVER (ORDER BY NUM DESC) AS RNK FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = 1) SELECT MAX(NUM) AS NUM FROM MIN_COUNTS WHERE RNK = 1;

/*
Prediction Result:
(-715,)
*/