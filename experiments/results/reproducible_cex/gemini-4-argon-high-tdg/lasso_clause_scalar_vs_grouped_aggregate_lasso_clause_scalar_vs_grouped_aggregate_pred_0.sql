-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO employee (id, name, department_id, salary) VALUES (1, 'Alice', 'D101', 100.0);
INSERT INTO employee (id, name, department_id, salary) VALUES (2, 'Bob', 'D101', 200.0);
INSERT INTO employee (id, name, department_id, salary) VALUES (3, 'Charlie', 'D101', 400.0);
INSERT INTO employee (id, name, department_id, salary) VALUES (4, 'David', 'D102', 800.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
('Alice', 700.0)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
('Alice', 100.0)
('Bob', 200.0)
('Charlie', 400.0)
*/