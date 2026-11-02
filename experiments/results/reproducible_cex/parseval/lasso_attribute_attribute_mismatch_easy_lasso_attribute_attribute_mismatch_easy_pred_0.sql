-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (-2147483648, '5k5swwqcgs', '9n8', 'emp_27fd57', '4');

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (2, 'gu7v', 'e4', 'emp_27fd57', 'hria2ypuzhs');

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (3, 'rwbbp6luhvd', 'tti', 'emp_27fd57', 'bnp');

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (-2147483645, 'mdpos', 'ie5', NULL, 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('emp_27fd57',)
(None,)
('emp_27fd57',)
('emp_27fd57',)
*/

-- Prediction Query
SELECT phone_number FROM Employees;

/*
Prediction Result:
('4',)
('nw6klf',)
('hria2ypuzhs',)
('bnp',)
*/