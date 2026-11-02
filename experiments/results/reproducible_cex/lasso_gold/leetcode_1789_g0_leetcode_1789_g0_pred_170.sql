-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, 1018, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, 1019, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1017, 1018)
(1017, 1019)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG) AS RNK FROM EMPLOYEE) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM CTE WHERE RNK = 1;

/*
Prediction Result:
(1017, 1018)
*/