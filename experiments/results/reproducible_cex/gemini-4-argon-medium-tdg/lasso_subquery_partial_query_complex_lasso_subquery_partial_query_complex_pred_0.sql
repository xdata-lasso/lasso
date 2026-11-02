-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, customer_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id), FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice', '123 Main St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob', '456 Oak Ave', '555-0102', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Charlie', '789 Pine Rd', '555-0103', 'charlie@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (4, 'Diana', '321 Elm St', '555-0104', 'diana@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'Savings', 1500.0, '2023-01-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (102, 2, 'Checking', 500.0, '2023-02-15');
INSERT INTO Transactions (transaction_id, account_id, customer_id, transaction_type, amount, transaction_date) VALUES (1001, 101, 1, 'Deposit', 200.0, '2023-03-01 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, customer_id, transaction_type, amount, transaction_date) VALUES (1002, 102, 3, 'Withdrawal', 50.0, '2023-03-02 11:30:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts INTERSECT SELECT customer_id FROM Transactions;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts;

/*
Prediction Result:
(1,)
(2,)
*/