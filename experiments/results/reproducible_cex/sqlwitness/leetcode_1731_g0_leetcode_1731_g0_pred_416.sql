-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (employee_id, name, reports_to, age) VALUES (-1, 'default2', 2, 2), (0, NULL, 2, 2), (2, NULL, 1, 1), (1, NULL, -1, NULL), (3, NULL, 2, 2), (4, 'default1', 2, NULL), (5, NULL, 1, 2), (6, 'default1', 0, 1), (7, 'default1', -1, NULL), (8, 'default2', 1, 2), (9, 'default1', NULL, 1), (10, 'default2', -1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(-1, 'default2', 3, 2.0)
(0, None, 1, 1.0)
(1, None, 3, 2.0)
(2, None, 4, 2.0)
*/

-- Prediction Query
SELECT B.EMPLOYEE_ID AS EMPLOYEE_ID, B.NAME AS NAME, COUNT(A.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(CAST(SUM(A.AGE) AS REAL) / COUNT(A.EMPLOYEE_ID), 0) AS AVERAGE_AGE FROM EMPLOYEES AS A JOIN EMPLOYEES AS B ON A.REPORTS_TO = B.EMPLOYEE_ID GROUP BY A.REPORTS_TO ORDER BY B.EMPLOYEE_ID, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 3, 1.0)
(0, None, 1, 1.0)
(1, None, 3, 2.0)
(2, None, 4, 2.0)
*/