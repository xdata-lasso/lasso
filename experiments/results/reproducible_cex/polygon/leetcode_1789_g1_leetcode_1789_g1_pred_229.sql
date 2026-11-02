-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, 9, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, 13, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(12, 13)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT TBL1.EMPLOYEE_ID, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS DEPT_COUNT, DEPARTMENT_ID, PRIMARY_FLAG FROM EMPLOYEE AS TBL1) AS TBL2 WHERE PRIMARY_FLAG = 'Y' OR DEPT_COUNT = 1;

/*
Prediction Result:
(12, 13)
*/