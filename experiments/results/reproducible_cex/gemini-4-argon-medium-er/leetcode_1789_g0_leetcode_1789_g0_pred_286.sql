-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 2, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, MAX(PRIMARY_FLAG) AS PRIMARY_FLAG FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT EMP.EMPLOYEE_ID, EMP.DEPARTMENT_ID FROM CTE JOIN EMPLOYEE AS EMP ON CTE.PRIMARY_FLAG = EMP.PRIMARY_FLAG AND CTE.EMPLOYEE_ID = EMP.EMPLOYEE_ID;

/*
Prediction Result:
(1, 1)
(1, 2)
*/