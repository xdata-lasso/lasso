-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values for balance (> 0 vs >= 0, < 0, = 0, NULL) and NULL checks on account_type (IS NOT NULL vs IS NULL, AND vs OR).
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (101, 'Alice', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (102, 'Bob', '456 Oak St', '555-0102', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (103, 'Charlie', '789 Pine St', '555-0103', 'charlie@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (104, 'Diana', '321 Elm St', '555-0104', 'diana@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (105, 'Evan', '654 Cedar St', '555-0105', 'evan@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (106, 'Fiona', '987 Birch St', '555-0106', 'fiona@example.com');
-- Positive balance (small float), non-null account_type -> SHOULD MATCH
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 101, 'Savings', 0.01, '2023-01-01');
-- Zero balance, non-null account_type -> SHOULD NOT MATCH (catches balance >= 0)
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (2, 102, 'Checking', 0.0, '2023-01-02');
-- Negative balance, non-null account_type -> SHOULD NOT MATCH (catches balance != 0 or missing balance check)
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (3, 103, 'Checking', -50.5, '2023-01-03');
-- Positive balance, NULL account_type -> SHOULD NOT MATCH (catches missing account_type check, IS NULL instead of IS NOT NULL, or OR instead of AND)
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (4, 104, NULL, 500.0, '2023-01-04');
-- NULL balance, non-null account_type -> SHOULD NOT MATCH
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (5, 105, 'Savings', NULL, '2023-01-05');
-- Zero balance, NULL account_type -> SHOULD NOT MATCH
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (6, 106, NULL, 0.0, '2023-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND NOT account_type IS NULL;

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance > 0;

/*
Prediction Result:
(101,)
(104,)
*/