-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (10, 'Zane', NULL, 50);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (5, 'Alice', 10, 40);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'Bob', 10, 41);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'Charlie', 10, 41);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'David', 5, 30);
INSERT INTO "Employees" ("employee_id", "name", "reports_to", "age") VALUES (4, 'Eve', 5, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(5, 'Alice', 2, 31.0)
(10, 'Zane', 3, 41.0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, NAME, REPORTS_COUNT, AVERAGE_AGE FROM EMPLOYEES JOIN (SELECT REPORTS_TO, COUNT(REPORTS_TO) AS REPORTS_COUNT, CAST(AVG(AGE) AS UBIGINT) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS T ON T.REPORTS_TO = EMPLOYEES.EMPLOYEE_ID ORDER BY EMPLOYEE_ID;

/*
Prediction Result:
(5, 'Alice', 2, 30)
(10, 'Zane', 3, 40)
*/