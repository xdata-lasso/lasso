-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1011, NULL, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1011, NULL, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1011, None)
*/

-- Prediction Query
WITH T1 AS (SELECT EMPLOYEE_ID, COUNT(*) AS C FROM EMPLOYEE GROUP BY EMPLOYEE_ID), T2 AS (SELECT E.*, C FROM EMPLOYEE AS E LEFT JOIN T1 USING (EMPLOYEE_ID)) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM T2 WHERE C = 1 OR PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(1011, None)
(1011, None)
*/