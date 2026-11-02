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
SELECT M.REPORTS_TO AS EMPLOYEE_ID, E.NAME, COUNT(M.AGE) AS REPORTS_COUNT, ROUND(AVG(M.AGE)) AS AVERAGE_AGE FROM EMPLOYEES AS M CROSS JOIN EMPLOYEES AS E WHERE M.REPORTS_TO = E.EMPLOYEE_ID GROUP BY M.REPORTS_TO ORDER BY EMPLOYEE_ID, E.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1021, 'Abigail Shaffer', 1, 1025.0)
(1022, None, 1, 1023.0)
(1026, 'Gabrielle Davis', 0, None)
(1027, None, 0, None)
*/