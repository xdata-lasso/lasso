-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, NULL, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH NUM_DEPARTMENT AS (SELECT EMPLOYEE_ID, COUNT(*) AS N_DEPT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT EMPLOYEE.EMPLOYEE_ID AS EMPLOYEE_ID, EMPLOYEE.DEPARTMENT_ID AS DEPARTMENT_ID FROM EMPLOYEE LEFT JOIN NUM_DEPARTMENT ON EMPLOYEE.EMPLOYEE_ID = NUM_DEPARTMENT.EMPLOYEE_ID WHERE NUM_DEPARTMENT.N_DEPT = 1 OR EMPLOYEE.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(1, None)
*/