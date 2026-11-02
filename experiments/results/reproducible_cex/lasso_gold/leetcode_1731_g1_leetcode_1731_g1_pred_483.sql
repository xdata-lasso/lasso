-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1035, 'Monica Herrera', 1036, 1037);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1038, 'Jamie Arnold', 1035, 1039);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1048, 'Holly Wood', 1049, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1051, 'Derek Zuniga', 1048, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1036, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "name", "reports_to", "age") VALUES (1049, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1035, 'Monica Herrera', 1, 1039.0)
(1036, None, 1, 1037.0)
(1048, 'Holly Wood', 1, None)
(1049, None, 1, None)
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, A.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(COALESCE(AVG(B.AGE), 0)) AS AVERAGE_AGE FROM EMPLOYEES AS A JOIN EMPLOYEES AS B ON A.EMPLOYEE_ID = B.REPORTS_TO GROUP BY A.EMPLOYEE_ID, A.NAME ORDER BY A.EMPLOYEE_ID, A.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1035, 'Monica Herrera', 1, 1039.0)
(1036, None, 1, 1037.0)
(1048, 'Holly Wood', 1, 0.0)
(1049, None, 1, 0.0)
*/