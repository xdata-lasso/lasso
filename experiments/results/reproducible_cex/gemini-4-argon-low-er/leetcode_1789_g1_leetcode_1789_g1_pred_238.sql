-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, NULL, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, None)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS CNT FROM EMPLOYEE GROUP BY 1) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E JOIN CTE ON E.EMPLOYEE_ID = CTE.EMPLOYEE_ID WHERE CNT = 1 UNION SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM (SELECT * FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') AS E JOIN CTE ON E.EMPLOYEE_ID = CTE.EMPLOYEE_ID WHERE CNT > 1;

/*
Prediction Result:
*/