-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (-5);
INSERT INTO mynumbers (num) VALUES (-2);
INSERT INTO mynumbers (num) VALUES (-10);
INSERT INTO mynumbers (num) VALUES (-10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(-2,)
*/

-- Prediction Query
SELECT CASE WHEN SUM(NUM_COUNT) = 0 THEN NULL ELSE MAX(NUM_COUNT) END AS NUM FROM (SELECT CASE WHEN COUNT(NUM) = 1 THEN NUM ELSE 0 END AS NUM_COUNT FROM MYNUMBERS GROUP BY NUM) AS SUBQ;

/*
Prediction Result:
(0,)
*/