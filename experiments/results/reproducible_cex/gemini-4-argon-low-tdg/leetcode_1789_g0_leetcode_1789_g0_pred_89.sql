-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 30, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 40, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 50, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(2, 30)
(2, 40)
(3, 50)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY CASE WHEN PRIMARY_FLAG = 'Y' THEN 1 ELSE 2 END ASC) AS RN FROM EMPLOYEE) AS T WHERE RN = 1;

/*
Prediction Result:
(1, 10)
(2, 30)
(3, 50)
*/