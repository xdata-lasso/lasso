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
WITH CTE AS (SELECT M1.NUM, COUNT(M2.NUM) AS C FROM MYNUMBERS AS M1 JOIN MYNUMBERS AS M2 ON M1.NUM = M2.NUM GROUP BY M1.NUM), CTE2 AS (SELECT NUM FROM CTE WHERE C = 1 ORDER BY NUM DESC LIMIT 1) SELECT IIF(COUNT(*) = 0, NULL, NUM) AS NUM FROM CTE2;

/*
Prediction Result:
(-715,)
*/