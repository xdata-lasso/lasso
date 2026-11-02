-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 1, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 2, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT E.EMPLOYEE_ID, COALESCE(E1.DEPARTMENT_ID, E.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN EMPLOYEE AS E1 ON E.EMPLOYEE_ID = E1.EMPLOYEE_ID AND E.PRIMARY_FLAG = 'N' AND E1.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(1, 1)
(1, 2)
*/