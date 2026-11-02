-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, 13, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (12, 11, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(12, 11)
*/

-- Prediction Query
WITH CTE1 AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS NUM_DEPARTMENT FROM EMPLOYEE), CTE2 AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, CASE WHEN NUM_DEPARTMENT = 1 THEN 1 WHEN NUM_DEPARTMENT > 1 AND PRIMARY_FLAG = 'Y' THEN 1 WHEN NUM_DEPARTMENT > 1 AND PRIMARY_FLAG = 'N' THEN 0 END AS FINAL_FLAG FROM CTE1) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM CTE2 WHERE FINAL_FLAG = 1;

/*
Prediction Result:
(12, 11)
*/