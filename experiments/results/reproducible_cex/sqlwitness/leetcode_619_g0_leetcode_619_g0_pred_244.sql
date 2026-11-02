-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT IIF(T.COUNT_NUM = 1, NUM, NULL) AS NUM FROM (SELECT NUM, COUNT(NUM) AS COUNT_NUM FROM MYNUMBERS GROUP BY NUM ORDER BY COUNT_NUM ASC, NUM DESC) AS T LIMIT 1;

/*
Prediction Result:
*/