-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests presence of NULL values and single 0.
-- Note: COUNT(num) ignores NULLs, so for the NULL group, COUNT(num) is 0, which fails HAVING COUNT(num) = 1.
-- Catches mutants that use COUNT(*) instead of COUNT(num) when NULLs are present.
INSERT INTO mynumbers (num) VALUES (NULL);
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (-3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CASE WHEN A.OCCUR = 1 THEN A.NUM ELSE NULL END AS NUM FROM (SELECT NUM, COUNT(NUM) AS OCCUR FROM MYNUMBERS GROUP BY NUM ORDER BY OCCUR ASC, NUM DESC LIMIT 1) AS A;

/*
Prediction Result:
(None,)
*/