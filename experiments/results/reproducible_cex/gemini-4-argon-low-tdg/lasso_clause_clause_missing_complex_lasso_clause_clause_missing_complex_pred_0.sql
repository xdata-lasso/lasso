-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Bob Jones', '456 Oak Ave', '555-0202', 'bob@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (10, 1, 'Checking', 1000.0, '2023-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (20, 1, 'Savings', 1000.0, '2023-01-02');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (30, 1, 'Checking', 1000.0, '2023-01-03');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (40, 1, 'Savings', 1000.0, '2023-01-04');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (50, 1, 'Checking', 1000.0, '2023-01-05');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 30, 'Deposit', 500.0, '2023-03-01 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (2, 10, 'Deposit', 500.0, '2023-03-02 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (3, 20, 'Deposit', 500.0, '2023-03-03 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (4, NULL, 'Fee', 500.0, '2023-03-04 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (5, 50, 'Deposit', 200.0, '2023-03-05 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (6, 40, 'Deposit', 100.0, '2023-03-06 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Transactions GROUP BY account_id ORDER BY SUM(amount) DESC, account_id NULLS LAST LIMIT 5;

/*
Gold Result:
(10,)
(20,)
(30,)
(None,)
(50,)
*/

-- Prediction Query
SELECT account_id FROM Transactions GROUP BY account_id LIMIT 5;

/*
Prediction Result:
(None,)
(10,)
(20,)
(30,)
(40,)
*/