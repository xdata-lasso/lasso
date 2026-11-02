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
SELECT EMPLOYEE.EMPLOYEE_ID, EMPLOYEE.DEPARTMENT_ID FROM EMPLOYEE JOIN (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS COUNT_DEP FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS A ON EMPLOYEE.EMPLOYEE_ID = A.EMPLOYEE_ID WHERE A.COUNT_DEP = 1 OR (A.COUNT_DEP > 1 AND EMPLOYEE.PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(1014, 1015)
*/