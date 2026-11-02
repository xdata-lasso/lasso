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
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'checking', 1500.50, '2022-01-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (102, 2, 'savings', 3200.00, '2022-03-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (103, 1, NULL, 0.00, '2022-05-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (104, 2, 'credit', -250.75, '2022-07-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE account_type = 'checking';

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE account_type = 'savings';

/*
Prediction Result:
(102,)
*/