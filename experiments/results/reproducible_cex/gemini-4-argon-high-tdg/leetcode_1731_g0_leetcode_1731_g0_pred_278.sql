-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (1, NULL, NULL, 45);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (2, NULL, NULL, 52);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (3, NULL, 1, 30);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (4, 'ValidAgeSub', 1, NULL);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (5, 'SecondSub', 2, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(1, None, 2, 30.0)
(2, None, 1, 24.0)
*/

-- Prediction Query
SELECT E2.EMPLOYEE_ID, E2.NAME, COUNT(E1.EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(E1.AGE)) AS AVERAGE_AGE FROM EMPLOYEES AS E1 LEFT JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID WHERE NOT E2.NAME IS NULL GROUP BY E2.EMPLOYEE_ID, E2.NAME ORDER BY E2.EMPLOYEE_ID, E2.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
*/