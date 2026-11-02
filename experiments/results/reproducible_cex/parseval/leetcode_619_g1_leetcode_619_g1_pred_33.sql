-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mynumbers --
INSERT INTO "mynumbers" ("num") VALUES (1);

INSERT INTO "mynumbers" ("num") VALUES (NULL);

INSERT INTO "mynumbers" ("num") VALUES (NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT MAX(NUM) AS NUM FROM MYNUMBERS WHERE NOT NUM IN (SELECT DISTINCT NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(*) > 1);

/*
Prediction Result:
(None,)
*/