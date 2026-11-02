-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (3, 'default1', 3, 2), (1, NULL, 0, 2), (2, 'default2', NULL, 2), (0, 'default1', 3, 1), (4, 'default1', NULL, 1), (5, 'default1', 2, 3), (6, 'default1', 1, NULL), (7, 'default1', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(0, 'default1', 1, 2.0)
(1, None, 1, None)
(2, 'default2', 1, 3.0)
(3, 'default1', 3, 1.0)
*/

-- Prediction Query
WITH AGE AS (SELECT A.EMPLOYEE_ID, A.NAME AS MANAGER_NAME, B.NAME AS DIRECT_REPORT_NAME, B.AGE FROM EMPLOYEES AS A INNER JOIN EMPLOYEES AS B ON A.EMPLOYEE_ID = B.REPORTS_TO) SELECT EMPLOYEE_ID, MANAGER_NAME AS NAME, COUNT(DIRECT_REPORT_NAME) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM AGE GROUP BY 1, 2 ORDER BY 1, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(0, 'default1', 0, 2.0)
(1, None, 1, None)
(2, 'default2', 1, 3.0)
(3, 'default1', 3, 1.0)
*/