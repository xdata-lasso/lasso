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
WITH CTE AS (SELECT E.EMPLOYEE_ID, COUNT(*) AS EMPLOYCOUNT FROM EMPLOYEE AS E GROUP BY 1) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN CTE ON E.EMPLOYEE_ID = CTE.EMPLOYEE_ID WHERE CTE.EMPLOYCOUNT = 1 OR (CTE.EMPLOYCOUNT > 1 AND E.PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(1011, None)
(1011, None)
*/