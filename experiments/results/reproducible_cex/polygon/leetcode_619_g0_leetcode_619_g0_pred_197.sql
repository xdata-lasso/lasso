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
WITH CTE AS (SELECT NUM, RANK() OVER (ORDER BY NUM DESC) AS RANKING FROM MYNUMBERS GROUP BY 1 HAVING COUNT(*) = 1) SELECT MAX(NUM) AS NUM FROM CTE WHERE RANKING = 1;

/*
Prediction Result:
(-715,)
*/