-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (2), (NULL), (0), (3), (2), (NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT CASE WHEN TOTAL >= 2 THEN NUM = NULL ELSE NUM END AS NUM FROM (SELECT NUM, COUNT(NUM) AS TOTAL FROM MYNUMBERS GROUP BY NUM ORDER BY TOTAL ASC, NUM DESC LIMIT 1) AS X;

/*
Prediction Result:
(None,)
*/