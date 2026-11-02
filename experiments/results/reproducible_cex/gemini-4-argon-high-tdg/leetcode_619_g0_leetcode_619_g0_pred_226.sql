-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO mynumbers (num) VALUES (-8);
INSERT INTO mynumbers (num) VALUES (4);
INSERT INTO mynumbers (num) VALUES (-1);
INSERT INTO mynumbers (num) VALUES (-2);
INSERT INTO mynumbers (num) VALUES (4);
INSERT INTO mynumbers (num) VALUES (-15);
INSERT INTO mynumbers (num) VALUES (-1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-2,)
*/

-- Prediction Query
SELECT IIF(MAX(SUB.NUM) >= 1, MAX(SUB.NUM), NULL) AS NUM FROM (SELECT NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = 1) AS SUB;

/*
Prediction Result:
(None,)
*/