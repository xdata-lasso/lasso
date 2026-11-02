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
SELECT A.EMPLOYEE_ID, A.NAME, COUNT(B.NAME) AS REPORTS_COUNT, ROUND(AVG(B.AGE), 0) AS AVERAGE_AGE FROM EMPLOYEES AS A JOIN EMPLOYEES AS B ON A.EMPLOYEE_ID = B.REPORTS_TO GROUP BY A.EMPLOYEE_ID ORDER BY A.EMPLOYEE_ID, A.NAME NULLS LAST, REPORTS_COUNT NULLS LAST, AVERAGE_AGE NULLS LAST;

/*
Prediction Result:
(1, None, 1, 30.0)
(2, None, 1, 24.0)
*/