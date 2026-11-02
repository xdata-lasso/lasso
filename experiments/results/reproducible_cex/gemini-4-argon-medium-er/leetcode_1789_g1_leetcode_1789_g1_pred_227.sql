-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, NULL, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1, 10)
(1, None)
*/

-- Prediction Query
WITH T0 AS (SELECT EMPLOYEE_ID, COUNT(*) AS CNT FROM EMPLOYEE GROUP BY EMPLOYEE_ID) SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM T0 CROSS JOIN EMPLOYEE AS E WHERE T0.EMPLOYEE_ID = E.EMPLOYEE_ID AND CNT = 1 UNION ALL SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM T0 CROSS JOIN EMPLOYEE AS E WHERE T0.EMPLOYEE_ID = E.EMPLOYEE_ID AND T0.CNT <> 1 AND E.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
*/