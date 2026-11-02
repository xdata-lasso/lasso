-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, NULL, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
(1, None)
*/

-- Prediction Query
SELECT E1.EMPLOYEE_ID, E1.DEPARTMENT_ID FROM EMPLOYEE AS E1 LEFT JOIN (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, COUNT(EMPLOYEE_ID) AS CNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS E2 ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID WHERE E1.PRIMARY_FLAG = 'Y' OR E2.CNT = 1;

/*
Prediction Result:
*/