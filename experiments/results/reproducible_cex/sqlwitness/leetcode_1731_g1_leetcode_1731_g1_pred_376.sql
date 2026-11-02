-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (-1, 'default2', 1, 1), (2, NULL, 1, 1), (0, NULL, 1, NULL), (1, NULL, 2, 2), (3, NULL, 2, 2), (4, NULL, 0, 2), (5, 'default2', 0, NULL), (6, 'default1', -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(-1, 'default2', 1, None)
(0, None, 2, 2.0)
(1, None, 3, 1.0)
(2, None, 2, 2.0)
*/

-- Prediction Query
SELECT E2.EMPLOYEE_ID, E2.NAME, COUNT(E1.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(E1.AGE) AS REAL) / COUNT(*), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 CROSS JOIN EMPLOYEES AS E2 WHERE E1.REPORTS_TO = E2.EMPLOYEE_ID GROUP BY 1 ORDER BY 1, E2.EMPLOYEE_ID NULLS LAST, E2.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 1, None)
(0, None, 2, 1.0)
(1, None, 3, 1.0)
(2, None, 2, 2.0)
*/