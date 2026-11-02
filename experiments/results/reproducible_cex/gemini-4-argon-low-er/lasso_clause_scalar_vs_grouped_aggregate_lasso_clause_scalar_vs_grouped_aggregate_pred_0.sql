-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (id, name, department_id, salary) VALUES (1, 'Alice', 'D101', 50000.0);
INSERT INTO employee (id, name, department_id, salary) VALUES (2, 'Bob', 'D101', 60000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
('Alice', 110000.0)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
('Alice', 50000.0)
('Bob', 60000.0)
*/