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
SELECT E1.EMPLOYEE_ID, E1.NAME, COUNT(DISTINCT E2.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(COALESCE(E2.AGE, 0)), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 INNER JOIN EMPLOYEES AS E2 ON E1.EMPLOYEE_ID = E2.REPORTS_TO GROUP BY E1.EMPLOYEE_ID, E1.NAME ORDER BY E1.EMPLOYEE_ID, E1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'Manager', 3, 20.0)
*/