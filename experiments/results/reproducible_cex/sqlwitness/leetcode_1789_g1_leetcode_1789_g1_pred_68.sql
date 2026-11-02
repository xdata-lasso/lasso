-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, department_id, primary_flag) VALUES (0, 1, 'N'), (1, 2, 'Y'), (2, 1, 'N'), (0, 0, 'Y'), (1, 1, 'Y'), (0, 2, 'Y'), (1, 0, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 2)
(2, 1)
(0, 0)
(1, 1)
(0, 2)
*/

-- Prediction Query
SELECT B.EMPLOYEE_ID, B.DEPARTMENT_ID FROM EMPLOYEE AS B WHERE B.PRIMARY_FLAG = 'Y' OR (B.PRIMARY_FLAG = 'N' AND B.EMPLOYEE_ID IN (SELECT A.EMPLOYEE_ID FROM EMPLOYEE AS A GROUP BY A.EMPLOYEE_ID HAVING COUNT(*) = 1)) GROUP BY B.EMPLOYEE_ID;

/*
Prediction Result:
(0, 0)
(1, 1)
(2, 1)
*/