-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("id", "name") VALUES (10, NULL);
INSERT INTO "Employees" ("id", "name") VALUES (20, '22');
INSERT INTO "EmployeeUNI" ("id", "unique_id") VALUES (10, 12);
INSERT INTO "EmployeeUNI" ("id", "unique_id") VALUES (10, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(11, None)
(12, None)
(None, '22')
*/

-- Prediction Query
SELECT EMPLOYEES.NAME, EMPLOYEEUNI.UNIQUE_ID FROM EMPLOYEES LEFT JOIN EMPLOYEEUNI ON EMPLOYEES.ID = EMPLOYEEUNI.ID;

/*
Prediction Result:
(None, 11)
(None, 12)
('22', None)
*/