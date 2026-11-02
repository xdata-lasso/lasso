-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (1, 'Manager', NULL, 45);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (2, 'Sub1', 1, NULL);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (3, 'Sub2', 1, 21);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (4, 'Sub3', 1, 22);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'Manager', 3, 22.0)
*/

-- Prediction Query
WITH CTE AS (SELECT A.EMPLOYEE_ID, A.NAME, B.AGE FROM EMPLOYEES AS A LEFT JOIN EMPLOYEES AS B ON A.EMPLOYEE_ID = B.REPORTS_TO) SELECT EMPLOYEE_ID, NAME, COUNT(AGE) AS REPORTS_COUNT, ROUND(AVG(AGE), 0) AS AVERAGE_AGE FROM CTE WHERE NOT AGE IS NULL GROUP BY 1 ORDER BY 1, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'Manager', 2, 22.0)
*/