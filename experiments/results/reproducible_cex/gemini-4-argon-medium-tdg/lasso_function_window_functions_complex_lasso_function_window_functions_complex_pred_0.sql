-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Charlie Brown', '789 Pine St', '555-0103', 'charlie@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (201, 1, 'Checking', 300.0, '2023-02-01');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 201, 'Deposit', 10.5, '2023-02-10 12:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (2, 201, 'Deposit', 20.25, '2023-02-10 12:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (3, 201, 'Deposit', 10.5, '2023-02-11 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Gold Result:
(201, 10.5)
(201, 30.75)
(201, 41.25)
*/

-- Prediction Query
SELECT account_id, SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date) FROM Transactions;

/*
Prediction Result:
(201, 30.75)
(201, 30.75)
(201, 41.25)
*/