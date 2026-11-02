-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Employees" ("id", "name") VALUES (10, 'David');
INSERT INTO "Employees" ("id", "name") VALUES (20, 'Eve');
INSERT INTO "EmployeeUNI" ("id", "unique_id") VALUES (10, 100);
INSERT INTO "EmployeeUNI" ("id", "unique_id") VALUES (10, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(100, 'David')
(200, 'David')
(None, 'Eve')
*/

-- Prediction Query
SELECT (SELECT UNIQUE_ID FROM EMPLOYEEUNI AS U WHERE U.ID = E.ID) AS UNIQUE_ID, NAME FROM EMPLOYEES AS E;

/*
Prediction Result:
(100, 'David')
(None, 'Eve')
*/