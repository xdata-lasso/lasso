-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'SelfManager', 1, 40);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'SubToSelf', 1, 29);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'Lonely', NULL, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1, 'SelfManager', 2, 35.0)
*/

-- Prediction Query
SELECT M.EMPLOYEE_ID, M.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(E.AGE)) AS AVERAGE_AGE FROM EMPLOYEES AS M JOIN EMPLOYEES AS E ON E.REPORTS_TO = M.EMPLOYEE_ID WHERE E.EMPLOYEE_ID <> M.EMPLOYEE_ID GROUP BY 1 HAVING COUNT(*) >= 1 ORDER BY 1, M.EMPLOYEE_ID NULLS LAST, M.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'SelfManager', 1, 29.0)
*/