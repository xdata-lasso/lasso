-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (NULL, 1, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E WHERE PRIMARY_FLAG = 'Y' OR (SELECT COUNT(*) FROM EMPLOYEE WHERE EMPLOYEE_ID = E.EMPLOYEE_ID) = 1;

/*
Prediction Result:
*/