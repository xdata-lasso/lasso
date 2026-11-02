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
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'Checking', 1500.50, '2021-01-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (102, 2, 'Savings', 8200.00, '2022-03-25');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1001, 101, 'Deposit', 500.00, '2023-06-15 09:15:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1002, 101, 'Withdrawal', 120.00, '2023-06-15 17:45:30');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1003, 102, 'Deposit', 500.00, '2023-06-15 09:15:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1004, 102, 'Transfer', 1000.00, '2023-02-01 14:20:10');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1005, 101, 'Fee', 15.00, '2023-11-30 23:59:59');
INSERT INTO Branches (branch_id, branch_name, location, total_assets) VALUES (1, 'Downtown', 'New York', 5000000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DATE(transaction_date) FROM Transactions;

/*
Gold Result:
('2023-06-15',)
('2023-06-15',)
('2023-06-15',)
('2023-02-01',)
('2023-11-30',)
*/

-- Prediction Query
SELECT CAST(transaction_date AS REAL) FROM Transactions;

/*
Prediction Result:
(2023.0,)
(2023.0,)
(2023.0,)
(2023.0,)
(2023.0,)
*/