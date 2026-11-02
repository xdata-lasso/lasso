-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (1, 0, 'Y'), (1, 1, 'N'), (2, 2, 'N'), (0, 0, 'Y'), (0, 2, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 0)
(2, 2)
(0, 0)
(0, 2)
*/

-- Prediction Query
WITH TEMP AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG ASC) AS RK FROM EMPLOYEE) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TEMP WHERE RK = 1;

/*
Prediction Result:
(0, 1)
(1, 1)
(2, 2)
*/