-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, NULL, NULL, NULL);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'Sub1', 1, 20);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, NULL, 1, 21);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (4, 'Sub3', 1, NULL);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (5, 'Manager2', NULL, 45);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (6, 'Sub4', 5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1, None, 3, 21.0)
(5, 'Manager2', 1, None)
*/

-- Prediction Query
WITH AGE AS (SELECT A.EMPLOYEE_ID, A.NAME AS MANAGER_NAME, B.NAME AS DIRECT_REPORT_NAME, B.AGE FROM EMPLOYEES AS A INNER JOIN EMPLOYEES AS B ON A.EMPLOYEE_ID = B.REPORTS_TO) SELECT EMPLOYEE_ID, MANAGER_NAME AS NAME, COUNT(DIRECT_REPORT_NAME) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM AGE GROUP BY 1, 2 ORDER BY 1, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, None, 2, 21.0)
(5, 'Manager2', 1, None)
*/