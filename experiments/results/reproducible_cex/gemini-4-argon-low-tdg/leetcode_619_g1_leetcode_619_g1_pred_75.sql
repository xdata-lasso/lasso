-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard case where the overall maximum is duplicated (8), and there are multiple single numbers (3, 6).
-- Catches mutants that omit the uniqueness check (returning 8), use MIN instead of MAX (returning 3), or return all singles without MAX.
INSERT INTO mynumbers (num) VALUES (8);
INSERT INTO mynumbers (num) VALUES (8);
INSERT INTO mynumbers (num) VALUES (3);
INSERT INTO mynumbers (num) VALUES (6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

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