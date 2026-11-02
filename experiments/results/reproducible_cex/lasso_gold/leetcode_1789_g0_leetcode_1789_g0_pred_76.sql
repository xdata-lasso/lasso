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
SELECT E1.EMPLOYEE_ID, E1.DEPARTMENT_ID FROM EMPLOYEE AS E1 LEFT JOIN (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(EMPLOYEE_ID) AS CNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS E2 ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID WHERE E1.PRIMARY_FLAG = 'Y' OR E2.CNT = 1;

/*
Prediction Result:
(1011, None)
(1011, None)
*/