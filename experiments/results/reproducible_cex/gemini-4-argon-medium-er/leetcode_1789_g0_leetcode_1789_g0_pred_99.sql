-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 10)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E WHERE PRIMARY_FLAG = 'Y' OR (PRIMARY_FLAG = 'N' AND EMPLOYEE_ID IN (SELECT DISTINCT EMPLOYEE_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(DEPARTMENT_ID) = 1));

/*
Prediction Result:
*/