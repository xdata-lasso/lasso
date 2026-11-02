-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (-1), (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH SINGLE AS (SELECT CASE WHEN MAX(DISTINCT NUM) THEN NUM ELSE NULL END AS NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = 1) SELECT MAX(NUM) AS NUM FROM SINGLE;

/*
Prediction Result:
(-1,)
*/