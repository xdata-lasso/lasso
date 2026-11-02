-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'Alice', NULL, 40);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'Bob', 1, 20);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'Charlie', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'Alice', 2, 20.0)
*/

-- Prediction Query
SELECT E.EMPLOYEE_ID, E.NAME, COUNT(Q.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(Q.AGE) AS REAL) / COUNT(Q.EMPLOYEE_ID), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E JOIN (SELECT * FROM EMPLOYEES WHERE NOT REPORTS_TO IS NULL) AS Q ON E.EMPLOYEE_ID = Q.REPORTS_TO GROUP BY E.EMPLOYEE_ID ORDER BY E.EMPLOYEE_ID, E.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 2, 10.0)
*/