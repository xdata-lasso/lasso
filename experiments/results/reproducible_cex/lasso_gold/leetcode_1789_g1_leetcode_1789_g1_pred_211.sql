-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1014, 1015, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1014, 1016, 'site');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, NULL, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, NULL, 'face');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1014, 1015)
(1017, None)
*/

-- Prediction Query
SELECT Y.EMPLOYEE_ID AS EMPLOYEE_ID, Y.DEPARTMENT_ID AS DEPARTMENT_ID FROM (SELECT X.EMPLOYEE_ID AS EMPLOYEE_ID, (CASE WHEN X.NUM_DEP = 1 THEN X.DI WHEN X.NUM_DEP > 1 AND X.PRIMARY_FLAG = 'Y' THEN X.DI ELSE 0 END) AS DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID AS DI, PRIMARY_FLAG, COUNT(EMPLOYEE_ID) OVER (PARTITION BY EMPLOYEE_ID) AS NUM_DEP FROM EMPLOYEE) AS X) AS Y WHERE Y.DEPARTMENT_ID <> 0;

/*
Prediction Result:
(1014, 1015)
*/