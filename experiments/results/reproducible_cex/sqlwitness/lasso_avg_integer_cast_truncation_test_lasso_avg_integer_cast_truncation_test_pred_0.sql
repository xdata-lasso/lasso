-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, sal INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO emp (id, sal) VALUES (1, 1), (0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(sal) FROM emp;

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT CAST(AVG(sal) AS INTEGER) FROM emp;

/*
Prediction Result:
(0,)
*/