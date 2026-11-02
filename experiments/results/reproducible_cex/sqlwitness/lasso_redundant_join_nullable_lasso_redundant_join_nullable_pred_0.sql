-- Schema DDL
CREATE TABLE employees (emp_id INTEGER PRIMARY KEY, department_id INTEGER, bonus INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (emp_id, department_id, bonus) VALUES (0, 0, NULL), (1, 0, NULL), (2, 1, 0), (3, 0, 1), (4, 0, NULL), (5, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT E1.emp_id FROM employees AS E1 CROSS JOIN employees AS E2 WHERE E1.emp_id = E2.emp_id AND E1.bonus = E2.bonus;

/*
Gold Result:
(2,)
(3,)
(5,)
*/

-- Prediction Query
SELECT E1.emp_id FROM employees AS E1 CROSS JOIN employees AS E2 WHERE E1.emp_id = E2.emp_id;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(5,)
*/