-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, -410, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, -409, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT EMPLOYEE_ID, MAX(DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1 HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, MAX(CASE WHEN PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID END) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1 HAVING COUNT(*) > 1;

/*
Prediction Result:
(12, None)
*/