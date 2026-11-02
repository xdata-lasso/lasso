-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (0, 'default2', 1, 2), (2, NULL, 0, 2), (-1, 'default1', 0, NULL), (1, 'default1', 1, 1), (3, NULL, 2, NULL), (4, 'default2', -1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, 'default1', 1, 2.0)
(0, 'default2', 2, 2.0)
(1, 'default1', 2, 2.0)
(2, None, 1, None)
*/

-- Prediction Query
SELECT EMPLOYEE_ID, NAME, REPORTS_COUNT, AVERAGE_AGE FROM EMPLOYEES JOIN (SELECT REPORTS_TO, COUNT(REPORTS_TO) AS REPORTS_COUNT, CAST(AVG(AGE) AS UBIGINT) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS T ON T.REPORTS_TO = EMPLOYEES.EMPLOYEE_ID ORDER BY EMPLOYEE_ID;

/*
Prediction Result:
(-1, 'default1', 1, 2)
(0, 'default2', 2, 2)
(1, 'default1', 2, 1)
(2, None, 1, None)
*/