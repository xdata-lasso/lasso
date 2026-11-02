-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT IIF(COUNT(NUM) = 1, NUM, NULL) AS NUM FROM MYNUMBERS GROUP BY NUM HAVING MAX(NUM) ORDER BY NUM DESC LIMIT 1;

/*
Prediction Result:
*/