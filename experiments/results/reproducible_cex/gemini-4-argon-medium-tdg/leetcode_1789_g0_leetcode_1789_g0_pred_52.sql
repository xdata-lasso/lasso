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
WITH PRIMARIES AS (SELECT * FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT EMPLOYEE.EMPLOYEE_ID, CASE WHEN PRIMARIES.DEPARTMENT_ID IS NULL THEN EMPLOYEE.DEPARTMENT_ID ELSE PRIMARIES.DEPARTMENT_ID END AS DEPARTMENT_ID FROM EMPLOYEE LEFT JOIN PRIMARIES ON EMPLOYEE.EMPLOYEE_ID = PRIMARIES.EMPLOYEE_ID GROUP BY EMPLOYEE.EMPLOYEE_ID ORDER BY EMPLOYEE.EMPLOYEE_ID ASC, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(1, 10)
(2, 10)
(3, 20)
(4, 20)
*/