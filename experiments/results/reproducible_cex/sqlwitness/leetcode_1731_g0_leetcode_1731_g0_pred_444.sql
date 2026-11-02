-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (-1, 'default2', NULL, 1), (1, 'default1', 2, NULL), (0, 'default1', 1, NULL), (2, 'default2', 2, 2), (3, 'default1', 2, NULL), (4, 'default2', -1, 1), (5, NULL, 2, 1), (6, 'default2', NULL, 2), (7, 'default1', 1, 1), (8, 'default2', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, 'default2', 1, 1.0)
(1, 'default1', 2, 1.0)
(2, 'default2', 5, 2.0)
*/

-- Prediction Query
SELECT TBL1.EMPLOYEE_ID, TBL1.NAME, COUNT(TBL2.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(TBL2.AGE) AS REAL) / COUNT(TBL2.EMPLOYEE_ID)) AS AVERAGE_AGE FROM EMPLOYEES AS TBL1 JOIN EMPLOYEES AS TBL2 ON TBL1.EMPLOYEE_ID = TBL2.REPORTS_TO GROUP BY TBL1.EMPLOYEE_ID, TBL1.NAME HAVING COUNT(TBL2.EMPLOYEE_ID) > 0 ORDER BY TBL1.EMPLOYEE_ID, TBL1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 1, 1.0)
(1, 'default1', 2, 1.0)
(2, 'default2', 5, 1.0)
*/