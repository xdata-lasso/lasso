-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'Manager', NULL, 40);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'Sub1', 1, 20);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'Sub2', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1, 'Manager', 2, 20.0)
*/

-- Prediction Query
SELECT E2.EMPLOYEE_ID, E2.NAME, COUNT(E1.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(E1.AGE) AS REAL) / COUNT(*), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 CROSS JOIN EMPLOYEES AS E2 WHERE E1.REPORTS_TO = E2.EMPLOYEE_ID GROUP BY 1 ORDER BY 1, E2.EMPLOYEE_ID NULLS LAST, E2.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'Manager', 2, 10.0)
*/