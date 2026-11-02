-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (1, 'default1', NULL, NULL), (0, NULL, NULL, NULL), (2, NULL, 0, NULL), (3, 'default1', 1, NULL), (4, NULL, 0, 1), (5, 'default2', NULL, NULL), (6, 'default1', 0, NULL), (7, 'default1', 1, NULL), (8, 'default2', NULL, NULL), (9, 'default1', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(0, None, 4, 1.0)
(1, 'default1', 2, None)
*/

-- Prediction Query
WITH CTE AS (SELECT T.EMPLOYEE_ID, T.NAME, T.REPORTS_TO, S.AGE FROM EMPLOYEES AS T JOIN EMPLOYEES AS S ON T.EMPLOYEE_ID = S.REPORTS_TO) SELECT EMPLOYEE_ID, NAME, COUNT(*) AS REPORTS_COUNT, ROUND(CAST(SUM(AGE) AS REAL) / COUNT(*)) AS AVERAGE_AGE FROM CTE GROUP BY EMPLOYEE_ID ORDER BY EMPLOYEE_ID, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(0, None, 4, 0.0)
(1, 'default1', 2, None)
*/