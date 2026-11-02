-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 100, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 200, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 100, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 300, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 100, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 200, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 300, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, 100)
(2, 300)
(3, 200)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, COALESCE(MAX(CASE WHEN PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE NULL END), MAX(DEPARTMENT_ID)) AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1;

/*
Prediction Result:
(1, 200)
(2, 300)
(3, 200)
*/