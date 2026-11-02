-- Schema DDL
CREATE TABLE emp (emp_id INTEGER PRIMARY KEY, salary INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO emp (emp_id, salary) VALUES (1, 49);
INSERT INTO emp (emp_id, salary) VALUES (2, 50);
INSERT INTO emp (emp_id, salary) VALUES (3, 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH t AS (SELECT emp_id, salary AS s FROM emp) SELECT emp_id, s FROM t WHERE s > 50;

/*
Gold Result:
(3, 51)
*/

-- Prediction Query
WITH t AS (SELECT emp_id, salary AS s FROM emp) SELECT emp_id, s FROM t WHERE s >= 50;

/*
Prediction Result:
(2, 50)
(3, 51)
*/