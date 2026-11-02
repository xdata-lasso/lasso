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
WITH CTE AS (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS CNT FROM EMPLOYEE GROUP BY 1) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E JOIN CTE ON E.EMPLOYEE_ID = CTE.EMPLOYEE_ID WHERE CNT = 1 UNION SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM (SELECT * FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') AS E JOIN CTE ON E.EMPLOYEE_ID = CTE.EMPLOYEE_ID WHERE CNT > 1;

/*
Prediction Result:
*/