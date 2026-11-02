-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, department TEXT, employee_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sales (id, department, employee_id) VALUES (0, 'default2', 1), (1, 'default2', NULL), (2, NULL, NULL), (3, 'default2', 0), (4, NULL, NULL), (5, 'default1', NULL), (6, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department, COUNT(DISTINCT employee_id) FROM sales GROUP BY department;

/*
Gold Result:
(None, 0)
('default1', 0)
('default2', 2)
*/

-- Prediction Query
SELECT department, COUNT(employee_id) FROM sales GROUP BY department;

/*
Prediction Result:
(None, 0)
('default1', 0)
('default2', 3)
*/