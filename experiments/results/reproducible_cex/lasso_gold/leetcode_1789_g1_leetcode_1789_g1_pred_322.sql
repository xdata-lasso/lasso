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
SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID), CASE WHEN COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) > 1 AND PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID WHEN COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) = 1 THEN DEPARTMENT_ID END AS CATEGORY FROM EMPLOYEE) AS TEMP WHERE NOT CATEGORY IS NULL;

/*
Prediction Result:
(1014, 1015)
*/