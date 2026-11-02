-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (10, 'Bob', NULL, 55);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (2, 'Zack', 10, 30);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (5, 'Alice', NULL, 60);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (11, 'Dan', 10, 30);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (12, 'Eve', 10, 41);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (3, 'Charlie', 2, 20);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (4, 'Charlie', 2, 21);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (6, 'Frank', 5, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TB1.EMPLOYEE_ID, TB1.NAME, COUNT(*) AS REPORTS_COUNT, ROUND(AVG(TB2.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS TB1 JOIN EMPLOYEES AS TB2 ON TB1.EMPLOYEE_ID = TB2.REPORTS_TO GROUP BY 1 ORDER BY TB1.EMPLOYEE_ID, TB1.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Gold Result:
(2, 'Zack', 2, 21.0)
(5, 'Alice', 1, 19.0)
(10, 'Bob', 3, 34.0)
*/

-- Prediction Query
SELECT E2.EMPLOYEE_ID AS EMPLOYEE_ID, E2.NAME AS NAME, COUNT(E1.REPORTS_TO) AS REPORTS_COUNT, CAST(AVG(E1.AGE) AS UBIGINT) AS AVERAGE_AGE FROM EMPLOYEES AS E1 JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID WHERE NOT E1.REPORTS_TO IS NULL GROUP BY E2.EMPLOYEE_ID, E2.NAME ORDER BY E2.EMPLOYEE_ID, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(2, 'Zack', 2, 20)
(5, 'Alice', 1, 19)
(10, 'Bob', 3, 33)
*/