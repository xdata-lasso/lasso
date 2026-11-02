-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (0, 'default1', 0, 1), (-1, 'default2', 2, 2), (2, 'default1', -1, 2), (1, 'default2', NULL, NULL), (3, NULL, 1, 1), (4, 'default1', 0, NULL), (5, 'default2', 2, 2), (6, 'default2', -1, 2), (7, NULL, -1, NULL), (8, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, 'default2', 3, 2.0)
(0, 'default1', 2, 1.0)
(1, 'default2', 1, 1.0)
(2, 'default1', 3, 2.0)
*/

-- Prediction Query
SELECT E1.REPORTS_TO AS EMPLOYEE_ID, E2.NAME, COUNT(E1.NAME) AS REPORTS_COUNT, ROUND(AVG(E1.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 INNER JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID GROUP BY E1.REPORTS_TO ORDER BY E1.REPORTS_TO, EMPLOYEE_ID NULLS LAST, E2.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 2, 2.0)
(0, 'default1', 2, 1.0)
(1, 'default2', 0, 1.0)
(2, 'default1', 2, 2.0)
*/