-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mynumbers (num) VALUES (8);
INSERT INTO mynumbers (num) VALUES (8);
INSERT INTO mynumbers (num) VALUES (3);
INSERT INTO mynumbers (num) VALUES (3);
INSERT INTO mynumbers (num) VALUES (1);
INSERT INTO mynumbers (num) VALUES (4);
INSERT INTO mynumbers (num) VALUES (5);
INSERT INTO mynumbers (num) VALUES (6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT MAX(NEWNUM) AS NUM FROM MYNUMBERS AS A CROSS JOIN (SELECT NUM AS NEWNUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = '1') AS NEW;

/*
Prediction Result:
(None,)
*/