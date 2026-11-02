-- Schema DDL
CREATE TABLE emp (emp_id INTEGER PRIMARY KEY, salary INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO emp (emp_id, salary) VALUES (1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH t AS (SELECT emp_id, salary AS s FROM emp) SELECT emp_id, s FROM t WHERE s > 50;

/*
Gold Result:
*/

-- Prediction Query
WITH t AS (SELECT emp_id, salary AS s FROM emp) SELECT emp_id, s FROM t WHERE s >= 50;

/*
Prediction Result:
(1, 50)
*/