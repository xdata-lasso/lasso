-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1035, 'Monica Herrera', 1036, 1037);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1038, 'Jamie Arnold', 1035, 1039);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1040, NULL, 1041, 1042);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1043, NULL, 1040, 1044);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1036, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1041, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1035, 'Monica Herrera', 1, 1039.0)
(1036, None, 1, 1037.0)
(1040, None, 1, 1044.0)
(1041, None, 1, 1042.0)
*/

-- Prediction Query
SELECT E1.REPORTS_TO AS EMPLOYEE_ID, E2.NAME AS NAME, COUNT(E1.NAME) AS REPORTS_COUNT, ROUND(AVG(E1.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 LEFT JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID WHERE NOT E1.REPORTS_TO IS NULL GROUP BY E1.REPORTS_TO ORDER BY E1.REPORTS_TO, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1035, 'Monica Herrera', 1, 1039.0)
(1036, None, 1, 1037.0)
(1040, None, 0, 1044.0)
(1041, None, 0, 1042.0)
*/