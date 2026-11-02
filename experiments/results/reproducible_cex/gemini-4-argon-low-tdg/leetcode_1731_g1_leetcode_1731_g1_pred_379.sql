-- Schema DDL
CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "reports_to" INTEGER, "age" INTEGER, FOREIGN KEY ("reports_to") REFERENCES "Employees" ("employee_id"), CHECK ("age" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (1, 'Alice', NULL, 50);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (2, 'Bob', 1, 21);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (3, 'Charlie', 1, 22);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (4, 'David', 1, 25);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (5, 'Eve', 2, 20);
INSERT INTO Employees (employee_id, name, reports_to, age) VALUES (6, 'Frank', 2, 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.EMPLOYEE_ID, A.NAME, B.REPORTS_COUNT, B.AVERAGE_AGE FROM EMPLOYEES AS A JOIN (SELECT REPORTS_TO, COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, ROUND(AVG(AGE)) AS AVERAGE_AGE FROM EMPLOYEES GROUP BY REPORTS_TO) AS B ON A.EMPLOYEE_ID = B.REPORTS_TO ORDER BY EMPLOYEE_ID;

/*
Gold Result:
(1, 'Alice', 3, 23.0)
(2, 'Bob', 2, 22.0)
*/

-- Prediction Query
SELECT T1.REPORTS_TO AS EMPLOYEE_ID, T2.NAME, COUNT(T1.EMPLOYEE_ID) AS REPORTS_COUNT, CAST(AVG(T1.AGE) AS REAL(15, 0)) AS AVERAGE_AGE FROM EMPLOYEES AS T1 JOIN EMPLOYEES AS T2 ON T1.REPORTS_TO = T2.EMPLOYEE_ID GROUP BY 1, 2 HAVING COUNT(T1.EMPLOYEE_ID) >= 1 ORDER BY 1, EMPLOYEE_ID NULLS LAST, T2.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 3, 22.666666666666668)
(2, 'Bob', 2, 21.5)
*/