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
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (10, 1, 'checking', 500.0, '2022-01-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (20, 2, 'savings', 5000.0, '2022-02-20');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (101, 10, 'withdrawal', 1500.0, '2023-03-01 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (102, 10, 'withdrawal', 1000.0, '2023-03-02 11:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (103, 10, 'withdrawal', 999.99, '2023-03-03 12:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (104, 10, 'withdrawal', 1000.01, '2023-03-04 13:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (105, 10, 'deposit', 2000.0, '2023-03-05 14:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (106, 20, 'withdrawal', 2000.0, '2023-03-06 15:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (107, 20, 'deposit', 2000.0, '2023-03-07 16:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (108, 10, 'deposit', 500.0, '2023-03-08 17:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (109, 20, 'withdrawal', 500.0, '2023-03-09 18:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (110, 20, 'deposit', 500.0, '2023-03-10 19:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking' AND t.transaction_type = 'withdrawal';

/*
Gold Result:
(101,)
(104,)
*/

-- Prediction Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking';

/*
Prediction Result:
(101,)
(104,)
(105,)
*/