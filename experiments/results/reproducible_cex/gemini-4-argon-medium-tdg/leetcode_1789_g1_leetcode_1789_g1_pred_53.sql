-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, NULL, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, NULL, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, NULL, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, None)
(1, 10)
(3, None)
*/

-- Prediction Query
WITH SINGLE AS (SELECT EMPLOYEE_ID, COUNT(EMPLOYEE_ID) AS COUNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT = 1), MULTI AS (SELECT EMPLOYEE_ID, COUNT(EMPLOYEE_ID) AS COUNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT > 1) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM SINGLE INNER JOIN EMPLOYEE AS E ON SINGLE.EMPLOYEE_ID = E.EMPLOYEE_ID UNION SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM MULTI INNER JOIN EMPLOYEE AS E ON MULTI.EMPLOYEE_ID = E.EMPLOYEE_ID WHERE E.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(2, None)
(3, None)
*/