-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER, salary INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO employees (emp_id, dept_id, salary) VALUES (1, 10, 50);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (2, 10, 50);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (3, 20, 50);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (4, 20, 51);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (5, 30, 70);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (6, 30, 50);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (7, 40, 69);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (8, 40, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) > 100 AND MAX(salary) < 70;

/*
Gold Result:
(20, 101)
(40, 119)
*/

-- Prediction Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) >= 100 AND MAX(salary) < 70;

/*
Prediction Result:
(10, 100)
(20, 101)
(40, 119)
*/