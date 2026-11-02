-- Schema DDL
CREATE TABLE "MYNUMBERS" (
    "NUM" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MYNUMBERS VALUES (1);
INSERT INTO MYNUMBERS VALUES (2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT IIF(COUNT(*) = 0, NULL, NUM) AS NUM FROM (SELECT NUM, COUNT(*) AS CNT FROM MYNUMBERS GROUP BY NUM HAVING CNT = 1 ORDER BY NUM DESC, CNT NULLS LAST LIMIT 1) AS S;

/*
Prediction Result:
(2,)
*/