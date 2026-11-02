-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, NULL, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, NULL, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, NULL, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, None)
(1, 10)
(3, None)
*/

-- Prediction Query
WITH COUNT_TABLE AS (SELECT EMPLOYEE_ID, COUNT(EMPLOYEE_ID) AS NUM_OF_DEPARTMENT FROM EMPLOYEE GROUP BY EMPLOYEE_ID), TEMP_TABLE AS (SELECT EMPLOYEE.EMPLOYEE_ID, EMPLOYEE.DEPARTMENT_ID, EMPLOYEE.PRIMARY_FLAG, COUNT_TABLE.NUM_OF_DEPARTMENT FROM EMPLOYEE LEFT JOIN COUNT_TABLE ON EMPLOYEE.EMPLOYEE_ID = COUNT_TABLE.EMPLOYEE_ID) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TEMP_TABLE WHERE PRIMARY_FLAG = 'Y' OR NUM_OF_DEPARTMENT = 1;

/*
Prediction Result:
(2, None)
(3, None)
*/