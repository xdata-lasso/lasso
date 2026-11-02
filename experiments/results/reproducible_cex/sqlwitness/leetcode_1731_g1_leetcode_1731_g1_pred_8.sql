-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (-1, NULL, 2, 3), (3, 'default2', -1, 3), (2, 'default2', NULL, 2), (0, NULL, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(-1, None, 1, 3.0)
(0, None, 1, None)
(2, 'default2', 1, 3.0)
*/

-- Prediction Query
SELECT E1.EMPLOYEE_ID, E1.NAME, SUM(IIF(E2.REPORTS_TO, 1, 0)) AS REPORTS_COUNT, ROUND(AVG(E2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 JOIN EMPLOYEES AS E2 ON E1.EMPLOYEE_ID = E2.REPORTS_TO GROUP BY 1, 2 ORDER BY 1, E1.EMPLOYEE_ID NULLS LAST, E1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, None, 1, 3.0)
(0, None, 0, None)
(2, 'default2', 1, 3.0)
*/