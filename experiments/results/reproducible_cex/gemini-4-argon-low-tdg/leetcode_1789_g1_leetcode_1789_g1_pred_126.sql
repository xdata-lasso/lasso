-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 30, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 10, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
(1, 20)
(2, 10)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' GROUP BY EMPLOYEE_ID, PRIMARY_FLAG UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(DEPARTMENT_ID) = 1;

/*
Prediction Result:
(1, 10)
(2, 10)
*/