-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (5, 'Boss', NULL, 65);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (6, NULL, 5, 27);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (7, 'Worker', 5, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(5, 'Boss', 2, 29.0)
*/

-- Prediction Query
SELECT A.REPORTS_TO AS EMPLOYEE_ID, B.NAME, COUNT(A.NAME) AS REPORTS_COUNT, ROUND(AVG(A.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS A JOIN EMPLOYEES AS B ON A.REPORTS_TO = B.EMPLOYEE_ID GROUP BY 1, 2 ORDER BY 1, 2, EMPLOYEE_ID NULLS LAST, B.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(5, 'Boss', 1, 29.0)
*/