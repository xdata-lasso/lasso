-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, 1018, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1019, 1020, 'site');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1021, NULL, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1023, NULL, 'face');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1017, 1018)
(1019, 1020)
(1021, None)
*/

-- Prediction Query
SELECT E1.EMPLOYEE_ID, E1.DEPARTMENT_ID FROM EMPLOYEE AS E1 WHERE E1.PRIMARY_FLAG = 'Y' OR E1.EMPLOYEE_ID IN (SELECT E2.EMPLOYEE_ID FROM EMPLOYEE AS E2 GROUP BY 1 HAVING COUNT(*) = 1);

/*
Prediction Result:
(1017, 1018)
(1019, 1020)
(1021, None)
(1023, None)
*/