-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (-715);
INSERT INTO "mynumbers" ("num") VALUES (1902);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(1902,)
*/

-- Prediction Query
WITH TA AS (SELECT NUM, COUNT(*) AS A FROM MYNUMBERS GROUP BY NUM ORDER BY A, NUM DESC LIMIT 1) SELECT CASE WHEN (SELECT MIN(A) FROM TA) = 1 THEN NUM ELSE NULL END AS NUM FROM TA;

/*
Prediction Result:
(1902,)
*/