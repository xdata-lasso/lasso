-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 20, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, MAX(PRIMARY_FLAG) OVER (PARTITION BY EMPLOYEE_ID) AS LAST_FLAG, PRIMARY_FLAG FROM EMPLOYEE ORDER BY 1, EMPLOYEE.employee_id NULLS LAST, EMPLOYEE.department_id NULLS LAST) AS TEMP WHERE (PRIMARY_FLAG = 'Y') OR (LAST_FLAG = 'N') ORDER BY 1, EMPLOYEE_ID NULLS LAST, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(1, 10)
(1, 20)
*/