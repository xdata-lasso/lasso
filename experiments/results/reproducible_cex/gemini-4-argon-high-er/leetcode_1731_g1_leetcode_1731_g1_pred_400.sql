-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (1, 'Alice', NULL, 40);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (2, 'Bob', 1, 20);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (3, 'Charlie', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'Alice', 2, 20.0)
*/

-- Prediction Query
SELECT E1.REPORTS_TO AS EMPLOYEE_ID, E2.NAME AS NAME, COUNT(DISTINCT E1.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(E1.AGE) AS REAL) / COUNT(DISTINCT E1.EMPLOYEE_ID), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 LEFT JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID WHERE NOT E1.REPORTS_TO IS NULL GROUP BY 1, 2;

/*
Prediction Result:
(1, 'Alice', 2, 10.0)
*/