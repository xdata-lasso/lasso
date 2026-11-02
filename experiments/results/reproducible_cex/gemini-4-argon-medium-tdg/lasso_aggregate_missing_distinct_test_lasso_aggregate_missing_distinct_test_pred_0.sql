-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, department TEXT, employee_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sales (id, department, employee_id) VALUES (1, 'HR', 101);
INSERT INTO sales (id, department, employee_id) VALUES (2, 'HR', 101);
INSERT INTO sales (id, department, employee_id) VALUES (3, 'HR', 102);
INSERT INTO sales (id, department, employee_id) VALUES (4, 'IT', 101);
INSERT INTO sales (id, department, employee_id) VALUES (5, 'IT', 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department, COUNT(DISTINCT employee_id) FROM sales GROUP BY department;

/*
Gold Result:
('HR', 2)
('IT', 2)
*/

-- Prediction Query
SELECT department, COUNT(employee_id) FROM sales GROUP BY department;

/*
Prediction Result:
('HR', 3)
('IT', 2)
*/