-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic partitioning by account_type, MIN vs MAX, and uncorrelated subquery mutants.
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice', '101 Main St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob', '102 Main St', '555-0102', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Charlie', '103 Main St', '555-0103', 'charlie@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (4, 'Diana', '104 Main St', '555-0104', 'diana@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (10, 1, 'Savings', 500.0, '2023-01-01');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (20, 2, 'Savings', 100.0, '2023-01-02');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (30, 3, 'Checking', 200.0, '2023-01-03');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (40, 4, 'Checking', 50.0, '2023-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts AS a WHERE balance = (SELECT MAX(balance) FROM Accounts WHERE account_type = a.account_type);

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance = (SELECT MAX(balance) FROM Accounts);

/*
Prediction Result:
(1,)
*/