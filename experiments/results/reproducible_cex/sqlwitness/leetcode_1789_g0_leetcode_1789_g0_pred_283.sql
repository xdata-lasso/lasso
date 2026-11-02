-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (1, 2, 'N'), (2, 1, 'N'), (0, 0, 'N'), (1, 1, 'N'), (2, 0, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(0, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM CTE UNION ALL SELECT DISTINCT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM CTE);

/*
Prediction Result:
(0, 0)
(1, 0)
(1, 1)
(1, 2)
(2, 0)
(2, 1)
*/