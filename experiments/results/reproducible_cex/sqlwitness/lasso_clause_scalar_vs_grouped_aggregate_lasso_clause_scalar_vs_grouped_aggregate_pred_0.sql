-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
*/