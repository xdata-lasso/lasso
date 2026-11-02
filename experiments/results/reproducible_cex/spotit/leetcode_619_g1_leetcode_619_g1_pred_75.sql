-- Schema DDL
CREATE TABLE "MYNUMBERS" (
    "NUM" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MYNUMBERS VALUES (2);
INSERT INTO MYNUMBERS VALUES (1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT MAX(NEWNUM) AS NUM FROM MYNUMBERS AS A CROSS JOIN (SELECT NUM AS NEWNUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = '1') AS NEW;

/*
Prediction Result:
(None,)
*/