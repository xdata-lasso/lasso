-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, department_id INTEGER, bonus INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("emp_id", "department_id", "bonus") VALUES (1021, 1022, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT E1.emp_id FROM employees AS E1 CROSS JOIN employees AS E2 WHERE E1.emp_id = E2.emp_id AND E1.bonus = E2.bonus;

/*
Gold Result:
*/

-- Prediction Query
SELECT E1.emp_id FROM employees AS E1 CROSS JOIN employees AS E2 WHERE E1.emp_id = E2.emp_id;

/*
Prediction Result:
(1021,)
*/