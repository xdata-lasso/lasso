-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH ALT AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY IIF(PRIMARY_FLAG = 'Y', 0, 1)) AS ROW_NUM FROM EMPLOYEE) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM ALT WHERE ROW_NUM = 1;

/*
Prediction Result:
(1, 10)
*/