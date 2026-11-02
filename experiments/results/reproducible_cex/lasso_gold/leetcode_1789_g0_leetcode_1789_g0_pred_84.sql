-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1005, 1006, 'Y_z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1005, 1006)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS CT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS R1 NATURAL JOIN EMPLOYEE WHERE PRIMARY_FLAG = 'Y' OR (CT = 1 AND PRIMARY_FLAG = 'N');

/*
Prediction Result:
*/