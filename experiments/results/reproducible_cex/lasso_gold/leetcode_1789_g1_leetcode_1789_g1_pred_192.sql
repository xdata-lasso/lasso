-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1026, 1027, 'Y_z');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1026, 1028, 'Y_z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT DISTINCT (E.EMPLOYEE_ID), CASE WHEN E.EMPLOYEE_ID IN (CTE.EMPLOYEE_ID) THEN CTE.DEPARTMENT_ID ELSE E.DEPARTMENT_ID END AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN CTE AS CTE ON CTE.EMPLOYEE_ID = E.EMPLOYEE_ID ORDER BY E.EMPLOYEE_ID, (E.EMPLOYEE_ID) NULLS LAST, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(1026, 1027)
(1026, 1028)
*/