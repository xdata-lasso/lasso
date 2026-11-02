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
SELECT CASE WHEN A.OCCUR = 1 THEN A.NUM ELSE NULL END AS NUM FROM (SELECT NUM, COUNT(NUM) AS OCCUR FROM MYNUMBERS GROUP BY NUM ORDER BY OCCUR ASC, NUM DESC LIMIT 1) AS A;

/*
Prediction Result:
*/