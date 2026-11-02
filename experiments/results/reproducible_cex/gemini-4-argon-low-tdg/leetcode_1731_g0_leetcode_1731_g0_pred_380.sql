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
SELECT T1.REPORTS_TO AS EMPLOYEE_ID, T2.NAME, COUNT(T1.EMPLOYEE_ID) AS REPORTS_COUNT, CAST(AVG(T1.AGE) AS REAL(15, 0)) AS AVERAGE_AGE FROM EMPLOYEES AS T1 JOIN EMPLOYEES AS T2 ON T1.REPORTS_TO = T2.EMPLOYEE_ID GROUP BY 1, 2 HAVING COUNT(T1.EMPLOYEE_ID) >= 1 ORDER BY 1, EMPLOYEE_ID NULLS LAST, T2.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(5, 'Alice', 2, 25.5)
(10, 'Zack', 2, 37.5)
*/