-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (2, 1, 'Y'), (0, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, 1)
(0, 0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, RANK() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG ASC) AS RANK_ FROM EMPLOYEE) AS TMP1 WHERE RANK_ = 1 ORDER BY EMPLOYEE_ID, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(0, 0)
(2, 1)
*/