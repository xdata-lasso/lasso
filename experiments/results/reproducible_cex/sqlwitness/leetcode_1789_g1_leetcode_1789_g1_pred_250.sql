-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'Y'), (1, 2, 'Y'), (2, 1, 'Y'), (0, 0, 'N'), (1, 1, 'Y'), (2, 0, 'N'), (0, 2, 'Y'), (2, 2, 'N'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(0, 1)
(1, 2)
(2, 1)
(1, 1)
(0, 2)
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, B.DEPARTMENT_ID FROM EMPLOYEE AS A LEFT JOIN (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY 1 HAVING COUNT(PRIMARY_FLAG) > 1 UNION ALL SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1 HAVING COUNT(PRIMARY_FLAG) = 1;

/*
Prediction Result:
(0, 1)
(1, 1)
(2, 1)
*/