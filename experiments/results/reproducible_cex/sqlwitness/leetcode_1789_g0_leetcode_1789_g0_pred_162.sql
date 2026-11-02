-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (-1000, -998, 'Y'), (1, 2, 'Y'), (2, 1, 'Y'), (0, 0, 'N'), (-1000, -999, 'Y'), (1, 1, 'N'), (2, 0, 'N'), (0, 2, 'N'), (-1000, -1000, 'N'), (2, 2, 'N'), (1, 0, 'Y'), (-1000, -997, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1000, -999)
(-1000, -998)
(-1000, -997)
(1, 0)
(1, 2)
(2, 1)
*/

-- Prediction Query
WITH TEMP AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT * FROM TEMP UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM TEMP);

/*
Prediction Result:
(-1000, -999)
(-1000, -998)
(-1000, -997)
(0, 0)
(0, 1)
(0, 2)
(1, 0)
(1, 2)
(2, 1)
*/