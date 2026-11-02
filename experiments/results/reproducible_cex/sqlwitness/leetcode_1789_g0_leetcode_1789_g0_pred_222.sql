-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (-1000, -998, 'N'), (1, 2, 'N'), (-1000, -995, 'N'), (2, 1, 'Y'), (0, 0, 'N'), (-1000, -999, 'Y'), (1, 1, 'N'), (-1000, -996, 'Y'), (2, 0, 'N'), (0, 2, 'N'), (-1000, -1000, 'N'), (2, 2, 'N'), (1, 0, 'N'), (-1000, -997, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1000, -999)
(-1000, -996)
(0, 1)
(2, 1)
*/

-- Prediction Query
WITH TEMP1 AS (SELECT * FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y'), TEMP2 AS (SELECT * FROM EMPLOYEE WHERE PRIMARY_FLAG = 'N' AND NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM TEMP1)) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TEMP1 UNION ALL SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TEMP2;

/*
Prediction Result:
(0, 1)
(2, 1)
(-1000, -999)
(-1000, -996)
(1, 2)
(1, 1)
(1, 0)
*/