-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard duplicate elimination, NULL handling in COUNT(DISTINCT), and JOIN multiplication / orphan row filtering
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice Smith', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob Jones', '456 Oak Ave', '555-0102', 'bob@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'Checking', 1500.00, '2023-01-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (102, 1, 'Checking', 250.50, '2023-02-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (103, 2, 'Savings', 0.00, '2023-03-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (104, 2, NULL, -50.00, '2023-04-25');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (105, NULL, 'Investment', 10000.00, '2023-05-30');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1001, 101, 'Deposit', 500.00, '2023-01-11 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1002, 101, 'Withdrawal', 100.00, '2023-01-12 14:30:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1003, 103, 'Transfer', 50.00, '2023-03-21 11:15:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT account_type) FROM Accounts;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(account_type) FROM Accounts;

/*
Prediction Result:
(4,)
*/