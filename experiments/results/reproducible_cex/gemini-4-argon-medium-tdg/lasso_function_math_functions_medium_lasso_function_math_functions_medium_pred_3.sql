-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice Smith', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (10, 1, 'Checking', -500.75, '2023-01-15');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (101, 10, 'Withdrawal', -150.25, '2023-02-01 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (102, 10, 'Deposit', 150.25, '2023-02-02 11:30:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (103, 10, 'Deposit', 150.25, '2023-02-03 12:45:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (104, 10, 'Fee', -0.99, '2023-02-04 09:15:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (105, 10, 'Adjustment', 0.0, '2023-02-05 14:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ABS(amount) FROM Transactions;

/*
Gold Result:
(150.25,)
(150.25,)
(150.25,)
(0.99,)
(0.0,)
*/

-- Prediction Query
SELECT FLOOR(amount) FROM Transactions;

/*
Prediction Result:
(-151.0,)
(150.0,)
(150.0,)
(-1.0,)
(0.0,)
*/