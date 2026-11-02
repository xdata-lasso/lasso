-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (1, 2, 'N'), (2, 1, 'Y'), (0, 0, 'N'), (1, 1, 'N'), (2, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, 1)
*/

-- Prediction Query
SELECT DISTINCT E.EMPLOYEE_ID, COALESCE(E1.DEPARTMENT_ID, E.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN EMPLOYEE AS E1 ON E.EMPLOYEE_ID = E1.EMPLOYEE_ID AND E.PRIMARY_FLAG = 'N' AND E1.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(0, 0)
(0, 1)
(1, 0)
(1, 1)
(1, 2)
(2, 1)
*/