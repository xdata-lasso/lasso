-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Zack Morris', '101 Bayside Ln', '555-0101', 'zack@gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Alice Smith', '202 Oak Ave', '555-0102', 'alice@yahoo.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Zack Morris', '303 Pine Rd', '555-0103', 'zack.m@gmail.com');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (10, 2, 'Checking', 1500.00, '2022-01-15');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (11, 3, 'Savings', 3000.50, '2022-03-20');
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES (12, 3, 'Checking', 500.00, '2022-04-10');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (100, 10, 'Deposit', 500.00, '2022-02-01 10:00:00');
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (101, 11, 'Deposit', 1000.00, '2022-03-25 14:30:00');
INSERT INTO Branches (branch_id, branch_name, location, total_assets) VALUES (1, 'Downtown', 'New York', 5000000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Customers WHERE email LIKE '%@gmail.com';

/*
Gold Result:
('Zack Morris',)
('Zack Morris',)
*/

-- Prediction Query
SELECT name FROM Customers CROSS JOIN Transactions WHERE email LIKE '%@gmail.com';

/*
Prediction Result:
('Zack Morris',)
('Zack Morris',)
('Zack Morris',)
('Zack Morris',)
*/