-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (1, 2, 'Y'), (2, 1, 'N'), (1, 1, 'N'), (2, 0, 'Y'), (0, 2, 'Y'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(0, 2)
(1, 0)
(1, 2)
(2, 0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' GROUP BY 1 UNION SELECT A.EMPLOYEE_ID, A.DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, COUNT(DEPARTMENT_ID) FROM EMPLOYEE GROUP BY 1 HAVING COUNT(DEPARTMENT_ID) = 1) AS A;

/*
Prediction Result:
(0, 2)
(1, 0)
(2, 0)
*/