-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, department_id INTEGER);

CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, manager_id INTEGER, FOREIGN KEY (manager_id) REFERENCES Employees (employee_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employees" ("employee_id", "first_name", "department_id") VALUES (1045, 'James', 1041);
INSERT INTO "employees" ("employee_id", "first_name", "department_id") VALUES (1040, 'Debra', 1048.0);
INSERT INTO "employees" ("employee_id", "first_name", "department_id") VALUES (1044, 'Debra', 1048.0);
INSERT INTO "employees" ("employee_id", "first_name", "department_id") VALUES (1048, 'Amy', 1046);
INSERT INTO "departments" ("department_id", "manager_id") VALUES (1047, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE NOT employee_id IN (SELECT manager_id FROM Departments WHERE NOT manager_id IS NULL);

/*
Gold Result:
('Debra',)
('Debra',)
('James',)
('Amy',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE NOT employee_id IN (SELECT manager_id FROM Departments);

/*
Prediction Result:
*/