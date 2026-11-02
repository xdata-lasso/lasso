-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'Y');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483647, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483646, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (3, -2147483645, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 1)
(3, -2147483645)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E1 WHERE PRIMARY_FLAG = 'Y' UNION ALL SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E WHERE PRIMARY_FLAG = 'N' AND NOT EXISTS(SELECT 1 FROM EMPLOYEE AS E2 WHERE E.EMPLOYEE_ID = E2.EMPLOYEE_ID AND E2.PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(1, 1)
*/