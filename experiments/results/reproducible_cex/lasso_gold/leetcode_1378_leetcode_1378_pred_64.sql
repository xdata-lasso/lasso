-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("id", "name") VALUES (0, 'Ethan Adams');
INSERT INTO "employees" ("id", "name") VALUES (1107, 'Ethan Adams');
INSERT INTO "employees" ("id", "name") VALUES (-1, 'Patty Perez');
INSERT INTO "employees" ("id", "name") VALUES (1112, 'Patty Perez');
INSERT INTO "employeeuni" ("id", "unique_id") VALUES (0, 1105);
INSERT INTO "employeeuni" ("id", "unique_id") VALUES (0, 1108);
INSERT INTO "employeeuni" ("id", "unique_id") VALUES (-1, 1105);
INSERT INTO "employeeuni" ("id", "unique_id") VALUES (-1, 1113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(1105, 'Patty Perez')
(1113, 'Patty Perez')
(1105, 'Ethan Adams')
(1108, 'Ethan Adams')
(None, 'Ethan Adams')
(None, 'Patty Perez')
*/

-- Prediction Query
SELECT UNIQUE_ID, NAME FROM EMPLOYEES LEFT JOIN EMPLOYEEUNI ON IIF(EMPLOYEES.ID = EMPLOYEEUNI.ID, EMPLOYEES.ID, NULL);

/*
Prediction Result:
(1105, 'Patty Perez')
(1113, 'Patty Perez')
(None, 'Ethan Adams')
(None, 'Ethan Adams')
(None, 'Patty Perez')
*/