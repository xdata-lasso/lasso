-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
*/

-- Prediction Query
WITH EMP AS (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS DEPT_COUNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E JOIN EMP AS E1 ON E.EMPLOYEE_ID = E1.EMPLOYEE_ID WHERE (DEPT_COUNT = 1) OR (DEPT_COUNT > 1 AND PRIMARY_FLAG = 1);

/*
Prediction Result:
*/