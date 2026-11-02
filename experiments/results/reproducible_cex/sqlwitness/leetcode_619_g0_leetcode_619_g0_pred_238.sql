-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (1), (0), (NULL), (2), (0), (-1), (NULL), (2), (2), (2), (0), (1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT MAX(NUM) AS NUM FROM MYNUMBERS WHERE NUM IN (SELECT IIF(COUNT(NUM) = 1, NUM, 0) FROM MYNUMBERS GROUP BY NUM);

/*
Prediction Result:
(0,)
*/