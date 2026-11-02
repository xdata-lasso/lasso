-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core aggregation test:
-- 1. Customers with multiple accounts (tests GROUP BY vs no GROUP BY).
-- 2. Duplicate balances for the same customer (tests SUM vs SUM(DISTINCT)).
-- 3. Different balances (tests SUM vs AVG, MIN, MAX, COUNT).
-- 4. Customer with 0 accounts (tests Accounts-only query vs LEFT JOIN Customers).
-- 5. Multiple transactions per account (tests spurious JOIN with Transactions which would multiply balances).
-- 6. Various account types and negative/zero balances (tests spurious WHERE filters).
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice', '123 Maple St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob', '456 Oak St', '555-0102', 'bob@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Charlie', '789 Pine St', '555-0103', 'charlie@example.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (4, 'David', '101 Birch St', '555-0104', 'david@example.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (101, 1, 'Checking', 100.50, '2023-01-10');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (102, 1, 'Savings', 100.50, '2023-02-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (103, 1, 'Checking', 250.25, '2023-03-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (104, 2, 'Savings', -50.00, '2023-01-05');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (105, 2, 'Checking', 0.00, '2023-04-12');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (106, 2, 'Savings', 200.00, '2023-05-18');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (107, 3, 'Checking', 500.00, '2023-06-01');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1001, 101, 'Deposit', 50.00, '2023-01-11 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1002, 101, 'Deposit', 50.50, '2023-01-12 11:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1003, 104, 'Withdrawal', 50.00, '2023-01-06 09:30:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, SUM(balance) FROM Accounts GROUP BY customer_id;

/*
Gold Result:
(1, 451.25)
(2, 150.0)
(3, 500.0)
*/

-- Prediction Query
SELECT customer_id, AVG(balance) FROM Accounts GROUP BY customer_id;

/*
Prediction Result:
(1, 150.41666666666666)
(2, 50.0)
(3, 500.0)
*/