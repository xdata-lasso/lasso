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
WITH DEPS AS (SELECT EMPLOYEE_ID, COUNT(DISTINCT DEPARTMENT_ID) AS DEPS_NUM FROM EMPLOYEE AS E GROUP BY EMPLOYEE_ID) SELECT E.EMPLOYEE_ID, SUM(IIF(DEPS_NUM = 1, DEPARTMENT_ID, IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0))) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN DEPS AS D ON E.EMPLOYEE_ID = D.EMPLOYEE_ID GROUP BY E.EMPLOYEE_ID;

/*
Prediction Result:
(1, 0)
(2, 70)
(3, 50)
*/