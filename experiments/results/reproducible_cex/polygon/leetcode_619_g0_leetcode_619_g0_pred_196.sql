-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (NULL);
INSERT INTO "mynumbers" ("num") VALUES (8880);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(8880,)
*/

-- Prediction Query
SELECT COALESCE(MAX(NUM), NULL) AS NUM FROM (SELECT DISTINCT NUM, COUNT(*) OVER (PARTITION BY NUM) AS C FROM MYNUMBERS) AS T WHERE C = 1;

/*
Prediction Result:
(8880,)
*/