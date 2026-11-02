-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 2, 'Y'), (2, 2, 'Y'), (1, 0, 'N'), (-1000, -998, 'Y'), (-1000, -992, 'N'), (-1000, -995, 'Y'), (-1000, -989, 'Y'), (0, 1, 'N'), (1, 2, 'N'), (2, 1, 'N'), (-1000, -999, 'Y'), (-1000, -996, 'Y'), (-1000, -993, 'N'), (-1000, -990, 'Y'), (0, 0, 'N'), (1, 1, 'N'), (2, 0, 'N'), (-1000, -1000, 'Y'), (-1000, -994, 'Y'), (-1000, -997, 'Y'), (-1000, -991, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(-1000, -1000)
(-1000, -999)
(-1000, -998)
(-1000, -997)
(-1000, -996)
(-1000, -995)
(-1000, -994)
(-1000, -990)
(-1000, -989)
(0, 2)
(2, 2)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'N' AND NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(-1000, -1000)
(-1000, -999)
(-1000, -998)
(-1000, -997)
(-1000, -996)
(-1000, -995)
(-1000, -994)
(-1000, -990)
(-1000, -989)
(0, 2)
(1, 0)
(1, 1)
(1, 2)
(2, 2)
*/