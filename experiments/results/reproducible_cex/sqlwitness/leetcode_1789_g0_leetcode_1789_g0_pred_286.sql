-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (-1000, -998, 'Y'), (1, 2, 'N'), (-1000, -995, 'Y'), (2, 1, 'N'), (0, 0, 'N'), (-1000, -999, 'Y'), (1, 1, 'N'), (-1000, -996, 'Y'), (2, 0, 'Y'), (0, 2, 'Y'), (-1000, -1000, 'N'), (2, 2, 'Y'), (1, 0, 'N'), (-1000, -997, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1000, -999)
(-1000, -998)
(-1000, -997)
(-1000, -996)
(-1000, -995)
(0, 2)
(2, 0)
(2, 2)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, MAX(PRIMARY_FLAG) AS PRIMARY_FLAG FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT EMP.EMPLOYEE_ID, EMP.DEPARTMENT_ID FROM CTE JOIN EMPLOYEE AS EMP ON CTE.PRIMARY_FLAG = EMP.PRIMARY_FLAG AND CTE.EMPLOYEE_ID = EMP.EMPLOYEE_ID;

/*
Prediction Result:
(-1000, -999)
(-1000, -998)
(-1000, -997)
(-1000, -996)
(-1000, -995)
(0, 2)
(1, 0)
(1, 1)
(1, 2)
(2, 0)
(2, 2)
*/