-- Schema DDL
CREATE TABLE emp (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, role_id INTEGER);

CREATE TABLE dept_mgr (mgr_id INTEGER, dept_id INTEGER, role_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: emp --
INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (-2147483648, 'e_s_ecd061', 1, 1);

INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (2, 'e_s_ecd061', 1, 1);

INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (3, 'e_s_ecd061', 1, 1);

INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (-2147483645, 'e_s_ecd061', 1, 2);

INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (-2147483644, 'e_s_ecd061', 2, 1);

INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (-2147483643, 'e_s_ecd061', 1, 2);

INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (-2147483642, 'e_s_ecd061', 2, 1);

INSERT INTO "emp" ("id", "name", "dept_id", "role_id") VALUES (-2147483641, NULL, 1, 1);

-- Inserting into table: dept_mgr --
INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, -55602865);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, -59984348);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, -664303813);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (4, 1, -1022641847);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 3, -1726781632);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (4, 1, 247012447);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 3, -1980249628);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, -734455130);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, 1744686505);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, -1633151678);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, -252690330);

INSERT INTO "dept_mgr" ("mgr_id", "dept_id", "role_id") VALUES (1, 1, 1115440883);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM emp WHERE (role_id, dept_id) IN (SELECT mgr_id, dept_id FROM dept_mgr);

/*
Gold Result:
('e_s_ecd061',)
(None,)
('e_s_ecd061',)
('e_s_ecd061',)
*/

-- Prediction Query
SELECT e.name FROM emp AS e INNER JOIN dept_mgr AS d ON e.role_id = d.mgr_id AND e.dept_id = d.dept_id;

/*
Prediction Result:
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
('e_s_ecd061',)
*/