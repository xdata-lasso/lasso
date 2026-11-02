-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 10, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 20, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 30, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 40, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (4, 50, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
(2, 10)
(4, 50)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(1, 10)
(2, 10)
(3, 30)
(3, 40)
(4, 50)
*/