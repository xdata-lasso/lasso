-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1023, 1024, 'dog');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1025, 1026, 'chair');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1027, 1028, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1029, NULL, 'since');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1031, NULL, 'blue');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1033, NULL, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1023, 1024)
(1025, 1026)
(1027, 1028)
(1029, None)
(1031, None)
(1033, None)
*/

-- Prediction Query
WITH A AS (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS CNT FROM EMPLOYEE GROUP BY 1 HAVING CNT = 1) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E JOIN A ON E.EMPLOYEE_ID = A.EMPLOYEE_ID UNION SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E WHERE E.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(1023, 1024)
(1025, 1026)
(1027, 1028)
(1033, None)
*/