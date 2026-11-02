-- Schema DDL
CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone_number TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (-2147483648, '5k5swwqcgs', '9n8', 'emp_90e268', '4');

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (2, 'gu7v', 'e4', 'emp_90e268', 'hria2ypuzhs');

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (3, 'rwbbp6luhvd', 'tti', 'emp_90e268', 'bnp');

INSERT INTO "employees" ("employee_id", "first_name", "last_name", "email", "phone_number") VALUES (-2147483645, 'mdpos', 'ie5', NULL, 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email FROM Employees;

/*
Gold Result:
('emp_90e268',)
(None,)
('emp_90e268',)
('emp_90e268',)
*/

-- Prediction Query
SELECT last_name FROM Employees;

/*
Prediction Result:
('9n8',)
('ie5',)
('e4',)
('tti',)
*/