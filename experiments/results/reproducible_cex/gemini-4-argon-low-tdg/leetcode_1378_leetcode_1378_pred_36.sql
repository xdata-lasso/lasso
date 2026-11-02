-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employees (id, name) VALUES (1, 'Alice');
INSERT INTO Employees (id, name) VALUES (2, 'Bob');
INSERT INTO EmployeeUNI (id, unique_id) VALUES (1, 10);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (1, 20);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(10, 'Alice')
(20, 'Alice')
(10, 'Bob')
*/

-- Prediction Query
SELECT (SELECT UNIQUE_ID FROM EMPLOYEEUNI AS U WHERE U.ID = E.ID) AS UNIQUE_ID, NAME FROM EMPLOYEES AS E;

/*
Prediction Result:
(10, 'Alice')
(10, 'Bob')
*/