-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, NULL, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT EMPLOYEE_ID, COUNT(EMPLOYEE_ID) AS DEP FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT A.EMPLOYEE_ID, A.DEPARTMENT_ID FROM EMPLOYEE AS A LEFT JOIN TEMP AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID WHERE A.PRIMARY_FLAG = 'Y' OR B.DEP = 1.00;

/*
Prediction Result:
(1, None)
*/