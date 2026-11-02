-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (1, 2, 'Y'), (2, 1, 'N'), (0, 0, 'Y'), (-1000, -999, 'N'), (1, 1, 'Y'), (2, 0, 'N'), (0, 2, 'N'), (-1000, -1000, 'Y'), (2, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1000, -1000)
(0, 0)
(0, 1)
(1, 1)
(1, 2)
*/

-- Prediction Query
SELECT DISTINCT E.EMPLOYEE_ID, COALESCE(E1.DEPARTMENT_ID, E.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN EMPLOYEE AS E1 ON E.EMPLOYEE_ID = E1.EMPLOYEE_ID AND E.PRIMARY_FLAG = 'N' AND E1.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(-1000, -1000)
(0, 0)
(0, 1)
(1, 1)
(1, 2)
(2, 0)
(2, 1)
(2, 2)
*/