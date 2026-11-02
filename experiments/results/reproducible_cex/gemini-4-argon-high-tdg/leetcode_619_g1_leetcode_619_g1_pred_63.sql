-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO mynumbers (num) VALUES (0);
INSERT INTO mynumbers (num) VALUES (-4);
INSERT INTO mynumbers (num) VALUES (5);
INSERT INTO mynumbers (num) VALUES (5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT IIF(COUNT(NUM) = 1, NUM, NULL) AS NUM FROM MYNUMBERS GROUP BY NUM HAVING MAX(NUM) ORDER BY NUM DESC LIMIT 1;

/*
Prediction Result:
(-4,)
*/