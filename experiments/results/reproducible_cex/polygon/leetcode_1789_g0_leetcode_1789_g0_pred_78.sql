-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (11, 725, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (11, 726, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
SELECT EMPLOYEE_ID, MAX(DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1 HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, MAX(CASE WHEN PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID END) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1 HAVING COUNT(*) > 1;

/*
Prediction Result:
(11, None)
*/