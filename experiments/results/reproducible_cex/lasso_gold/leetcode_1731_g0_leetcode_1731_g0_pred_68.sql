-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1194, 'Amy Silva', 0, 1196);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1195, 'Sarah Moore', 0, 1198);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1199, 'Angela Lopez', -1, 1201);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1200, 'Angela Lopez', -1, 1203);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (0, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (-1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, None, 2, 1202.0)
(0, None, 2, 1197.0)
*/

-- Prediction Query
SELECT EMPLOYEES.EMPLOYEE_ID, EMPLOYEES.NAME, TAB1.CNT AS REPORTS_COUNT, TAB1.AVERAGE_AGE AS AVERAGE_AGE FROM EMPLOYEES INNER JOIN (SELECT COALESCE(REPORTS_TO, 0) AS RT, COUNT(REPORTS_TO) AS CNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES WHERE REPORTS_TO <> 0 GROUP BY REPORTS_TO HAVING COUNT(REPORTS_TO) >= 1) AS TAB1 ON TAB1.RT = EMPLOYEES.EMPLOYEE_ID ORDER BY EMPLOYEES.EMPLOYEE_ID;

/*
Prediction Result:
(-1, None, 2, 1202.0)
*/