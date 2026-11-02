-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (13, 14, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (13, 11, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(13, 11)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, MAX(PRIMARY_FLAG) AS PRIMARY_FLAG FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT EMP.EMPLOYEE_ID, EMP.DEPARTMENT_ID FROM CTE JOIN EMPLOYEE AS EMP ON CTE.PRIMARY_FLAG = EMP.PRIMARY_FLAG AND CTE.EMPLOYEE_ID = EMP.EMPLOYEE_ID;

/*
Prediction Result:
(13, 11)
*/