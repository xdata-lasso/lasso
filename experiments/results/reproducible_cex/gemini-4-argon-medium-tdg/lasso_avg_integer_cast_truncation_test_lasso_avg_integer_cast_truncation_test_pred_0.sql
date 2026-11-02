-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, sal INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests floating-point division vs integer division (SUM(sal) / COUNT(sal) in SQLite).
-- AVG(sal) = 1.5, whereas integer division 3 / 2 = 1.
INSERT INTO emp (id, sal) VALUES (10, 1);
INSERT INTO emp (id, sal) VALUES (20, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(sal) FROM emp;

/*
Gold Result:
(1.5,)
*/

-- Prediction Query
SELECT CAST(AVG(sal) AS INTEGER) FROM emp;

/*
Prediction Result:
(1,)
*/