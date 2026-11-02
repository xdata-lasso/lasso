-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, NULL, NULL, 55);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'ManagerB', NULL, 45);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, NULL, 1, 30);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (4, 'Sub2', 1, NULL);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (5, 'Sub3', 1, 31);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (6, 'Sub4', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1, None, 3, 31.0)
(2, 'ManagerB', 1, None)
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, A.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(COALESCE(AVG(B.AGE), 0)) AS AVERAGE_AGE FROM EMPLOYEES AS A JOIN EMPLOYEES AS B ON A.EMPLOYEE_ID = B.REPORTS_TO GROUP BY A.EMPLOYEE_ID, A.NAME ORDER BY A.EMPLOYEE_ID, A.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, None, 3, 31.0)
(2, 'ManagerB', 1, 0.0)
*/