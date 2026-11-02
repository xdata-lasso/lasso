-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1197, 1200, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1198, 1201, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1199, 1202, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1197, 1206, NULL);
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1204, 1207, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1205, 1208, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(1197, 1200)
(1198, 1201)
(1199, 1202)
(1204, 1207)
(1205, 1208)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM (SELECT *, COUNT(1) OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG) AS CNT FROM EMPLOYEE) AS TAB WHERE CNT = 1 OR (CNT > 1 AND PRIMARY_FLAG = 'Y');

/*
Prediction Result:
(1197, 1206)
(1197, 1200)
(1198, 1201)
(1199, 1202)
(1204, 1207)
(1205, 1208)
*/