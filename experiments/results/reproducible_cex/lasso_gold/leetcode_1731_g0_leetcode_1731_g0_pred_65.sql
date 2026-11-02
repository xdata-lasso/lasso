-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1021, 'Abigail Shaffer', 1022, 1023);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1024, 'Gina Moore', 1021, 1025);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1026, 'Gabrielle Davis', 1027, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1029, 'Ryan Munoz', 1026, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1022, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1027, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1021, 'Abigail Shaffer', 1, 1025.0)
(1022, None, 1, 1023.0)
(1026, 'Gabrielle Davis', 1, None)
(1027, None, 1, None)
*/

-- Prediction Query
SELECT T1.EMPLOYEE_ID, T1.NAME, COUNT(T2.AGE) AS REPORTS_COUNT, ROUND(AVG(T2.AGE)) AS AVERAGE_AGE FROM EMPLOYEES AS T1 JOIN EMPLOYEES AS T2 ON T1.EMPLOYEE_ID = T2.REPORTS_TO GROUP BY T1.EMPLOYEE_ID ORDER BY T1.EMPLOYEE_ID, T1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1021, 'Abigail Shaffer', 1, 1025.0)
(1022, None, 1, 1023.0)
(1026, 'Gabrielle Davis', 0, None)
(1027, None, 0, None)
*/