-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL account_type, empty string account_type, literal 'NULL' string account_type, and logical operator mutations (AND vs OR).
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (100, 'Eve', '202 St', '555-5555', 'eve@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (200, 'Frank', '303 St', '666-6666', 'frank@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (300, 'Grace', '404 St', '777-7777', 'grace@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (400, 'Heidi', '505 St', '888-8888', 'heidi@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (11, 100, NULL, 500.0, '2023-02-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (12, 200, NULL, -10.0, '2023-02-02');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (13, 300, '', 250.0, '2023-02-03');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (14, 400, 'NULL', 300.0, '2023-02-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND NOT account_type IS NULL;

/*
Gold Result:
(300,)
(400,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance > 0;

/*
Prediction Result:
(100,)
(300,)
(400,)
*/