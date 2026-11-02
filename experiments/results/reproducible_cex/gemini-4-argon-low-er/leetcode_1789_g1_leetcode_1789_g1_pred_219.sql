-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, -1, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, -1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT *, COUNT(*) OVER (PARTITION BY EMPLOYEE_ID) AS CNT FROM EMPLOYEE), CTE2 AS (SELECT EMPLOYEE_ID, CASE WHEN CNT = 1 THEN DEPARTMENT_ID WHEN CNT > 1 AND PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE -1 END AS DEPARTMENT_ID FROM CTE1) SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID FROM CTE2 WHERE DEPARTMENT_ID <> -1;

/*
Prediction Result:
*/