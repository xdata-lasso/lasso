-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice Smith', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'Checking', 1500.50, '2023-01-15');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 101, 'Deposit', 250.75, '2023-02-01 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (2, 101, 'Withdrawal', -120.25, '2023-02-02 14:30:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (3, 101, 'Fee', 0.0, '2023-02-03 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ABS(amount) FROM Transactions;

/*
Gold Result:
(250.75,)
(120.25,)
(0.0,)
*/

-- Prediction Query
SELECT ROUND(amount) FROM Transactions;

/*
Prediction Result:
(251.0,)
(-120.0,)
(0.0,)
*/