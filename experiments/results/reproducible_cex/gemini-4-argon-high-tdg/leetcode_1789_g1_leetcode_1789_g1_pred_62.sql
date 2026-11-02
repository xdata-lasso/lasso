-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 100, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 200, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 100, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 300, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 100, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 200, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 300, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, 100)
(2, 300)
(3, 200)
*/

-- Prediction Query
SELECT E1.EMPLOYEE_ID, COALESCE(E2.DEPARTMENT_ID, E1.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E1 LEFT JOIN EMPLOYEE AS E2 ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID AND E1.PRIMARY_FLAG = 'N' AND E2.PRIMARY_FLAG = 'Y' GROUP BY E1.EMPLOYEE_ID;

/*
Prediction Result:
(1, 100)
(2, 100)
(3, 200)
*/