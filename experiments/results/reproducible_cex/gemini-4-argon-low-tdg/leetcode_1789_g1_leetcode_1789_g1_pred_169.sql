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
WITH TEMP_TBL AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID) AS RN FROM EMPLOYEE) AS AA WHERE AA.RN = 1 AND AA.PRIMARY_FLAG = 'N' AND NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM TEMP_TBL) UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TEMP_TBL;

/*
Prediction Result:
(1, 10)
(2, 10)
(3, 30)
(4, 50)
*/