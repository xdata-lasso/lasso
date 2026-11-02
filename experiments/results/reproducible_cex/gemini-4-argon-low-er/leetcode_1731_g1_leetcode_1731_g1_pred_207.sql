-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'Manager', NULL, 40);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, NULL, 1, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'Manager', 1, 25.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COUNT(NAME) AS REPORTS_COUNT, REPORTS_TO, ROUND(AVG(AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) SELECT EMPLOYEE_ID, NAME, REPORTS_COUNT, AVERAGE_AGE FROM EMPLOYEES AS E JOIN CTE ON E.EMPLOYEE_ID = CTE.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Prediction Result:
(1, 'Manager', 0, 25.0)
*/