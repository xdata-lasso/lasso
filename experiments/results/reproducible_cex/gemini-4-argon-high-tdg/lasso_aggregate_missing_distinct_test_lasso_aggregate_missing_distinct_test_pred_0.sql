-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, department TEXT, employee_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sales (id, department, employee_id) VALUES (1, 'Engineering', 101);
INSERT INTO sales (id, department, employee_id) VALUES (2, 'Engineering', 101);
INSERT INTO sales (id, department, employee_id) VALUES (3, 'Engineering', 102);
INSERT INTO sales (id, department, employee_id) VALUES (4, 'Marketing', 201);
INSERT INTO sales (id, department, employee_id) VALUES (5, 'Sales', 101);
INSERT INTO sales (id, department, employee_id) VALUES (6, 'Sales', 301);
INSERT INTO sales (id, department, employee_id) VALUES (7, 'Sales', 302);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department, COUNT(DISTINCT employee_id) FROM sales GROUP BY department;

/*
Gold Result:
('Engineering', 2)
('Marketing', 1)
('Sales', 3)
*/

-- Prediction Query
SELECT department, COUNT(employee_id) FROM sales GROUP BY department;

/*
Prediction Result:
('Engineering', 3)
('Marketing', 1)
('Sales', 3)
*/