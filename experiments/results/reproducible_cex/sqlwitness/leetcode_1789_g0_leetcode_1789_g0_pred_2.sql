-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (1, 2, 'N'), (2, 1, 'N'), (0, 0, 'N'), (-1000, -999, 'N'), (1, 1, 'Y'), (2, 0, 'N'), (0, 2, 'N'), (-1000, -1000, 'Y'), (2, 2, 'N'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1000, -1000)
(1, 0)
(1, 1)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E1 WHERE PRIMARY_FLAG = 'Y' UNION ALL SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E WHERE PRIMARY_FLAG = 'N' AND NOT EXISTS(SELECT 1 FROM EMPLOYEE AS E2 WHERE E.EMPLOYEE_ID = E2.EMPLOYEE_ID AND E2.PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(1, 1)
(-1000, -1000)
(1, 0)
(0, 1)
(2, 1)
(0, 0)
(2, 0)
(0, 2)
(2, 2)
*/