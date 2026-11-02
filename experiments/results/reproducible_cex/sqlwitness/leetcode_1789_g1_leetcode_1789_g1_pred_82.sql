-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (2, -1, 'Y'), (-1, -1, 'N'), (0, 0, 'Y'), (2, 0, 'Y'), (-1, 2, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, -1)
(0, 0)
(2, 0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN DEPARTMENT_ID ELSE SUM(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0)) END AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(-1, 0)
(0, 0)
(2, -1)
*/