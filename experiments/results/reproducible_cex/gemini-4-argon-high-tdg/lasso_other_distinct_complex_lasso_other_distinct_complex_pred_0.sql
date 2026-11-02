-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice Smith', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob Jones', '456 Oak Ave', '555-0102', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Charlie Kim', '789 Pine Rd', '555-0103', 'charlie@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 1, 'Checking', 0.0, '2020-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (2, 1, 'Checking', 100.5, '2021-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (3, 1, 'Savings', 100.5, '2022-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (4, 1, 'Savings', 5000.0, '2023-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (5, 1, 'Savings', 5000.0, '2023-01-01');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 1, 'Deposit', 50.0, '2020-01-02 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (2, 1, 'Withdrawal', 20.0, '2020-01-03 11:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (3, 1, 'Transfer', 30.0, '2020-01-04 12:00:00');
INSERT INTO Branches (branch_id, branch_name, location, total_assets) VALUES (1, 'Downtown', 'New York', 1000000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT account_type) FROM Accounts;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(account_type) FROM Accounts;

/*
Prediction Result:
(5,)
*/