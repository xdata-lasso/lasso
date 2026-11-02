-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (2, 2, 'N'), (0, 1, 'N'), (0, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(2, 2)
*/

-- Prediction Query
WITH CTE_FINAL AS (SELECT EMPLOYEE_ID, CASE WHEN COUNT(*) = 1 THEN MAX(DEPARTMENT_ID) ELSE SUM(IIF(PRIMARY_FLAG = 'Y', DEPARTMENT_ID, 0)) END AS DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1) SELECT * FROM CTE_FINAL;

/*
Prediction Result:
(0, 0)
(2, 2)
*/