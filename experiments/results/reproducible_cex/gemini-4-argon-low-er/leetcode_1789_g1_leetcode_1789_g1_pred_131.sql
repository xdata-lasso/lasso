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
SELECT T2.EMPLOYEE_ID, T2.DEPARTMENT_ID FROM (SELECT T1.*, (SELECT COUNT(DISTINCT T3.DEPARTMENT_ID) FROM EMPLOYEE AS T3 WHERE T1.EMPLOYEE_ID = T3.EMPLOYEE_ID) AS NUM_DEPT FROM EMPLOYEE AS T1) AS T2 WHERE NUM_DEPT = 1 OR (NUM_DEPT > 1 AND PRIMARY_FLAG = 'Y');

/*
Prediction Result:
*/