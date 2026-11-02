-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (2, 1, 'N'), (1, 2, 'Y'), (2, 2, 'N'), (0, 2, 'N'), (1, 1, 'Y'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 2)
(1, 1)
(1, 0)
*/

-- Prediction Query
SELECT DISTINCT E1.EMPLOYEE_ID AS EMPLOYEE_ID, E2.DEPARTMENT_ID AS DEPARTMENT_ID FROM EMPLOYEE AS E1 INNER JOIN EMPLOYEE AS E2 ON E2.EMPLOYEE_ID = E1.EMPLOYEE_ID WHERE (E2.PRIMARY_FLAG = 'Y') OR (NOT 'Y' IN (SELECT E.PRIMARY_FLAG FROM EMPLOYEE AS E WHERE E.EMPLOYEE_ID = E1.EMPLOYEE_ID));

/*
Prediction Result:
(0, 1)
(0, 2)
(1, 0)
(1, 1)
(1, 2)
(2, 1)
(2, 2)
*/