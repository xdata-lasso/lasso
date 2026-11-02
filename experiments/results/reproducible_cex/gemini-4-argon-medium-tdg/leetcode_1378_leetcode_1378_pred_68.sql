-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Employees (id, name) VALUES (1, 'Alice');
INSERT INTO Employees (id, name) VALUES (2, 'Alice');
INSERT INTO Employees (id, name) VALUES (3, 'Bob');
INSERT INTO EmployeeUNI (id, unique_id) VALUES (1, 100);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (1, 101);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (2, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(100, 'Alice')
(101, 'Alice')
(100, 'Alice')
(None, 'Bob')
*/

-- Prediction Query
SELECT UNIQUE_ID, (NAME) AS NAME FROM EMPLOYEES AS E LEFT JOIN EMPLOYEEUNI AS U ON E.ID = U.ID GROUP BY E.ID;

/*
Prediction Result:
(100, 'Alice')
(100, 'Alice')
(None, 'Bob')
*/