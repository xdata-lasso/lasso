-- Schema DDL
CREATE TABLE "EMPLOYEES" ("EMP_ID" INTEGER PRIMARY KEY, "DEPT_ID" INTEGER, "IS_FULL_TIME" INTEGER);

CREATE TABLE "PROJECTS" ("PROJ_ID" INTEGER PRIMARY KEY, "DEPT_ID" INTEGER, "STATUS" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO projects (proj_id, dept_id, status) VALUES (2, 1, 'default2'), (1, 1, 'default2'), (0, -1, 'ACTIVE'), (-1, 1, 'ACTIVE'), (3, 1, NULL), (4, 2, 'default2'), (5, 2, 'default1'), (6, 1, 'default2'), (7, NULL, 'default2'), (8, 1, NULL), (9, 2, 'default1'), (10, 0, 'default1'), (11, -1, 'default1'), (12, NULL, 'default1'), (13, 0, 'ACTIVE'), (14, NULL, NULL), (15, NULL, 'default2'), (16, -1, 'default1'), (17, 1, 'ACTIVE'), (18, 1, NULL), (19, NULL, 'default1'), (20, 2, 'ACTIVE'), (21, NULL, 'default2'), (22, 2, 'default2'), (23, 0, 'ACTIVE'), (24, NULL, 'default1');
INSERT INTO employees (emp_id, dept_id, is_full_time) VALUES (2, -1, 0), (0, 1, NULL), (1, NULL, 1), (-1, 1, -1), (3, NULL, 1), (4, 0, 2), (5, NULL, 1), (6, -1, 0), (7, -1, 0), (8, -1, 0), (9, -1, 2), (10, 1, 2), (11, 2, 0), (12, 0, 2), (13, 1, 1), (14, -1, NULL), (15, -1, -1), (16, NULL, NULL), (17, 0, 1), (18, 2, NULL), (19, 0, 1), (20, 1, 0), (21, -1, 2), (22, 2, 1), (23, 2, 0), (24, -1, -1), (25, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN IS_FULL_TIME = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(EMP_ID) FROM EMPLOYEES WHERE DEPT_ID IN (SELECT DEPT_ID FROM PROJECTS WHERE STATUS = 'ACTIVE');

/*
Gold Result:
(17.391304347826086,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN IS_FULL_TIME = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(EMPLOYEES.EMP_ID) FROM EMPLOYEES INNER JOIN PROJECTS ON EMPLOYEES.DEPT_ID = PROJECTS.DEPT_ID WHERE PROJECTS.STATUS = 'ACTIVE';

/*
Prediction Result:
(21.875,)
*/