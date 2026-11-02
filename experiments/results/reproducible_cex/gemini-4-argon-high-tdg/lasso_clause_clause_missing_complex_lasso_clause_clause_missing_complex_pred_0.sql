-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Dan Brown', '404 Elm St', '555-0201', 'dan@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (5, 1, 'Checking', 100.0, '2021-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (10, 1, 'Savings', 300.0, '2021-01-02');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (15, 1, 'Checking', 100.0, '2021-01-03');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (20, 1, 'Savings', 300.0, '2021-01-04');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (30, 1, 'Checking', 500.0, '2021-01-05');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 30, 'Deposit', 500.0, '2023-02-01 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (2, NULL, 'Deposit', 300.0, '2023-02-02 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (3, 20, 'Deposit', 300.0, '2023-02-03 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (4, 10, 'Deposit', 300.0, '2023-02-04 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (5, 15, 'Deposit', 100.0, '2023-02-05 09:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (6, 5, 'Deposit', 100.0, '2023-02-06 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Transactions GROUP BY account_id ORDER BY SUM(amount) DESC, account_id NULLS LAST LIMIT 5;

/*
Gold Result:
(30,)
(10,)
(20,)
(None,)
(5,)
*/

-- Prediction Query
SELECT account_id FROM Transactions GROUP BY account_id LIMIT 5;

/*
Prediction Result:
(None,)
(5,)
(10,)
(15,)
(20,)
*/