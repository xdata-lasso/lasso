-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, 11, NULL);
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, 10, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT EMPLOYEE_ID, CASE WHEN CNTS = 1 THEN DEPARTMENT_ID WHEN CNTS > 1 AND PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID END AS DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS CNTS FROM EMPLOYEE) AS A) AS B WHERE NOT DEPARTMENT_ID IS NULL;

/*
Prediction Result:
*/