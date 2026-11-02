-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (id, name, department_id, salary) VALUES (1, 'Alice', 'D101', 50000.50);
INSERT INTO employee (id, name, department_id, salary) VALUES (2, 'Bob', 'D101', 60000.75);
INSERT INTO employee (id, name, department_id, salary) VALUES (3, 'Charlie', 'D102', 70000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
('Alice', 110001.25)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
('Alice', 50000.5)
('Bob', 60000.75)
*/