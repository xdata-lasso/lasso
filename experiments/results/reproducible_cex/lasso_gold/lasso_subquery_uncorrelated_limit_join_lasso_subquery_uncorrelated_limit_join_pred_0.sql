-- Schema DDL
CREATE TABLE EMPLOYEES (EMP_ID INTEGER PRIMARY KEY, DEPT_ID INTEGER, SALARY INTEGER);

CREATE TABLE DEPARTMENTS (DEPT_ID INTEGER PRIMARY KEY, DEPT_NAME TEXT, BUDGET INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1116, 'Zachary Hicks', 1150.0);
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1118, 'Anthony Rodriguez', 1127.0);
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1119, 'Rebecca Henderson', 1134.0);
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1132, 'James Ferrell', 1141.0);
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1117, 'Tricia Valencia', 1157.0);
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1133, 'Nathan Maldonado', 1143.0);
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1134, 'Debra Davidson', 1120);
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1135, 'Jeffrey Chavez', 1120);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1124, 1116, 1128);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1125, 1117, 1135.0);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1126, 1118, 1142.0);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1127, 1119, 1149.0);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1140, 1117, 1144);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1141, 1133, 1151.0);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1142, 1134, 1158.0);
INSERT INTO "employees" ("emp_id", "dept_id", "salary") VALUES (1143, 1135, 1165.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMP_ID FROM EMPLOYEES WHERE DEPT_ID = (SELECT DEPT_ID FROM DEPARTMENTS ORDER BY BUDGET DESC, DEPARTMENTS.dept_id NULLS LAST LIMIT 1);

/*
Gold Result:
(1125,)
(1140,)
*/

-- Prediction Query
SELECT T1.EMP_ID FROM EMPLOYEES AS T1 INNER JOIN DEPARTMENTS AS T2 ON T1.DEPT_ID = T2.DEPT_ID ORDER BY T2.BUDGET DESC, T1.emp_id NULLS LAST, T2.dept_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1125,)
*/