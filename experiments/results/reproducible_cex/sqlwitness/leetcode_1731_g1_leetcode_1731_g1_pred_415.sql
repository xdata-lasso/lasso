-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (0, 'default1', 0, NULL), (1, 'default2', 0, NULL), (-1, 'default1', 0, 1), (2, 'default1', 1, NULL), (3, 'default2', NULL, 1), (4, 'default1', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(0, 'default1', 3, 1.0)
(1, 'default2', 2, 1.0)
*/

-- Prediction Query
SELECT B.EMPLOYEE_ID AS EMPLOYEE_ID, B.NAME AS NAME, COUNT(A.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(A.AGE) AS REAL) / COUNT(A.EMPLOYEE_ID), 0) AS AVERAGE_AGE FROM EMPLOYEES AS A JOIN EMPLOYEES AS B ON A.REPORTS_TO = B.EMPLOYEE_ID GROUP BY A.REPORTS_TO ORDER BY B.EMPLOYEE_ID, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(0, 'default1', 3, 0.0)
(1, 'default2', 2, 1.0)
*/