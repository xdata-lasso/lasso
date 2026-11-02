-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1023, 'Abigail Shaffer', 1024, 1025);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1026, 'Gina Moore', 1023, 1027);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1028, 'Gabrielle Davis', 1029, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1031, 'Ryan Munoz', 1028, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1029, 'Monica Herrera', 1029, 1033);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1034, 'Jamie Arnold', 1029, 1035);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1024, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1023, 'Abigail Shaffer', 1, 1027.0)
(1024, None, 1, 1025.0)
(1028, 'Gabrielle Davis', 1, None)
(1029, 'Monica Herrera', 3, 1034.0)
*/

-- Prediction Query
SELECT TBL1.EMPLOYEE_ID, TBL1.NAME, COUNT(TBL2.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(TBL2.AGE) AS REAL) / COUNT(TBL2.EMPLOYEE_ID)) AS AVERAGE_AGE FROM EMPLOYEES AS TBL1 JOIN EMPLOYEES AS TBL2 ON TBL1.EMPLOYEE_ID = TBL2.REPORTS_TO GROUP BY TBL1.EMPLOYEE_ID, TBL1.NAME HAVING COUNT(TBL2.EMPLOYEE_ID) > 0 ORDER BY TBL1.EMPLOYEE_ID, TBL1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1023, 'Abigail Shaffer', 1, 1027.0)
(1024, None, 1, 1025.0)
(1028, 'Gabrielle Davis', 1, None)
(1029, 'Monica Herrera', 3, 689.0)
*/