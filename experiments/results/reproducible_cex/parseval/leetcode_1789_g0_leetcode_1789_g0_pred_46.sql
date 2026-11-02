-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'Y');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483647, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483646, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (3, -2147483645, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 1)
(3, -2147483645)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, (CASE WHEN COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) = 1 THEN DEPARTMENT_ID WHEN COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) > 1 AND PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE 0 END) AS DEPARTMENT_ID FROM EMPLOYEE) SELECT EMPLOYEE_ID, MAX(DEPARTMENT_ID) AS DEPARTMENT_ID FROM CTE GROUP BY 1;

/*
Prediction Result:
(1, 1)
(2, 0)
(3, -2147483645)
*/