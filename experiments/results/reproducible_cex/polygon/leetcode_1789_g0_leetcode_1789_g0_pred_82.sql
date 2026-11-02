-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (9, 8, NULL);
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (9, 7, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
SELECT EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN DEPARTMENT_ID ELSE SUM(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0)) END AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(9, 0)
*/