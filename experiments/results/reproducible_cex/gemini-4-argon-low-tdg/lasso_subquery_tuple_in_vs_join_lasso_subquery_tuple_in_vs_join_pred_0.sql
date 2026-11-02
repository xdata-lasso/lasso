-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, role_id INTEGER);

CREATE TABLE dept_mgr (mgr_id INTEGER, dept_id INTEGER, role_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO emp (id, name, dept_id, role_id) VALUES (1, 'Grace', 10, 100);
INSERT INTO emp (id, name, dept_id, role_id) VALUES (2, 'Grace', 20, 200);
INSERT INTO emp (id, name, dept_id, role_id) VALUES (3, 'Heidi', 30, 300);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (100, 10, 1);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (200, 20, 2);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (300, 30, 3);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (300, 30, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM emp WHERE (role_id, dept_id) IN (SELECT mgr_id, dept_id FROM dept_mgr);

/*
Gold Result:
('Grace',)
('Grace',)
('Heidi',)
*/

-- Prediction Query
SELECT e.name FROM emp AS e INNER JOIN dept_mgr AS d ON e.role_id = d.mgr_id AND e.dept_id = d.dept_id;

/*
Prediction Result:
('Grace',)
('Grace',)
('Heidi',)
('Heidi',)
*/