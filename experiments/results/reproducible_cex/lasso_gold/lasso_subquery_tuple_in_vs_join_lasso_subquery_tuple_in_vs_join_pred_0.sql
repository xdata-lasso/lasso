-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, role_id INTEGER);

CREATE TABLE dept_mgr (mgr_id INTEGER, dept_id INTEGER, role_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1026, 1027, 1028);
INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1030, 1031, 1032);
INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1026, 1027, 1028);
INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (1029, 'Connie Lawrence', 1027, 1026);
INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (1033, 'Abigail Shaffer', 1031, 1030);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM emp WHERE (role_id, dept_id) IN (SELECT mgr_id, dept_id FROM dept_mgr);

/*
Gold Result:
('Connie Lawrence',)
('Abigail Shaffer',)
*/

-- Prediction Query
SELECT e.name FROM emp AS e INNER JOIN dept_mgr AS d ON e.role_id = d.mgr_id AND e.dept_id = d.dept_id;

/*
Prediction Result:
('Connie Lawrence',)
('Connie Lawrence',)
('Abigail Shaffer',)
*/