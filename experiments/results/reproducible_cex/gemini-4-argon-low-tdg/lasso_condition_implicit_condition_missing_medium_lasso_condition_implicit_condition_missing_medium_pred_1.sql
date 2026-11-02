-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive, zero, negative, and NULL balance boundaries with valid account_type, plus duplicate customer_id (DISTINCT mutation) and different account_id vs customer_id.
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (10, 'Alice', '123 St', '111-1111', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (20, 'Bob', '456 St', '222-2222', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (30, 'Charlie', '789 St', '333-3333', 'charlie@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (40, 'Diana', '101 St', '444-4444', 'diana@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 10, 'Checking', 100.50, '2023-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (2, 10, 'Savings', 0.01, '2023-01-02');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (3, 20, 'Checking', 0.0, '2023-01-03');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (4, 30, 'Savings', -50.25, '2023-01-04');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (5, 40, 'Checking', NULL, '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND NOT account_type IS NULL;

/*
Gold Result:
(10,)
(10,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND account_type IS NULL;

/*
Prediction Result:
*/