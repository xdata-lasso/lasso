-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, dept_id INTEGER, salary INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (5, 6, 69);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (4, 6, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) > 100 AND MAX(salary) < 70;

/*
Gold Result:
*/

-- Prediction Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) >= 100 AND MAX(salary) < 70;

/*
Prediction Result:
(6, 100)
*/