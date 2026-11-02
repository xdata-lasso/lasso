-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (9, 10, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (11, 12, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(9, 10)
(11, 12)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS C1 FROM EMPLOYEE) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM CTE WHERE PRIMARY_FLAG = 'Y' OR C1 = 1;

/*
Prediction Result:
(9, 10)
(11, 12)
*/