-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, department TEXT, employee_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sales (id, department, employee_id) VALUES (1, 'IT', 101);
INSERT INTO sales (id, department, employee_id) VALUES (2, 'IT', 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department, COUNT(DISTINCT employee_id) FROM sales GROUP BY department;

/*
Gold Result:
('IT', 1)
*/

-- Prediction Query
SELECT department, COUNT(employee_id) FROM sales GROUP BY department;

/*
Prediction Result:
('IT', 2)
*/