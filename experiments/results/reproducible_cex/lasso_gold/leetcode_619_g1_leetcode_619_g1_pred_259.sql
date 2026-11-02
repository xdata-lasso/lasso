-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (1030);
INSERT INTO "mynumbers" ("num") VALUES (1033.0);
INSERT INTO "mynumbers" ("num") VALUES (1036.0);
INSERT INTO "mynumbers" ("num") VALUES (1039.0);
INSERT INTO "mynumbers" ("num") VALUES (NULL);
INSERT INTO "mynumbers" ("num") VALUES (NULL);
INSERT INTO "mynumbers" ("num") VALUES (NULL);
INSERT INTO "mynumbers" ("num") VALUES (NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(1039,)
*/

-- Prediction Query
WITH CTE AS (SELECT NUM, ROW_NUMBER() OVER (PARTITION BY NUM ORDER BY NUM DESC) AS ROWNUM FROM MYNUMBERS) SELECT MAX(NUM) AS NUM FROM CTE WHERE NOT NUM IN (SELECT NUM FROM CTE WHERE ROWNUM > 1);

/*
Prediction Result:
(None,)
*/