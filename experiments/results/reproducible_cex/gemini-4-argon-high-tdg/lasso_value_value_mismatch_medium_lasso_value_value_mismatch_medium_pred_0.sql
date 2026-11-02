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
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 101, 'checking', 1500.75, '2022-01-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (2, 101, 'checking', 0.0, '2022-06-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (3, 101, 'checking', -45.50, '2023-03-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (4, 102, 'savings', 5000.00, '2021-11-01');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1001, 1, 'deposit', 1000.00, '2022-01-15 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1002, 1, 'deposit', 500.75, '2022-02-01 14:30:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1003, 4, 'withdrawal', 200.00, '2022-05-10 11:15:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE account_type = 'checking';

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE account_type = 'savings';

/*
Prediction Result:
(4,)
*/