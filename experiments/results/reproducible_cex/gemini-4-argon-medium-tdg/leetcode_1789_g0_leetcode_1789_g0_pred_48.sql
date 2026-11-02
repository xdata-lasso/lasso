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
WITH DEPS AS (SELECT EMPLOYEE_ID, COUNT(DISTINCT DEPARTMENT_ID) AS DEPS_NUM FROM EMPLOYEE AS E GROUP BY EMPLOYEE_ID) SELECT E.EMPLOYEE_ID, SUM(IIF(DEPS_NUM = 1, DEPARTMENT_ID, IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0))) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN DEPS AS D ON E.EMPLOYEE_ID = D.EMPLOYEE_ID GROUP BY E.EMPLOYEE_ID;

/*
Prediction Result:
(1, 10)
(2, 10)
(3, 20)
(4, 0)
*/