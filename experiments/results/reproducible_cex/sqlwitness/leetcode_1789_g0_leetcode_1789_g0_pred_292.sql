-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (-1000, -998, 'N'), (1, 2, 'N'), (-1000, -995, 'Y'), (2, 1, 'N'), (0, 0, 'N'), (-1000, -999, 'Y'), (1, 1, 'Y'), (-1000, -996, 'N'), (2, 0, 'Y'), (0, 2, 'N'), (-1000, -1000, 'N'), (-1000, -994, 'Y'), (2, 2, 'Y'), (1, 0, 'Y'), (-1000, -997, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1000, -999)
(-1000, -995)
(-1000, -994)
(1, 0)
(1, 1)
(2, 0)
(2, 2)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT * FROM CTE UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM CTE) AND PRIMARY_FLAG = 'N';

/*
Prediction Result:
(-1000, -999)
(-1000, -995)
(-1000, -994)
(0, 0)
(0, 1)
(0, 2)
(1, 0)
(1, 1)
(2, 0)
(2, 2)
*/