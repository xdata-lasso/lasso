-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (1, 2, 'N'), (2, 1, 'N'), (0, 0, 'Y'), (1, 1, 'Y'), (2, 0, 'Y'), (0, 2, 'Y'), (-1000, -1000, 'Y'), (2, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(0, 1)
(0, 0)
(1, 1)
(2, 0)
(0, 2)
(-1000, -1000)
*/

-- Prediction Query
WITH A AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(DEPARTMENT_ID) = 1), B AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(DEPARTMENT_ID) FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' GROUP BY EMPLOYEE_ID) SELECT A.EMPLOYEE_ID, A.DEPARTMENT_ID FROM A UNION SELECT B.EMPLOYEE_ID, B.DEPARTMENT_ID FROM B;

/*
Prediction Result:
(-1000, -1000)
(0, 0)
(1, 1)
(2, 0)
*/