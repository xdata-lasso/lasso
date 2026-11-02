-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1014, 1015, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1014, 1016, 'site');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, NULL, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1017, NULL, 'face');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1014, 1015)
(1017, None)
*/

-- Prediction Query
WITH TMP AS (SELECT *, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS DEPARTMENT_COUNT FROM EMPLOYEE), TMP2 AS (SELECT EMPLOYEE_ID, CASE WHEN PRIMARY_FLAG = 'N' AND DEPARTMENT_COUNT = 1 THEN DEPARTMENT_ID WHEN PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE NULL END AS DEPARTMENT_ID FROM TMP) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TMP2 WHERE NOT DEPARTMENT_ID IS NULL;

/*
Prediction Result:
(1014, 1015)
*/