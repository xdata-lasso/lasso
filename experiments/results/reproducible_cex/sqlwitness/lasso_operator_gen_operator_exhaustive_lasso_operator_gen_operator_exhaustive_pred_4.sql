-- Schema DDL
CREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, salary REAL, hire_date DATE, department TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (id, name, salary, hire_date, department) VALUES (50001, 'default1', 50001.0, NULL, 'default2'), (49999, 'default1', 0.0, '2023-01-02', 'Engineering'), (0, 'Engineering', 49999.0, NULL, 'Engineering'), (50000, 'default2', 50000.0, '2023-01-02', 'default1'), (1, 'default1', 0.0, '2023-01-02', 'default2'), (2, 'default1', 0.0, '2023-01-02', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employees WHERE salary >= 50000 AND department = 'Engineering';

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM employees WHERE salary <> 50000 AND department = 'Engineering';

/*
Prediction Result:
('Engineering',)
('default1',)
*/