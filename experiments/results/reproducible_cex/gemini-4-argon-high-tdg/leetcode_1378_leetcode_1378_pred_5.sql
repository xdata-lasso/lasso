-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Employees" ("id", "name") VALUES (1, 'Alice');
INSERT INTO "Employees" ("id", "name") VALUES (2, 'Bob');
INSERT INTO "Employees" ("id", "name") VALUES (3, 'Charlie');
INSERT INTO "EmployeeUNI" ("id", "unique_id") VALUES (1, 2);
INSERT INTO "EmployeeUNI" ("id", "unique_id") VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(2, 'Alice')
(None, 'Bob')
(1, 'Charlie')
*/

-- Prediction Query
SELECT EMPLOYEES.NAME, EMPLOYEEUNI.UNIQUE_ID FROM EMPLOYEES LEFT JOIN EMPLOYEEUNI ON EMPLOYEES.ID = EMPLOYEEUNI.ID;

/*
Prediction Result:
('Alice', 2)
('Bob', None)
('Charlie', 1)
*/