-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core test: Duplicates in account_type, NULLs in account_type, NULL customer_id, negative/zero balances, and accounts with zero or multiple transactions.
-- Gold Query returns 2 ('Savings', 'Checking').
-- Kills: COUNT(*), COUNT(account_type), COUNT(DISTINCT account_id), COUNT(DISTINCT customer_id), GROUP BY account_type without outer count, INNER JOIN Customers, INNER JOIN Transactions, WHERE balance > 0.
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice Smith', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob Jones', '456 Oak Ave', '555-0102', 'bob@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'Savings', 1500.00, '2022-01-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (102, 1, 'Savings', 2500.50, '2022-03-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (103, 2, 'Checking', 0.00, '2022-05-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (104, NULL, 'Checking', -50.00, '2022-07-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (105, 2, NULL, 500.00, '2022-08-12');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1001, 101, 'Deposit', 500.00, '2022-01-15 10:30:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1002, 101, 'Withdrawal', 100.00, '2022-01-20 14:00:00');
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
(4,)
*/