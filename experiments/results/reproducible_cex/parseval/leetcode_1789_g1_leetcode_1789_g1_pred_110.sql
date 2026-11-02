-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483647, 'Y');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483646, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483645, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483644, 'Y');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (3, -2147483643, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (3, -2147483642, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (4, -2147483641, NULL);

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (5, -2147483640, 'Y');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (5, -2147483639, 'emp_d90689');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 1)
(2, -2147483647)
(2, -2147483644)
(4, -2147483641)
(5, -2147483640)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' GROUP BY EMPLOYEE_ID UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(EMPLOYEE_ID) = 1;

/*
Prediction Result:
(1, 1)
(2, -2147483647)
(4, -2147483641)
(5, -2147483640)
*/