-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'e_s_4abe2c', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (-2147483647, 'e_s_4abe2c', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'e_s_4abe2c', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'value', 2, NULL);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (4, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (5, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (6, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (7, 'value', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(2, 'value', 1, None)
*/

-- Prediction Query
SELECT M.REPORTS_TO AS EMPLOYEE_ID, E.NAME, COUNT(M.AGE) AS REPORTS_COUNT, ROUND(AVG(M.AGE)) AS AVERAGE_AGE FROM EMPLOYEES AS M CROSS JOIN EMPLOYEES AS E WHERE M.REPORTS_TO = E.EMPLOYEE_ID GROUP BY M.REPORTS_TO ORDER BY EMPLOYEE_ID, E.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(2, 'value', 0, None)
*/