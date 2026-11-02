-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO mynumbers (num) VALUES (-5);
INSERT INTO mynumbers (num) VALUES (-2);
INSERT INTO mynumbers (num) VALUES (-2);
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

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