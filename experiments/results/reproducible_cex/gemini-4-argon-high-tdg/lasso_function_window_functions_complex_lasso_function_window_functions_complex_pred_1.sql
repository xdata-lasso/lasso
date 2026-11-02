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
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'Checking', 650.0, '2022-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (102, 2, 'Savings', 1200.0, '2022-02-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (103, 1, 'Savings', 0.0, '2022-03-01');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 101, 'Deposit', 300.0, '2023-01-15 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (2, 101, 'Deposit', 100.0, '2023-01-05 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (3, 101, 'Deposit', 250.0, '2023-01-10 14:30:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (4, 102, 'Deposit', 800.0, '2023-01-12 11:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (5, 102, 'Deposit', 400.0, '2023-01-08 16:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Gold Result:
(101, 100.0)
(101, 350.0)
(101, 650.0)
(102, 400.0)
(102, 1200.0)
*/

-- Prediction Query
SELECT account_id, SUM(amount) OVER (ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Prediction Result:
(101, 100.0)
(102, 500.0)
(101, 750.0)
(102, 1550.0)
(101, 1850.0)
*/