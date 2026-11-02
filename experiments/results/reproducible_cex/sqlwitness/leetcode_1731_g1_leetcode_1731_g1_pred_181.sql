-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (2, 'default1', NULL, NULL), (0, 'default1', NULL, 1), (1, 'default2', 2, 1), (3, 'default2', 2, 2), (4, 'default1', 0, NULL), (5, NULL, 1, NULL), (6, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(0, 'default1', 1, None)
(1, 'default2', 2, 1.0)
(2, 'default1', 2, 2.0)
*/

-- Prediction Query
SELECT M.EMPLOYEE_ID, M.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(E.AGE)) AS AVERAGE_AGE FROM EMPLOYEES AS E CROSS JOIN EMPLOYEES AS M WHERE E.REPORTS_TO = M.EMPLOYEE_ID GROUP BY 1 HAVING COUNT(DISTINCT E.NAME) >= 1;

/*
Prediction Result:
(0, 'default1', 1, None)
(2, 'default1', 2, 2.0)
*/