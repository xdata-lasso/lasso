-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO mynumbers (num) VALUES (NULL);
INSERT INTO mynumbers (num) VALUES (NULL);
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (-3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(-3,)
*/

-- Prediction Query
SELECT CASE WHEN A.OCCUR = 1 THEN A.NUM ELSE NULL END AS NUM FROM (SELECT NUM, COUNT(NUM) AS OCCUR FROM MYNUMBERS GROUP BY NUM ORDER BY OCCUR ASC, NUM DESC LIMIT 1) AS A;

/*
Prediction Result:
(None,)
*/