-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (id, name) VALUES (1, 'Alice');
INSERT INTO Employees (id, name) VALUES (7, 'Bob');
INSERT INTO Employees (id, name) VALUES (11, 'Meir');
INSERT INTO Employees (id, name) VALUES (90, 'Winston');
INSERT INTO Employees (id, name) VALUES (3, 'Jonathan');
INSERT INTO EmployeeUNI (id, unique_id) VALUES (3, 1);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (11, 2);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (90, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(None, 'Alice')
(1, 'Jonathan')
(None, 'Bob')
(2, 'Meir')
(3, 'Winston')
*/

-- Prediction Query
SELECT E.NAME, EU.UNIQUE_ID FROM EMPLOYEES AS E LEFT JOIN EMPLOYEEUNI AS EU ON E.ID = EU.ID;

/*
Prediction Result:
('Alice', None)
('Jonathan', 1)
('Bob', None)
('Meir', 2)
('Winston', 3)
*/