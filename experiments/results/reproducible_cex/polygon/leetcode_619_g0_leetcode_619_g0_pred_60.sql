-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (NULL);
INSERT INTO "mynumbers" ("num") VALUES (1594);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(1594,)
*/

-- Prediction Query
SELECT IIF(COUNT(*) = 1, NUM, NULL) AS NUM FROM MYNUMBERS GROUP BY NUM ORDER BY COUNT(*), NUM DESC LIMIT 1;

/*
Prediction Result:
(1594,)
*/