-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1013, 'Cristian Santos', 1014, 1017);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1018, 'Cristian Santos', 1014, 1020);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1014, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1014, None, 2, 1019.0)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, NAME, REPORTS_COUNT, AVERAGE_AGE FROM EMPLOYEES JOIN (SELECT REPORTS_TO, COUNT(REPORTS_TO) AS REPORTS_COUNT, CAST(AVG(AGE) AS UBIGINT) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS T ON T.REPORTS_TO = EMPLOYEES.EMPLOYEE_ID ORDER BY EMPLOYEE_ID;

/*
Prediction Result:
(1014, None, 2, 1018)
*/