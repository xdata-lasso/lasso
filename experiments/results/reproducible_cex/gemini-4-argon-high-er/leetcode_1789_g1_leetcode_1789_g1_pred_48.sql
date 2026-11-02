-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH DEPS AS (SELECT EMPLOYEE_ID, COUNT(DISTINCT DEPARTMENT_ID) AS DEPS_NUM FROM EMPLOYEE AS E GROUP BY EMPLOYEE_ID) SELECT E.EMPLOYEE_ID, SUM(IIF(DEPS_NUM = 1, DEPARTMENT_ID, IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0))) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN DEPS AS D ON E.EMPLOYEE_ID = D.EMPLOYEE_ID GROUP BY E.EMPLOYEE_ID;

/*
Prediction Result:
(1, 0)
*/