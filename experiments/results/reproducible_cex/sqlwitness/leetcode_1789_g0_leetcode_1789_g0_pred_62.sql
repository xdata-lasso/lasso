-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (1, 2, 'Y'), (2, 1, 'Y'), (0, 0, 'Y'), (1, 1, 'Y'), (2, 0, 'Y'), (0, 2, 'N'), (2, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(0, 0)
(0, 1)
(1, 1)
(1, 2)
(2, 0)
(2, 1)
*/

-- Prediction Query
SELECT E1.EMPLOYEE_ID, COALESCE(E2.DEPARTMENT_ID, E1.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E1 LEFT JOIN EMPLOYEE AS E2 ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID AND E1.PRIMARY_FLAG = 'N' AND E2.PRIMARY_FLAG = 'Y' GROUP BY E1.EMPLOYEE_ID;

/*
Prediction Result:
(0, 0)
(1, 1)
(2, 0)
*/