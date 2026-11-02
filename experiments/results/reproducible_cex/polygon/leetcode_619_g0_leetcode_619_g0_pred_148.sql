-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CTE AS (SELECT NUM, COUNT(NUM) OVER (PARTITION BY NUM) AS NUM_CNT FROM MYNUMBERS) SELECT MAX(NUM) AS NUM FROM CTE WHERE CTE.NUM_CNT < 2;

/*
Prediction Result:
(None,)
*/