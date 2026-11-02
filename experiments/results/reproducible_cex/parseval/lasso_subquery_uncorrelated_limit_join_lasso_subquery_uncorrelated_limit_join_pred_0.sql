-- Schema DDL
CREATE TABLE EMPLOYEES (EMP_ID INTEGER PRIMARY KEY, DEPT_ID INTEGER, SALARY INTEGER);

CREATE TABLE DEPARTMENTS (DEPT_ID INTEGER PRIMARY KEY, DEPT_NAME TEXT, BUDGET INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1, 1610062532, -106629402);

INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (2, -1, -55602865);

INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (3, -1, -59984348);

-- Inserting into table: departments --
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (-1, '5k5swwqcgs', 1);

INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (0, '9n8', 0);

INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1, 'u7', -734455130);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMP_ID FROM EMPLOYEES WHERE DEPT_ID = (SELECT DEPT_ID FROM DEPARTMENTS ORDER BY BUDGET DESC, DEPARTMENTS.dept_id NULLS LAST LIMIT 1);

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT T1.EMP_ID FROM EMPLOYEES AS T1 INNER JOIN DEPARTMENTS AS T2 ON T1.DEPT_ID = T2.DEPT_ID ORDER BY T2.BUDGET DESC, T1.emp_id NULLS LAST, T2.dept_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/