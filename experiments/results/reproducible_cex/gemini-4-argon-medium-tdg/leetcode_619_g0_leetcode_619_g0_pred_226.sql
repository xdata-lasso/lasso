-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO mynumbers (num) VALUES (-10);
INSERT INTO mynumbers (num) VALUES (-5);
INSERT INTO mynumbers (num) VALUES (-2);
INSERT INTO mynumbers (num) VALUES (-2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-5,)
*/

-- Prediction Query
SELECT IIF(MAX(SUB.NUM) >= 1, MAX(SUB.NUM), NULL) AS NUM FROM (SELECT NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = 1) AS SUB;

/*
Prediction Result:
(None,)
*/