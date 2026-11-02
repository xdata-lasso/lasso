-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 0, 'N'), (1, -1, 'N'), (-1, 0, 'N'), (2, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(0, 0)
(-1, 0)
(2, 2)
*/

-- Prediction Query
WITH TEMP AS (SELECT *, COUNT(*) OVER (PARTITION BY EMPLOYEE_ID ORDER BY EMPLOYEE_ID) AS CNT FROM EMPLOYEE) SELECT EMPLOYEE_ID, SUM(CASE WHEN CNT = 1 OR PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE 0 END) AS DEPARTMENT_ID FROM TEMP GROUP BY EMPLOYEE_ID;

/*
Prediction Result:
(-1, 0)
(0, 0)
(1, 0)
(2, 2)
*/