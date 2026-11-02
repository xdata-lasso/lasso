-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (10, 'Zack', NULL, 50);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (5, 'Alice', 10, 40);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'Bob', 5, 25);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'Charlie', 5, 26);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'David', 10, 35);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (4, 'Eve', NULL, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(5, 'Alice', 2, 26.0)
(10, 'Zack', 2, 38.0)
*/

-- Prediction Query
SELECT E2.EMPLOYEE_ID AS EMPLOYEE_ID, E2.NAME AS NAME, COUNT(E1.REPORTS_TO) AS REPORTS_COUNT, CAST(AVG(E1.AGE) AS UBIGINT) AS AVERAGE_AGE FROM EMPLOYEES AS E1 JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID WHERE NOT E1.REPORTS_TO IS NULL GROUP BY E2.EMPLOYEE_ID, E2.NAME ORDER BY E2.EMPLOYEE_ID, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(5, 'Alice', 2, 25)
(10, 'Zack', 2, 37)
*/