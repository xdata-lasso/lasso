-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, sal INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO emp (id, sal) VALUES (1, 10);
INSERT INTO emp (id, sal) VALUES (2, 10);
INSERT INTO emp (id, sal) VALUES (3, 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(sal) FROM emp;

/*
Gold Result:
(13.666666666666666,)
*/

-- Prediction Query
SELECT CAST(AVG(sal) AS INTEGER) FROM emp;

/*
Prediction Result:
(13,)
*/