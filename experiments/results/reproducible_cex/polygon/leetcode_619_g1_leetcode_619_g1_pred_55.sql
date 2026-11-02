-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mynumbers" ("num") VALUES (6879);
INSERT INTO "mynumbers" ("num") VALUES (6880);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(6880,)
*/

-- Prediction Query
WITH TA AS (SELECT NUM, COUNT(*) AS A FROM MYNUMBERS GROUP BY NUM ORDER BY A, NUM DESC LIMIT 1) SELECT CASE WHEN (SELECT MIN(A) FROM TA) = 1 THEN NUM ELSE NULL END AS NUM FROM TA;

/*
Prediction Result:
(6880,)
*/