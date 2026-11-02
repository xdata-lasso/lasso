-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER, salary INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core logic, exact boundaries (SUM=100, SUM=101, MAX=69, MAX=70), and AND vs OR
INSERT INTO employees (emp_id, dept_id, salary) VALUES (1, 1, 69);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (2, 1, 32);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (3, 2, 50);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (4, 2, 50);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (5, 3, 70);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (6, 3, 40);
INSERT INTO employees (emp_id, dept_id, salary) VALUES (7, 4, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) > 100 AND MAX(salary) < 70;

/*
Gold Result:
(1, 101)
*/

-- Prediction Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) >= 100 AND MAX(salary) < 70;

/*
Prediction Result:
(1, 101)
(2, 100)
*/