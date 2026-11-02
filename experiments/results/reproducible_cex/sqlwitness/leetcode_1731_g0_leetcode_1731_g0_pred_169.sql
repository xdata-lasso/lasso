-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (2, 'default2', -1, 2), (-1, 'default1', 1, 2), (1, NULL, -1, NULL), (0, NULL, 2, 1), (3, 'default1', -1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, 'default1', 3, 2.0)
(1, None, 1, 2.0)
(2, 'default2', 1, 1.0)
*/

-- Prediction Query
SELECT E2.EMPLOYEE_ID, E2.NAME AS NAME, COUNT(E1.NAME) AS REPORTS_COUNT, ROUND(AVG(E1.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 JOIN EMPLOYEES AS E2 ON E2.EMPLOYEE_ID = E1.REPORTS_TO GROUP BY 1 ORDER BY 1, E2.EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default1', 2, 2.0)
(1, None, 1, 2.0)
(2, 'default2', 0, 1.0)
*/