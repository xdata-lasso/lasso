-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1001, 1002, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1001, 1003, 'purpose');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1001, 1002)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT *, COUNT(*) OVER (PARTITION BY EMPLOYEE_ID) AS DEP_COUNT_FOR_EMPL FROM EMPLOYEE) AS INTERM WHERE NOT ((DEP_COUNT_FOR_EMPL > 1) AND (PRIMARY_FLAG = 'N'));

/*
Prediction Result:
(1001, 1002)
(1001, 1003)
*/