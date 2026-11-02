-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (1, 2, 'N'), (2, 1, 'N'), (0, 0, 'N'), (1, 1, 'Y'), (0, 2, 'N'), (2, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, COUNT(*) AS CT, MAX(PRIMARY_FLAG) AS PF FROM EMPLOYEE GROUP BY EMPLOYEE_ID), CTE1 AS (SELECT * FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT DISTINCT C.EMPLOYEE_ID, CASE WHEN CT > 1 AND PF = 'Y' THEN C1.DEPARTMENT_ID ELSE E.DEPARTMENT_ID END AS DEPARTMENT_ID FROM CTE AS C INNER JOIN EMPLOYEE AS E ON C.EMPLOYEE_ID = E.EMPLOYEE_ID LEFT JOIN CTE1 AS C1 ON C1.EMPLOYEE_ID = C.EMPLOYEE_ID;

/*
Prediction Result:
(0, 0)
(0, 1)
(0, 2)
(1, 1)
(2, 1)
(2, 2)
*/