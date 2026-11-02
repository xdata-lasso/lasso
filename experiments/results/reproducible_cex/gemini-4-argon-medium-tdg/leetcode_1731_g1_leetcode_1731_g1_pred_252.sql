-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'Manager', NULL, 55);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'Worker1', 1, 30);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'Worker2', 1, NULL);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (4, 'Worker3', 1, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'Manager', 3, 31.0)
*/

-- Prediction Query
WITH CTE AS (SELECT T.EMPLOYEE_ID, T.NAME, T.REPORTS_TO, S.AGE FROM EMPLOYEES AS T JOIN EMPLOYEES AS S ON T.EMPLOYEE_ID = S.REPORTS_TO) SELECT EMPLOYEE_ID, NAME, COUNT(*) AS REPORTS_COUNT, ROUND(CAST(SUM(AGE) AS REAL) / COUNT(*)) AS AVERAGE_AGE FROM CTE GROUP BY EMPLOYEE_ID ORDER BY EMPLOYEE_ID, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'Manager', 3, 20.0)
*/