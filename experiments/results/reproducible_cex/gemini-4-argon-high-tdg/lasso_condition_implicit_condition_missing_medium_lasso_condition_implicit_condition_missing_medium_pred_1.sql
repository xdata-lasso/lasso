-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (101, 'Alice Smith', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (102, 'Bob Jones', '456 Oak Ave', '555-0102', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (103, 'Charlie Brown', '789 Pine Rd', '555-0103', 'charlie@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (104, 'Diana Prince', '321 Elm St', '555-0104', 'diana@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (105, 'Evan Wright', '654 Cedar Ln', '555-0105', 'evan@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (106, 'Fiona Gallagher', '987 Birch Blvd', '555-0106', 'fiona@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 101, 'Checking', 150.75, '2023-01-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (2, 102, 'Savings', 0.0, '2023-02-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (3, 103, 'Checking', -45.50, '2023-03-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (4, 104, NULL, 300.00, '2023-04-25');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (5, 105, NULL, -10.00, '2023-05-30');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (6, 106, 'Savings', NULL, '2023-06-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND NOT account_type IS NULL;

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND account_type IS NULL;

/*
Prediction Result:
(104,)
*/