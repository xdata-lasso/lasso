-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (1, 'Charlie', NULL, 55);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (2, 'Alice', NULL, 48);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (3, 'Bob', NULL, 60);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (4, 'David', 1, 40);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (5, 'Eve', 1, 41);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (6, 'Frank', 2, 24);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (7, 'Grace', 2, 25);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (8, 'Heidi', 2, 25);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (9, 'Ivan', 3, 33);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (10, 'Judy', NULL, 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'Charlie', 2, 41.0)
(2, 'Alice', 3, 25.0)
(3, 'Bob', 1, 33.0)
*/

-- Prediction Query
SELECT E2.EMPLOYEE_ID AS EMPLOYEE_ID, E2.NAME AS NAME, COUNT(E1.REPORTS_TO) AS REPORTS_COUNT, CAST(AVG(E1.AGE) AS UBIGINT) AS AVERAGE_AGE FROM EMPLOYEES AS E1 JOIN EMPLOYEES AS E2 ON E1.REPORTS_TO = E2.EMPLOYEE_ID WHERE NOT E1.REPORTS_TO IS NULL GROUP BY E2.EMPLOYEE_ID, E2.NAME ORDER BY E2.EMPLOYEE_ID, EMPLOYEE_ID NULLS LAST, NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'Charlie', 2, 40)
(2, 'Alice', 3, 24)
(3, 'Bob', 1, 33)
*/