-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (-1000, -998, 'N'), (1, 2, 'N'), (2, 1, 'N'), (0, 0, 'Y'), (-1000, -999, 'N'), (1, 1, 'Y'), (2, 0, 'N'), (0, 2, 'Y'), (-1000, -1000, 'Y'), (2, 2, 'N'), (1, 0, 'N'), (-1000, -997, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(0, 1)
(0, 0)
(1, 1)
(0, 2)
(-1000, -1000)
(-1000, -997)
*/

-- Prediction Query
WITH TEMP_TBL AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID, PRIMARY_FLAG, ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID) AS RN FROM EMPLOYEE) AS AA WHERE AA.RN = 1 AND AA.PRIMARY_FLAG = 'N' AND NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM TEMP_TBL) UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TEMP_TBL;

/*
Prediction Result:
(-1000, -1000)
(-1000, -997)
(0, 0)
(0, 1)
(0, 2)
(1, 1)
(2, 0)
*/