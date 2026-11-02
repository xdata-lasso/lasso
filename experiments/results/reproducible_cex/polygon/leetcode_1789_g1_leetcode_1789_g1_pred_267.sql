-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (6, -413, NULL);
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (6, -160, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT EMPLOYEE_ID, COALESCE(MAX(CASE WHEN PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE NULL END), MAX(DEPARTMENT_ID)) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1;

/*
Prediction Result:
(6, -160)
*/