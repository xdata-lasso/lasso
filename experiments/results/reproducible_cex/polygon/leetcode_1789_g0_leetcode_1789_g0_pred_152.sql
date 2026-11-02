-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (19, 20, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (19, 21, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
WITH NEW AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT DISTINCT E.EMPLOYEE_ID, COALESCE(N.DEPARTMENT_ID, E.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN NEW AS N ON E.EMPLOYEE_ID = N.EMPLOYEE_ID;

/*
Prediction Result:
(19, 20)
(19, 21)
*/