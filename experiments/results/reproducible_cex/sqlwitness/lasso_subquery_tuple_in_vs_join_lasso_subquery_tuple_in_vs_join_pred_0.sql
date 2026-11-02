-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, role_id INTEGER);

CREATE TABLE dept_mgr (mgr_id INTEGER, dept_id INTEGER, role_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (0, 0, NULL), (1, NULL, 1), (1, 0, 1), (1, 1, 1), (0, NULL, NULL), (NULL, 1, 0), (0, 0, 1), (NULL, 0, 1), (NULL, 0, 1), (1, 0, NULL), (0, 0, 0), (1, 1, 1), (1, 1, NULL), (0, 0, 0), (1, NULL, NULL), (0, 1, 0), (0, 1, 1), (1, 0, 0), (0, 1, NULL);
INSERT INTO emp (id, name, dept_id, role_id) VALUES (1, 'default2', 1, 1), (0, 'default1', NULL, NULL), (2, 'default1', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM emp WHERE (role_id, dept_id) IN (SELECT mgr_id, dept_id FROM dept_mgr);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT e.name FROM emp AS e INNER JOIN dept_mgr AS d ON e.role_id = d.mgr_id AND e.dept_id = d.dept_id;

/*
Prediction Result:
('default2',)
('default2',)
('default2',)
*/