-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, NULL, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
WITH LOOKUP AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, COUNT(DEPARTMENT_ID) AS FLAG FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT EMPLOYEE.EMPLOYEE_ID, EMPLOYEE.DEPARTMENT_ID FROM EMPLOYEE LEFT JOIN LOOKUP ON EMPLOYEE.EMPLOYEE_ID = LOOKUP.EMPLOYEE_ID WHERE PRIMARY_FLAG = 'Y' OR FLAG = 1;

/*
Prediction Result:
(1, None)
(1, 10)
*/