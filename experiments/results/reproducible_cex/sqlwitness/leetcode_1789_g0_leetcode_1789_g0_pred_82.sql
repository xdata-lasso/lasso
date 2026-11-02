-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (2, 1, 'Y'), (0, 0, 'Y'), (1, 1, 'N'), (0, 2, 'Y'), (-1, 2, 'N'), (0, -1, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1, 2)
(0, 0)
(0, 1)
(0, 2)
(1, 1)
(2, 1)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN DEPARTMENT_ID ELSE SUM(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0)) END AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(-1, 2)
(0, 3)
(1, 1)
(2, 1)
*/