-- Schema DDL
CREATE TABLE employee (id INTEGER PRIMARY KEY, name TEXT, department_id TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard filtering, aggregation, and distinguishes GROUP BY name vs ungrouped aggregate, as well as SUM vs AVG/MAX/MIN/COUNT and SUM(DISTINCT salary) vs SUM(salary).
INSERT INTO employee (id, name, department_id, salary) VALUES (1, 'Alice', 'D101', 100.0);
INSERT INTO employee (id, name, department_id, salary) VALUES (2, 'Bob', 'D101', 100.0);
INSERT INTO employee (id, name, department_id, salary) VALUES (3, 'Charlie', 'D101', 250.5);
INSERT INTO employee (id, name, department_id, salary) VALUES (4, 'David', 'D102', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101';

/*
Gold Result:
('Alice', 450.5)
*/

-- Prediction Query
SELECT name, SUM(salary) FROM employee WHERE department_id = 'D101' GROUP BY name;

/*
Prediction Result:
('Alice', 100.0)
('Bob', 100.0)
('Charlie', 250.5)
*/