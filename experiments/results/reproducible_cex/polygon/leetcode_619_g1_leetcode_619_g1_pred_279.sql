-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (NULL);
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
WITH A AS (SELECT DISTINCT NUM, COUNT(*) OVER (PARTITION BY NUM) AS COUNT_NUM FROM MYNUMBERS) SELECT MAX(A.NUM) AS NUM FROM A WHERE A.COUNT_NUM = 1;

/*
Prediction Result:
(-3,)
*/