-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("id", "name") VALUES (1, 'e1__d055b5');

INSERT INTO "employees" ("id", "name") VALUES (2, 'e1__d055b5');

INSERT INTO "employees" ("id", "name") VALUES (3, 'emp_1db09c');

INSERT INTO "employees" ("id", "name") VALUES (4, NULL);

-- Inserting into table: employeeuni --
INSERT INTO "employeeuni" ("id", "unique_id") VALUES (1, 1);

INSERT INTO "employeeuni" ("id", "unique_id") VALUES (2, 1);

INSERT INTO "employeeuni" ("id", "unique_id") VALUES (3, 1);

INSERT INTO "employeeuni" ("id", "unique_id") VALUES (4, -2147483647);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(1, 'e1__d055b5')
(1, 'e1__d055b5')
(1, 'emp_1db09c')
(-2147483647, None)
*/

-- Prediction Query
SELECT T2.NAME, T1.UNIQUE_ID FROM ((SELECT ID, NAME FROM EMPLOYEES AS E2) AS T2 LEFT JOIN (SELECT ID, UNIQUE_ID FROM EMPLOYEEUNI AS E1) AS T1 ON T1.ID = T2.ID);

/*
Prediction Result:
('e1__d055b5', 1)
('e1__d055b5', 1)
('emp_1db09c', 1)
(None, -2147483647)
*/