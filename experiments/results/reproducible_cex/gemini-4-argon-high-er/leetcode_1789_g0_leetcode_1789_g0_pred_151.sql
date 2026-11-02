-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (NULL, 1, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (NULL, 2, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(None, 1)
(None, 2)
*/

-- Prediction Query
WITH MULT AS (SELECT EMPLOYEE_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) > 1) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION ALL SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM MULT AS M INNER JOIN EMPLOYEE AS E ON M.EMPLOYEE_ID = E.EMPLOYEE_ID WHERE PRIMARY_FLAG = 'Y';

/*
Prediction Result:
*/