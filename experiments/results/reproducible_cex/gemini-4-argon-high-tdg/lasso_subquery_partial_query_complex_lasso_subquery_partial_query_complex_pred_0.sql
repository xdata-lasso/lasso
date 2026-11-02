-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, customer_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id), FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (101, 'Alice Smith', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (102, 'Bob Jones', '456 Oak Ave', '555-0102', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (103, 'Charlie Brown', '789 Pine Rd', '555-0103', 'charlie@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (104, 'Diana Prince', '321 Elm St', '555-0104', 'diana@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (201, 101, 'Checking', 1500.00, '2022-01-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (202, 102, 'Savings', 3000.00, '2022-03-20');
INSERT INTO Transactions (transaction_id, account_id, customer_id, transaction_type, amount, transaction_date) VALUES (301, 201, 101, 'Deposit', 500.00, '2023-01-10 09:30:00');
INSERT INTO Transactions (transaction_id, account_id, customer_id, transaction_type, amount, transaction_date) VALUES (302, 202, 103, 'Deposit', 250.00, '2023-01-12 14:15:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts INTERSECT SELECT customer_id FROM Transactions;

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts;

/*
Prediction Result:
(101,)
(102,)
*/