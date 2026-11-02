-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS NUM FROM EMPLOYEE) AS EMP_NUM WHERE PRIMARY_FLAG = 'Y' OR (PRIMARY_FLAG = 'N' AND NUM = 1);

/*
Prediction Result:
*/