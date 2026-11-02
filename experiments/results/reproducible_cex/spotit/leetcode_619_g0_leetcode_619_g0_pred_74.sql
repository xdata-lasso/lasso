-- Schema DDL
CREATE TABLE "MYNUMBERS" (
    "NUM" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MYNUMBERS VALUES (NULL);
INSERT INTO MYNUMBERS VALUES (8856);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(8856,)
*/

-- Prediction Query
SELECT MAX(NEWNUM) AS NUM FROM MYNUMBERS AS A CROSS JOIN (SELECT NUM AS NEWNUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(NUM) = '1') AS NEW;

/*
Prediction Result:
(None,)
*/