-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 20, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, A.DEPARTMENT_ID FROM EMPLOYEE AS A INNER JOIN (SELECT EMPLOYEE_ID, COUNT(DISTINCT PRIMARY_FLAG) AS CN FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID WHERE (B.CN = 1) OR (B.CN > 1 AND PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(1, 10)
(1, 20)
*/