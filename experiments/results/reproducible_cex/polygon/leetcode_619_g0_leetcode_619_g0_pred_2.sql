-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-133);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-133,)
*/

-- Prediction Query
SELECT (CASE WHEN COUNT = 1 THEN MAX(NUM) ELSE NULL END) AS NUM FROM (SELECT NUM, COUNT(NUM) AS COUNT FROM MYNUMBERS GROUP BY 1 HAVING COUNT(NUM) = 1) AS A;

/*
Prediction Result:
(-133,)
*/