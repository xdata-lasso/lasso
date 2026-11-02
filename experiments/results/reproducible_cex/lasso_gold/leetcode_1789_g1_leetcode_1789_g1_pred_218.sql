-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1038, 1039, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1040, 1041, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1038, 1039)
(1040, 1041)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT *, COUNT(PRIMARY_FLAG) OVER (PARTITION BY EMPLOYEE_ID) AS CNT FROM EMPLOYEE) AS T WHERE PRIMARY_FLAG = 'Y' OR CNT = 1;

/*
Prediction Result:
(1038, 1039)
*/