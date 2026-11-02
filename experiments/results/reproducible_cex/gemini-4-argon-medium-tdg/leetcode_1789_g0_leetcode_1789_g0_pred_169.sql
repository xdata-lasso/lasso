-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (10, 1, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (10, 2, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (20, 1, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (20, 2, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (20, 3, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(10, 1)
(10, 2)
(20, 3)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' GROUP BY EMPLOYEE_ID HAVING COUNT(EMPLOYEE_ID) >= 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(EMPLOYEE_ID) = 1;

/*
Prediction Result:
(10, 1)
(20, 3)
*/