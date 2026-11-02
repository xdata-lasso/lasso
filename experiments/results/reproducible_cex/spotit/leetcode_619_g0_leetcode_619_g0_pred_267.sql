-- Schema DDL
CREATE TABLE "MYNUMBERS" (
    "NUM" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MYNUMBERS VALUES (NULL);
INSERT INTO MYNUMBERS VALUES (1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(num) AS num FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(num) = 1) AS T;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT CASE COUNT(*) WHEN 1 THEN NUM ELSE NULL END AS NUM FROM (SELECT NUM FROM MYNUMBERS GROUP BY NUM HAVING COUNT(*) = 1 ORDER BY NUM DESC LIMIT 1) AS T;

/*
Prediction Result:
(1,)
*/