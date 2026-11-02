-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Employees (id, name) VALUES (0, NULL);
INSERT INTO Employees (id, name) VALUES (-5, '');
INSERT INTO Employees (id, name) VALUES (5, 'Frank');
INSERT INTO EmployeeUNI (id, unique_id) VALUES (0, 0);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (-5, -10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(-10, '')
(0, None)
(None, 'Frank')
*/

-- Prediction Query
SELECT UNIQUE_ID, NAME FROM EMPLOYEES LEFT JOIN EMPLOYEEUNI ON IIF(EMPLOYEES.ID = EMPLOYEEUNI.ID, EMPLOYEES.ID, NULL);

/*
Prediction Result:
(-10, '')
(None, None)
(None, 'Frank')
*/