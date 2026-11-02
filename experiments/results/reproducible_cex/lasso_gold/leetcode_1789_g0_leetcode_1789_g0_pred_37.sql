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
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(DEPARTMENT_ID) = 1);

/*
Prediction Result:
(1023, 1024)
(1025, 1026)
(1027, 1028)
(1033, None)
*/