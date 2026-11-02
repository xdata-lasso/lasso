-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 10, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 20, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 30, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (4, 20, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (4, 30, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 10)
(2, 10)
(3, 20)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG ASC) AS RNK FROM EMPLOYEE) AS X WHERE X.RNK = 1;

/*
Prediction Result:
(1, 10)
(2, 10)
(3, 30)
(4, 20)
*/