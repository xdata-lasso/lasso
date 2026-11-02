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
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 101, 'Checking', 500.0, '2022-01-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (2, 102, 'Checking', 1500.0, '2022-02-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (3, 103, 'Checking', 800.0, '2022-03-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (4, 103, 'Savings', 2000.0, '2022-01-05');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (5, 104, 'Savings', 5000.0, '2022-04-12');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (6, 101, 'Savings', 3000.0, '2022-05-18');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 5, 'Deposit', 2500.0, '2022-04-12 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (2, 5, 'Deposit', 2500.0, '2022-04-13 11:30:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (3, 1, 'Deposit', 500.0, '2022-01-10 09:15:00');
INSERT INTO Branches (branch_id, branch_name, location, total_assets) VALUES (1, 'Downtown', 'New York', 1000000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts AS a WHERE balance = (SELECT MAX(balance) FROM Accounts WHERE account_type = a.account_type);

/*
Gold Result:
(102,)
(104,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance = (SELECT MAX(balance) FROM Accounts);

/*
Prediction Result:
(104,)
*/