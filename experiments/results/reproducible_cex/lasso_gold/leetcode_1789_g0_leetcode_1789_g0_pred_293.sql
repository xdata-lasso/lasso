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
SELECT EMPLOYEE.EMPLOYEE_ID, EMPLOYEE.DEPARTMENT_ID FROM EMPLOYEE JOIN (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS COUNT_DEP FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS A ON EMPLOYEE.EMPLOYEE_ID = A.EMPLOYEE_ID WHERE A.COUNT_DEP = 1 OR (A.COUNT_DEP > 1 AND EMPLOYEE.PRIMARY_FLAG = 'Y');

/*
Prediction Result:
*/