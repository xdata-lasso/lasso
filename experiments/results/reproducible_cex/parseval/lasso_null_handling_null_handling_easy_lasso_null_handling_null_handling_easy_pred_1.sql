-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483648, 'emp_4a6091', 'emp_85eada', 'emp_d60ebb', '5k5swwqcgs', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (2, 'emp_4a6091', 'emp_85eada', 'emp_d60ebb', '9n8', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (3, 'emp_4a6091', 'emp_85eada', 'emp_e0715c', '4', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483645, 'emp_4a6091', 'emp_85eada', NULL, 'gu7v', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483644, 'emp_4a6091', 'emp_85eada', 'emp_d60ebb', 'e4', 49999.99);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483643, 'emp_4a6091', NULL, 'emp_d60ebb', 'hria2ypuzhs', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483642, NULL, 'emp_85eada', 'emp_d60ebb', 'rwbbp6luhvd', 50000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
('emp_4a6091', 'emp_85eada')
('emp_4a6091', None)
(None, 'emp_85eada')
('emp_4a6091', 'emp_85eada')
('emp_4a6091', 'emp_85eada')
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE email IS NULL AND salary >= 50000;

/*
Prediction Result:
('emp_4a6091', 'emp_85eada')
*/