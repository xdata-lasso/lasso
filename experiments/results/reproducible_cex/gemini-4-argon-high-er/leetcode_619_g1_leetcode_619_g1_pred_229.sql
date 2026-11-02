-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (NULL);
INSERT INTO mynumbers (num) VALUES (5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT CASE WHEN TOTAL >= 2 THEN NUM = NULL ELSE NUM END AS NUM FROM (SELECT NUM, COUNT(NUM) AS TOTAL FROM MYNUMBERS GROUP BY NUM ORDER BY TOTAL ASC, NUM DESC LIMIT 1) AS X;

/*
Prediction Result:
(None,)
*/