-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1023, 1024, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1023, 1025, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1023, 1024)
(1023, 1025)
*/

-- Prediction Query
SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, FIRST_VALUE(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG) AS DEPARTMENT_ID FROM EMPLOYEE) AS U;

/*
Prediction Result:
(1023, 1024)
*/