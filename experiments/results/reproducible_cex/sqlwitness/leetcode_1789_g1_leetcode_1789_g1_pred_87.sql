-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (2, 2, 'N'), (0, 0, 'Y'), (1, 2, 'Y'), (2, 0, 'Y'), (1, 1, 'Y'), (0, 1, 'N'), (2, 1, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(0, 0)
(1, 2)
(2, 0)
(1, 1)
(2, 1)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, SUM(1) OVER (PARTITION BY EMPLOYEE_ID) AS DEPT_CNT FROM EMPLOYEE) AS X WHERE PRIMARY_FLAG = 'Y' OR DEPT_CNT = 1 ORDER BY 1, EMPLOYEE_ID NULLS LAST, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(0, 0)
(1, 1)
(1, 2)
(2, 0)
(2, 1)
*/