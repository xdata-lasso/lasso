-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (2, 'default2', 2, 1), (-1, 'default1', 0, 1), (1, 'default1', 2, NULL), (0, NULL, NULL, NULL), (3, 'default2', -1, 2), (4, NULL, 2, 1), (5, NULL, 0, 2), (6, NULL, 0, NULL), (7, NULL, 2, 2), (8, 'default1', 1, 1), (9, 'default1', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, 'default1', 1, 2.0)
(0, None, 3, 2.0)
(1, 'default1', 2, 1.0)
(2, 'default2', 4, 1.0)
*/

-- Prediction Query
SELECT E.EMPLOYEE_ID, E.NAME, COUNT(Q.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(Q.AGE) AS REAL) / COUNT(Q.EMPLOYEE_ID), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E JOIN (SELECT * FROM EMPLOYEES WHERE NOT REPORTS_TO IS NULL) AS Q ON E.EMPLOYEE_ID = Q.REPORTS_TO GROUP BY E.EMPLOYEE_ID ORDER BY E.EMPLOYEE_ID, E.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default1', 1, 2.0)
(0, None, 3, 1.0)
(1, 'default1', 2, 1.0)
(2, 'default2', 4, 1.0)
*/