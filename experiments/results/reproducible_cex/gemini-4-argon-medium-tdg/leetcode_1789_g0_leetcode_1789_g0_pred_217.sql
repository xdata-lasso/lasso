-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 100, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 100, 'y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 200, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 100, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 200, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 100)
(2, 200)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT *, COUNT(PRIMARY_FLAG) OVER (PARTITION BY EMPLOYEE_ID) AS CNT FROM EMPLOYEE) AS T WHERE PRIMARY_FLAG = 'Y' OR CNT = 1;

/*
Prediction Result:
(2, 200)
(3, 100)
(3, 200)
*/