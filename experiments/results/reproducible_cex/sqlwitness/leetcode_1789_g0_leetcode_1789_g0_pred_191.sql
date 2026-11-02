-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (1, 2, 'Y'), (2, 1, 'N'), (0, 0, 'Y'), (1, 1, 'N'), (2, 0, 'N'), (0, 2, 'Y'), (2, 2, 'N'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(0, 0)
(0, 1)
(0, 2)
(1, 0)
(1, 2)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT DISTINCT (E.EMPLOYEE_ID), CASE WHEN E.EMPLOYEE_ID IN (CTE.EMPLOYEE_ID) THEN CTE.DEPARTMENT_ID ELSE E.DEPARTMENT_ID END AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN CTE AS CTE ON CTE.EMPLOYEE_ID = E.EMPLOYEE_ID ORDER BY E.EMPLOYEE_ID, (E.EMPLOYEE_ID) NULLS LAST, DEPARTMENT_ID NULLS LAST;

/*
Prediction Result:
(0, 0)
(0, 1)
(0, 2)
(1, 0)
(1, 2)
(2, 0)
(2, 1)
(2, 2)
*/