-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483647, '1');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483646, '1');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, 1, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483645, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (3, 4, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (3, 5, 'emp_d90689');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(DEPARTMENT_ID) = 1;

/*
Prediction Result:
(1, 1)
(2, -2147483647)
(2, -2147483646)
*/