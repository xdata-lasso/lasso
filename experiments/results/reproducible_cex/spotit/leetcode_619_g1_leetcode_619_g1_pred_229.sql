-- Schema DDL
CREATE TABLE "MYNUMBERS" (
    "NUM" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MYNUMBERS VALUES (3);
INSERT INTO MYNUMBERS VALUES (4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT CASE WHEN TOTAL >= 2 THEN NUM = NULL ELSE NUM END AS NUM FROM (SELECT NUM, COUNT(NUM) AS TOTAL FROM MYNUMBERS GROUP BY NUM ORDER BY TOTAL ASC, NUM DESC LIMIT 1) AS X;

/*
Prediction Result:
(4,)
*/