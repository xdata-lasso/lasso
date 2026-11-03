-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1011, 1012, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (NULL, 1014, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1011, 1012)
(None, 1014)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS CNT FROM EMPLOYEE GROUP BY 1) SELECT E.EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E JOIN CTE AS C ON E.EMPLOYEE_ID = C.EMPLOYEE_ID WHERE E.PRIMARY_FLAG = 'Y' OR C.CNT = 1;

/*
Prediction Result:
(1011, 1012)
*/