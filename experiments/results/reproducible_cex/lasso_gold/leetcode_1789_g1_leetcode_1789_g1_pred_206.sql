-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1025, NULL, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1025, NULL, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1025, None)
(1025, None)
*/

-- Prediction Query
WITH A AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y'), B AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, COUNT(DEPARTMENT_ID) AS C FROM EMPLOYEE GROUP BY 1) SELECT * FROM A UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM B WHERE C = 1;

/*
Prediction Result:
(1025, None)
*/