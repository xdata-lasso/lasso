-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1014, 1015, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1014, 1016, 'site');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, NULL, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, NULL, 'face');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1014, 1015)
(1017, None)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, COUNT(DISTINCT DEPARTMENT_ID) AS COUNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID, PRIMARY_FLAG, COUNT FROM EMPLOYEE AS E JOIN CTE AS C ON E.EMPLOYEE_ID = C.EMPLOYEE_ID) AS SUB WHERE (COUNT > 1 AND PRIMARY_FLAG = 'Y') OR (COUNT = 1);

/*
Prediction Result:
(1014, 1015)
*/