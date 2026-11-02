-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (0, 'default2', 2, 3), (3, 'default1', 2, NULL), (-1, NULL, -1, 1), (1, 'default1', 2, 2), (2, 'default2', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, None, 1, 1.0)
(2, 'default2', 3, 3.0)
(3, 'default1', 1, 1.0)
*/

-- Prediction Query
SELECT E1.REPORTS_TO AS EMPLOYEE_ID, E2.NAME AS NAME, COUNT(DISTINCT E1.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(E1.AGE) AS REAL) / COUNT(DISTINCT E1.EMPLOYEE_ID), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 LEFT JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID WHERE NOT E1.REPORTS_TO IS NULL GROUP BY 1, 2;

/*
Prediction Result:
(-1, None, 1, 1.0)
(2, 'default2', 3, 2.0)
(3, 'default1', 1, 1.0)
*/