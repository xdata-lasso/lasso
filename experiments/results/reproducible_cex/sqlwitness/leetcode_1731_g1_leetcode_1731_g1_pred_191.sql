-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (1, 'default2', -1, 1), (-1, NULL, 0, NULL), (0, 'default1', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(-1, None, 1, 1.0)
(0, 'default1', 1, None)
(1, 'default2', 1, None)
*/

-- Prediction Query
SELECT MNG.EMPLOYEE_ID, MNG.NAME, COUNT(EE.NAME) AS REPORTS_COUNT, ROUND(AVG(EE.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS EE CROSS JOIN EMPLOYEES AS MNG WHERE EE.REPORTS_TO = MNG.EMPLOYEE_ID GROUP BY MNG.EMPLOYEE_ID ORDER BY MNG.EMPLOYEE_ID, MNG.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, None, 1, 1.0)
(0, 'default1', 0, None)
(1, 'default2', 1, None)
*/