-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, NULL, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
(1, None)
*/

-- Prediction Query
WITH CTE AS (SELECT E.EMPLOYEE_ID, COUNT(*) AS EMPLOYCOUNT FROM EMPLOYEE AS E GROUP BY 1) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN CTE ON E.EMPLOYEE_ID = CTE.EMPLOYEE_ID WHERE CTE.EMPLOYCOUNT = 1 OR (CTE.EMPLOYCOUNT > 1 AND E.PRIMARY_FLAG = 'Y');

/*
Prediction Result:
*/