-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 20, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 30, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 40, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (4, 50, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (4, 60, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
(2, 20)
(3, 30)
*/

-- Prediction Query
SELECT T1.EMPLOYEE_ID, CASE WHEN T1.DEPARTMENT_ID IS NULL THEN T2.DEPARTMENT_ID ELSE T1.DEPARTMENT_ID END AS DEPARTMENT_ID FROM (SELECT E.EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN E.DEPARTMENT_ID ELSE NULL END AS DEPARTMENT_ID FROM EMPLOYEE AS E GROUP BY EMPLOYEE_ID) AS T1 LEFT JOIN (SELECT E.EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE AS E WHERE E.PRIMARY_FLAG = 'Y') AS T2 ON T1.EMPLOYEE_ID = T2.EMPLOYEE_ID;

/*
Prediction Result:
(1, 10)
(2, 20)
(3, 30)
(4, None)
*/