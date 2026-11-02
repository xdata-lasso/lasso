-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (1, 2, 'Y'), (2, 1, 'N'), (0, 0, 'N'), (1, 1, 'Y'), (2, 0, 'N'), (0, 2, 'Y'), (-1000, -1000, 'N'), (2, 2, 'N'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(0, 1)
(1, 2)
(1, 1)
(0, 2)
(-1000, -1000)
(1, 0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, IIF(COUNT(DEPARTMENT_ID) = 1 AND PRIMARY_FLAG = 'N', DEPARTMENT_ID, MAX(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, -1))) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(-1000, -1000)
(0, 2)
(1, 2)
(2, -1)
*/