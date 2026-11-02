-- Schema DDL
CREATE TABLE "MYNUMBERS" (
    "NUM" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MYNUMBERS VALUES (-1);
INSERT INTO MYNUMBERS VALUES (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CASE WHEN A.OCCUR = 1 THEN A.NUM ELSE NULL END AS NUM FROM (SELECT NUM, COUNT(NUM) AS OCCUR FROM MYNUMBERS GROUP BY NUM ORDER BY OCCUR ASC, NUM DESC LIMIT 1) AS A;

/*
Prediction Result:
(0,)
*/