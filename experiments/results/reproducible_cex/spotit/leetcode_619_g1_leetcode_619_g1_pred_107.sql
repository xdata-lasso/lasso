-- Schema DDL
CREATE TABLE "MYNUMBERS" (
    "NUM" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MYNUMBERS VALUES (0);
INSERT INTO MYNUMBERS VALUES (1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM mynumbers WHERE num IN (SELECT IIF(COUNT(num) = 1, num, 0) FROM mynumbers GROUP BY num HAVING COUNT(num) = 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT MAX(NUM) AS NUM FROM (SELECT NUM, COUNT(NUM) AS C FROM MYNUMBERS GROUP BY NUM HAVING C = 1 OR C IS NULL ORDER BY NUM DESC, C NULLS LAST LIMIT 1) AS SAB;

/*
Prediction Result:
(1,)
*/