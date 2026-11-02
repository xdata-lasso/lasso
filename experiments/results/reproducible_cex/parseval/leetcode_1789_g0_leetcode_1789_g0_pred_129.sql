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
SELECT T1.EMPLOYEE_ID, CASE WHEN T1.DEPARTMENT_ID IS NULL THEN T2.DEPARTMENT_ID ELSE T1.DEPARTMENT_ID END AS DEPARTMENT_ID FROM (SELECT E.EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN E.DEPARTMENT_ID ELSE NULL END AS DEPARTMENT_ID FROM EMPLOYEE AS E GROUP BY EMPLOYEE_ID) AS T1 LEFT JOIN (SELECT E.EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E WHERE E.PRIMARY_FLAG = 'Y') AS T2 ON T1.EMPLOYEE_ID = T2.EMPLOYEE_ID;

/*
Prediction Result:
(1, 1)
(2, None)
(3, -2147483645)
*/