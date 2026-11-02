-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 20, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 30, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 10)
(2, 20)
*/

-- Prediction Query
SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, RANK() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG ASC) AS RNK FROM EMPLOYEE) AS E WHERE E.RNK = 1;

/*
Prediction Result:
(1, 10)
(2, 10)
(2, 30)
*/