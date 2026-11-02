-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Employees (id, name) VALUES (0, 'Zero');
INSERT INTO Employees (id, name) VALUES (-5, 'Negative');
INSERT INTO EmployeeUNI (id, unique_id) VALUES (0, -100);
INSERT INTO EmployeeUNI (id, unique_id) VALUES (-5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(0, 'Negative')
(-100, 'Zero')
*/

-- Prediction Query
SELECT UNIQUE_ID, NAME FROM EMPLOYEES LEFT JOIN EMPLOYEEUNI ON IIF(EMPLOYEES.ID = EMPLOYEEUNI.ID, EMPLOYEES.ID, NULL);

/*
Prediction Result:
(0, 'Negative')
(None, 'Zero')
*/