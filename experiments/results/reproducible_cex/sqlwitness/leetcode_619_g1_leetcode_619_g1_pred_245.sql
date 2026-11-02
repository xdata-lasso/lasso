-- Schema DDL
CREATE TABLE "mynumbers" ("num" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mynumbers (num) VALUES (0), (NULL), (-1), (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT IIF(T.COUNT_NUM = 1, NUM, NULL) AS NUM FROM (SELECT NUM, COUNT(NUM) AS COUNT_NUM FROM MYNUMBERS GROUP BY NUM ORDER BY COUNT_NUM ASC, NUM DESC) AS T LIMIT 1;

/*
Prediction Result:
(None,)
*/