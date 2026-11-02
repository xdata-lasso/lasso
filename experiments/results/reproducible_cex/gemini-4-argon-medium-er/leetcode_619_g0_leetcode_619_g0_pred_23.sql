-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (NULL);
INSERT INTO mynumbers (num) VALUES (NULL);
INSERT INTO mynumbers (num) VALUES (1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT MAX(NUM) AS NUM FROM MYNUMBERS WHERE NOT NUM IN (SELECT NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(*) > 1) ORDER BY NUM DESC LIMIT 1;

/*
Prediction Result:
(None,)
*/