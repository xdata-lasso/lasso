-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (2, 1, 'Y'), (1, 1, 'Y'), (2, 0, 'N'), (0, 2, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 1)
(2, 1)
*/

-- Prediction Query
WITH EMP AS (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS DEPT_COUNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E JOIN EMP AS E1 ON E.EMPLOYEE_ID = E1.EMPLOYEE_ID WHERE (DEPT_COUNT = 1) OR (DEPT_COUNT > 1 AND PRIMARY_FLAG = 1);

/*
Prediction Result:
(1, 1)
*/