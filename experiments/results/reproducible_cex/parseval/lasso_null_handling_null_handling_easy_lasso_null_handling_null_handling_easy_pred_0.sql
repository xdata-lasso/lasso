-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, department TEXT, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483648, 'emp_3643c0', 'emp_d9f615', 'emp_17582c', '5k5swwqcgs', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (2, 'emp_3643c0', 'emp_d9f615', 'emp_17582c', '9n8', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (3, 'emp_3643c0', 'emp_d9f615', 'emp_947786', '4', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483645, 'emp_3643c0', 'emp_d9f615', NULL, 'gu7v', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483644, 'emp_3643c0', 'emp_d9f615', 'emp_17582c', 'e4', 49999.99);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483643, 'emp_3643c0', NULL, 'emp_17582c', 'hria2ypuzhs', 50000.0);

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "department", "salary") VALUES (-2147483642, NULL, 'emp_d9f615', 'emp_17582c', 'rwbbp6luhvd', 50000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM Employees WHERE NOT email IS NULL AND salary >= 50000;

/*
Gold Result:
('emp_3643c0', 'emp_d9f615')
('emp_3643c0', None)
(None, 'emp_d9f615')
('emp_3643c0', 'emp_d9f615')
('emp_3643c0', 'emp_d9f615')
*/

-- Prediction Query
SELECT first_name, last_name FROM Employees WHERE salary >= 50000;

/*
Prediction Result:
('emp_3643c0', 'emp_d9f615')
('emp_3643c0', 'emp_d9f615')
('emp_3643c0', None)
(None, 'emp_d9f615')
('emp_3643c0', 'emp_d9f615')
('emp_3643c0', 'emp_d9f615')
*/