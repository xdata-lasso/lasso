-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (-1000, -998, 'N'), (1, 2, 'N'), (2, 1, 'Y'), (0, 0, 'N'), (-1000, -999, 'N'), (1, 1, 'N'), (2, 0, 'Y'), (0, 2, 'Y'), (-1000, -1000, 'N'), (2, 2, 'Y'), (1, 0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(0, 2)
(1, 0)
(2, 0)
(2, 1)
(2, 2)
*/

-- Prediction Query
SELECT DISTINCT E1.EMPLOYEE_ID AS EMPLOYEE_ID, E2.DEPARTMENT_ID AS DEPARTMENT_ID FROM EMPLOYEE AS E1 INNER JOIN EMPLOYEE AS E2 ON E2.EMPLOYEE_ID = E1.EMPLOYEE_ID WHERE (E2.PRIMARY_FLAG = 'Y') OR (NOT 'Y' IN (SELECT E.PRIMARY_FLAG FROM EMPLOYEE AS E WHERE E.EMPLOYEE_ID = E1.EMPLOYEE_ID));

/*
Prediction Result:
(-1000, -1000)
(-1000, -999)
(-1000, -998)
(0, 2)
(1, 0)
(2, 0)
(2, 1)
(2, 2)
*/