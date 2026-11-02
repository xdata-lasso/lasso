-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (2, 1, 'Y'), (0, 0, 'N'), (1, 1, 'N'), (0, 2, 'N'), (2, 2, 'Y'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 0)
(2, 1)
(2, 2)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' OR (PRIMARY_FLAG = 'N' AND NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y'));

/*
Prediction Result:
(2, 1)
(0, 0)
(0, 2)
(2, 2)
(1, 0)
*/