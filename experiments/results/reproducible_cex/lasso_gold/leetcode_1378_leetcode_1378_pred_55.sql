-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "name") VALUES (1001, 'Allison Hill');
INSERT INTO "employees" ("id", "name") VALUES (1004, 'Allison Hill');
INSERT INTO "employeeuni" ("id", "unique_id") VALUES (1001, 1002);
INSERT INTO "employeeuni" ("id", "unique_id") VALUES (1001, 1005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(1002, 'Allison Hill')
(1005, 'Allison Hill')
(None, 'Allison Hill')
*/

-- Prediction Query
SELECT NAME, UNIQUE_ID FROM EMPLOYEES AS E LEFT JOIN EMPLOYEEUNI AS E1 ON E.ID = E1.ID;

/*
Prediction Result:
('Allison Hill', 1002)
('Allison Hill', 1005)
('Allison Hill', None)
*/