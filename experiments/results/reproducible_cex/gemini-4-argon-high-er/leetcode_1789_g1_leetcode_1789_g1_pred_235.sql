-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
*/

-- Prediction Query
WITH T1 AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG ASC) AS RNK FROM EMPLOYEE) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM T1 WHERE RNK = 1;

/*
Prediction Result:
(1, 20)
*/