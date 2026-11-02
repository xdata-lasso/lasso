-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1168, NULL, 1169, 1170);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1171, 'James Brown', 1168, 1172);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1173, 'William Baker', 1174, 1175);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1176, 'Jordan Henderson', 1173, 1177);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1169, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1174, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1168, None, 1, 1172.0)
(1169, None, 1, 1170.0)
(1173, 'William Baker', 1, 1177.0)
(1174, None, 1, 1175.0)
*/

-- Prediction Query
WITH MANAGERS AS (SELECT REPORTS_TO, ROUND(AVG(AGE)) AS AVG_AGE, COUNT(NAME) AS E_COUNT FROM EMPLOYEES WHERE NOT REPORTS_TO IS NULL GROUP BY REPORTS_TO) SELECT MANAGERS.REPORTS_TO AS EMPLOYEE_ID, EMPLOYEES.NAME, MANAGERS.E_COUNT AS REPORTS_COUNT, MANAGERS.AVG_AGE AS AVERAGE_AGE FROM MANAGERS LEFT JOIN EMPLOYEES ON MANAGERS.REPORTS_TO = EMPLOYEES.EMPLOYEE_ID ORDER BY MANAGERS.REPORTS_TO, EMPLOYEES.employee_id NULLS LAST;

/*
Prediction Result:
(1168, None, 1, 1172.0)
(1169, None, 0, 1170.0)
(1173, 'William Baker', 1, 1177.0)
(1174, None, 1, 1175.0)
*/