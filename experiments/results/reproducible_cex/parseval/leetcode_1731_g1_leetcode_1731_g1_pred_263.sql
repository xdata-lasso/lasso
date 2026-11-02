-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1, 'emp_a1a089', 1, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (2, 'emp_a1a089', 2, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (3, 'value', NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (4, NULL, NULL, 1);

INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (5, NULL, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'emp_a1a089', 1, 1.0)
(2, 'emp_a1a089', 1, 1.0)
(5, None, 1, 1.0)
*/

-- Prediction Query
WITH MANAGERS AS (SELECT REPORTS_TO, ROUND(AVG(AGE)) AS AVG_AGE, COUNT(NAME) AS E_COUNT FROM EMPLOYEES WHERE NOT REPORTS_TO IS NULL GROUP BY REPORTS_TO) SELECT MANAGERS.REPORTS_TO AS EMPLOYEE_ID, EMPLOYEES.NAME, MANAGERS.E_COUNT AS REPORTS_COUNT, MANAGERS.AVG_AGE AS AVERAGE_AGE FROM MANAGERS LEFT JOIN EMPLOYEES ON MANAGERS.REPORTS_TO = EMPLOYEES.EMPLOYEE_ID ORDER BY MANAGERS.REPORTS_TO, EMPLOYEES.employee_id NULLS LAST;

/*
Prediction Result:
(1, 'emp_a1a089', 1, 1.0)
(2, 'emp_a1a089', 1, 1.0)
(5, None, 0, 1.0)
*/