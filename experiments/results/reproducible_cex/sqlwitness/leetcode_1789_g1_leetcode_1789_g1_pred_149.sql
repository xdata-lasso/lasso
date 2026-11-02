-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (-1, 0, 'N'), (2, 2, 'N'), (1, 0, 'Y'), (-1, 2, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, 2)
(1, 0)
*/

-- Prediction Query
WITH CTE_FINAL AS (SELECT EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN MAX(DEPARTMENT_ID) ELSE SUM(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0)) END AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1) SELECT * FROM CTE_FINAL;

/*
Prediction Result:
(-1, 0)
(1, 0)
(2, 2)
*/