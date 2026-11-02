-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1086, 1087, 'discover');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1088, 1089, 'early');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1090, 1091, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1086, 1092, 'mouth');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1093, 1094, 'play');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1095, 1096, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1088, 1089)
(1090, 1091)
(1093, 1094)
(1095, 1096)
*/

-- Prediction Query
WITH CTE AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM CTE) UNION SELECT * FROM CTE;

/*
Prediction Result:
(1086, 1087)
(1086, 1092)
(1088, 1089)
(1090, 1091)
(1093, 1094)
(1095, 1096)
*/