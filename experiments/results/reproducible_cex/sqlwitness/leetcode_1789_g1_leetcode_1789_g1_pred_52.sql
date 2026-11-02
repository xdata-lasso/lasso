-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (1, 0, 'Y'), (1, 1, 'Y'), (0, 2, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 0)
(1, 1)
(0, 2)
*/

-- Prediction Query
WITH PRIMARIES AS (SELECT * FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT EMPLOYEE.EMPLOYEE_ID, CASE WHEN PRIMARIES.DEPARTMENT_ID IS NULL THEN EMPLOYEE.DEPARTMENT_ID ELSE PRIMARIES.DEPARTMENT_ID END AS DEPARTMENT_ID FROM EMPLOYEE LEFT JOIN PRIMARIES ON EMPLOYEE.EMPLOYEE_ID = PRIMARIES.EMPLOYEE_ID GROUP BY EMPLOYEE.EMPLOYEE_ID ORDER BY EMPLOYEE.EMPLOYEE_ID ASC, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(0, 2)
(1, 0)
*/