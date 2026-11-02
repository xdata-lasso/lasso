-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (1, 2, 'N'), (2, 1, 'N'), (0, 0, 'Y'), (1, 1, 'N'), (0, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(0, 0)
(2, 1)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG) AS NUMCNT FROM EMPLOYEE) AS T1 WHERE NUMCNT = 1;

/*
Prediction Result:
(0, 1)
(1, 0)
(2, 1)
*/