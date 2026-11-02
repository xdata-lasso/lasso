-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, role_id INTEGER);

CREATE TABLE dept_mgr (mgr_id INTEGER, dept_id INTEGER, role_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests cardinality and duplicate elimination: INNER JOIN without DISTINCT vs IN subquery, and duplicate employee names.
INSERT INTO emp (id, name, dept_id, role_id) VALUES (1, 'SingleEmpMultiMgr', 100, 10);
INSERT INTO emp (id, name, dept_id, role_id) VALUES (2, 'SameNameEmp', 200, 20);
INSERT INTO emp (id, name, dept_id, role_id) VALUES (3, 'SameNameEmp', 200, 20);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (10, 100, 1);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (10, 100, 2);
INSERT INTO dept_mgr (mgr_id, dept_id, role_id) VALUES (20, 200, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM emp WHERE (role_id, dept_id) IN (SELECT mgr_id, dept_id FROM dept_mgr);

/*
Gold Result:
('SingleEmpMultiMgr',)
('SameNameEmp',)
('SameNameEmp',)
*/

-- Prediction Query
SELECT e.name FROM emp AS e INNER JOIN dept_mgr AS d ON e.role_id = d.mgr_id AND e.dept_id = d.dept_id;

/*
Prediction Result:
('SingleEmpMultiMgr',)
('SingleEmpMultiMgr',)
('SameNameEmp',)
('SameNameEmp',)
*/