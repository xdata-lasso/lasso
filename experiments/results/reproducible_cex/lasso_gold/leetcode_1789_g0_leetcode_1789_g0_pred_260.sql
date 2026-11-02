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
SELECT E1.EMPLOYEE_ID, COALESCE(TEMP.DEPARTMENT_ID, E1.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E1 LEFT JOIN (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') AS TEMP ON E1.EMPLOYEE_ID = TEMP.EMPLOYEE_ID GROUP BY 1;

/*
Prediction Result:
(1017, 1018)
*/