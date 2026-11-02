-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, NULL, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT *, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS CT FROM EMPLOYEE) SELECT DISTINCT EMPLOYEE_ID, IIF(CT = 1, DEPARTMENT_ID, IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, NULL)) AS DEPARTMENT_ID FROM CTE WHERE (CT = 1) OR (CT > 1 AND PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(1, None)
(1, 1)
*/