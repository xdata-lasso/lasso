-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (2, 1, 'N'), (0, 0, 'N'), (1, 2, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, 1)
(0, 0)
(1, 2)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID FROM EMPLOYEE GROUP BY 1 HAVING COUNT(*) > 1) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM CTE) AND PRIMARY_FLAG = 'Y' UNION ALL SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM CTE) ORDER BY 1, EMPLOYEE_ID NULLS LAST, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(0, 0)
(1, 2)
(2, 1)
*/