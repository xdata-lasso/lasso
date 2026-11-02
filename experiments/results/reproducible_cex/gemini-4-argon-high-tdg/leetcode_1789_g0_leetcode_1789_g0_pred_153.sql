-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 20, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 20, 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 10)
*/

-- Prediction Query
WITH NO_PRIMARY AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(EMPLOYEE_ID) = 1 AND PRIMARY_FLAG = 'N'), YES_PRIMARY AS (SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM YES_PRIMARY UNION ALL SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM NO_PRIMARY;

/*
Prediction Result:
*/