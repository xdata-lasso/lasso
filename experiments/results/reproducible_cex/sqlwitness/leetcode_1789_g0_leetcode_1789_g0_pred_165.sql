-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (1, 2, 'Y'), (0, 0, 'Y'), (1, 1, 'Y'), (2, 0, 'N'), (2, 2, 'N'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(0, 0)
(0, 1)
(1, 0)
(1, 1)
(1, 2)
*/

-- Prediction Query
WITH Y AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y'), N AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM Y)) SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID FROM Y UNION SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID FROM N;

/*
Prediction Result:
(0, 0)
(0, 1)
(1, 0)
(1, 1)
(1, 2)
(2, 0)
(2, 2)
*/