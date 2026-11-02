-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 2, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 3, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 4, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483644, 'emp_d90689');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, -2147483644)
*/

-- Prediction Query
SELECT T1.EMPLOYEE_ID, CASE WHEN T1.DEPARTMENT_ID IS NULL THEN T2.DEPARTMENT_ID ELSE T1.DEPARTMENT_ID END AS DEPARTMENT_ID FROM (SELECT E.EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN E.DEPARTMENT_ID ELSE NULL END AS DEPARTMENT_ID FROM EMPLOYEE AS E GROUP BY EMPLOYEE_ID) AS T1 LEFT JOIN (SELECT E.EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E WHERE E.PRIMARY_FLAG = 'Y') AS T2 ON T1.EMPLOYEE_ID = T2.EMPLOYEE_ID;

/*
Prediction Result:
(1, None)
(2, -2147483644)
*/