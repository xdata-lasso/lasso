-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (2, NULL, 0, 1), (0, 'default1', 2, 1), (-1, 'default1', -1, NULL), (1, 'default1', 1, 1), (3, 'default2', 2, 2), (4, 'default2', 2, NULL), (5, NULL, NULL, NULL), (6, 'default1', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, 'default1', 1, None)
(0, 'default1', 1, 1.0)
(1, 'default1', 2, 1.0)
(2, None, 3, 2.0)
*/

-- Prediction Query
SELECT E.EMPLOYEE_ID, E.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(CAST(SUM(E1.AGE) AS REAL) / COUNT(*), 0) AS AVERAGE_AGE FROM (SELECT DISTINCT EMPLOYEE_ID, NAME FROM EMPLOYEES) AS E JOIN EMPLOYEES AS E1 ON E.EMPLOYEE_ID = E1.REPORTS_TO GROUP BY E.EMPLOYEE_ID, E.NAME ORDER BY E.EMPLOYEE_ID, E.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default1', 1, None)
(0, 'default1', 1, 1.0)
(1, 'default1', 2, 1.0)
(2, None, 3, 1.0)
*/