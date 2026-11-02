-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT MAX(NUM) AS NUM FROM MYNUMBERS WHERE NUM IN (SELECT IIF(COUNT(NUM) = 1, NUM, 0) FROM MYNUMBERS GROUP BY NUM);

/*
Prediction Result:
(0,)
*/