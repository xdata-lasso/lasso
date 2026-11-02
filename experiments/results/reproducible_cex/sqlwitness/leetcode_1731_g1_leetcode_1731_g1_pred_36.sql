-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (2, 'default2', 1, 2), (0, NULL, 2, 1), (-1, 'default2', -1, 2), (1, 'default1', 1, 1), (3, 'default1', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(-1, 'default2', 1, 2.0)
(0, None, 1, 1.0)
(1, 'default1', 2, 2.0)
(2, 'default2', 1, 1.0)
*/

-- Prediction Query
SELECT E1.EMPLOYEE_ID, E1.NAME, COUNT(E2.NAME) AS REPORTS_COUNT, ROUND(AVG(E2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS E1 LEFT JOIN EMPLOYEES AS E2 ON E1.EMPLOYEE_ID = E2.REPORTS_TO GROUP BY E1.EMPLOYEE_ID HAVING COUNT(E2.NAME) >= 1 ORDER BY E1.EMPLOYEE_ID, E1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 1, 2.0)
(0, None, 1, 1.0)
(1, 'default1', 2, 2.0)
*/