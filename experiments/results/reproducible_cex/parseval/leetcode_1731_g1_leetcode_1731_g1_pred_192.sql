-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'ee__5f9879', 1, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (3, NULL, 3, NULL);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (4, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (5, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (6, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (7, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (8, 'value', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'ee__5f9879', 1, 1.0)
(3, None, 1, None)
*/

-- Prediction Query
SELECT MNG.EMPLOYEE_ID, MNG.NAME, COUNT(EE.NAME) AS REPORTS_COUNT, ROUND(AVG(EE.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS EE CROSS JOIN EMPLOYEES AS MNG WHERE EE.REPORTS_TO = MNG.EMPLOYEE_ID GROUP BY MNG.EMPLOYEE_ID ORDER BY MNG.EMPLOYEE_ID, MNG.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'ee__5f9879', 1, 1.0)
(3, None, 0, None)
*/