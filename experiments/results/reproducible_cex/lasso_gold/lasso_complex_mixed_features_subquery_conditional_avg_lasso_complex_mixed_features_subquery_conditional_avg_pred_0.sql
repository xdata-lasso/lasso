-- Schema DDL
CREATE TABLE "EMPLOYEES" ("EMP_ID" INTEGER PRIMARY KEY, "DEPT_ID" INTEGER, "IS_FULL_TIME" INTEGER);

CREATE TABLE "PROJECTS" ("PROJ_ID" INTEGER PRIMARY KEY, "DEPT_ID" INTEGER, "STATUS" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("emp_id", "dept_id", "is_full_time") VALUES (1118, 1119, 1);
INSERT INTO "employees" ("emp_id", "dept_id", "is_full_time") VALUES (1121, 1122, 2);
INSERT INTO "projects" ("proj_id", "dept_id", "status") VALUES (1120, 1119, 'ACTIVE');
INSERT INTO "projects" ("proj_id", "dept_id", "status") VALUES (1123, 1122, 'ACTIVE');
INSERT INTO "projects" ("proj_id", "dept_id", "status") VALUES (1124, 1119, 'ACTIVE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN IS_FULL_TIME = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(EMP_ID) FROM EMPLOYEES WHERE DEPT_ID IN (SELECT DEPT_ID FROM PROJECTS WHERE STATUS = 'ACTIVE');

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN IS_FULL_TIME = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(EMPLOYEES.EMP_ID) FROM EMPLOYEES INNER JOIN PROJECTS ON EMPLOYEES.DEPT_ID = PROJECTS.DEPT_ID WHERE PROJECTS.STATUS = 'ACTIVE';

/*
Prediction Result:
(66.66666666666667,)
*/