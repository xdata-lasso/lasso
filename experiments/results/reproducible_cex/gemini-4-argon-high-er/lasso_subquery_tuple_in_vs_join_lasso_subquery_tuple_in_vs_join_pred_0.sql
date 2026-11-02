-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, role_id INTEGER);

CREATE TABLE dept_mgr (mgr_id INTEGER, dept_id INTEGER, role_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO emp (id, name, dept_id, role_id) VALUES (1, 'Alice', 10, 100);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (100, 10, 1);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (100, 10, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM emp WHERE (role_id, dept_id) IN (SELECT mgr_id, dept_id FROM dept_mgr);

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT e.name FROM emp AS e INNER JOIN dept_mgr AS d ON e.role_id = d.mgr_id AND e.dept_id = d.dept_id;

/*
Prediction Result:
('Alice',)
('Alice',)
*/