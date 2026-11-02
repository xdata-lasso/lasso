-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 0, 'N'), (1, 1, 'Y'), (2, 2, 'N'), (0, 1, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 1)
(2, 2)
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, MAX(CASE WHEN CNT = 1 THEN A.DEPARTMENT_ID WHEN CNT > 1 AND A.PRIMARY_FLAG = 'Y' THEN A.DEPARTMENT_ID END) AS DEPARTMENT_ID FROM EMPLOYEE AS A INNER JOIN (SELECT EMPLOYEE_ID, COUNT(*) AS CNT FROM EMPLOYEE GROUP BY 1) AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY 1;

/*
Prediction Result:
(0, None)
(1, 1)
(2, 2)
*/