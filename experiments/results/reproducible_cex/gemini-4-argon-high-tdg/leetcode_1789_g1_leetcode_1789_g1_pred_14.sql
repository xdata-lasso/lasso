-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 10, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 20, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 20, 'y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (4, 20, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (4, 30, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
(2, 10)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS CN FROM EMPLOYEE) AS TEMP WHERE (CASE WHEN CN = 1 THEN PRIMARY_FLAG = 'N' OR PRIMARY_FLAG = 'Y' WHEN CN > 1 THEN PRIMARY_FLAG = 'Y' END);

/*
Prediction Result:
(2, 10)
*/