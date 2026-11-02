-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic pattern matching, substring vs suffix (%@gmail.com vs %@gmail.com%), missing '@' (%gmail.com), and exact match (@gmail.com)
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice Smith', '123 Main St', '555-0101', 'alice@gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob Jones', '456 Oak Ave', '555-0102', 'bob@yahoo.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Charlie Brown', '789 Pine Rd', '555-0103', 'charlie@gmail.com.uk');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (4, 'David Wilson', '321 Elm St', '555-0104', 'david.gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (5, 'Eve Davis', '654 Maple Dr', '555-0105', '@gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (6, 'Frank Miller', '987 Cedar Ln', '555-0106', 'frank@sub.gmail.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Customers WHERE email LIKE '%@gmail.com';

/*
Gold Result:
('Alice Smith',)
('Eve Davis',)
*/

-- Prediction Query
SELECT name FROM Customers CROSS JOIN Transactions WHERE email LIKE '%@gmail.com';

/*
Prediction Result:
*/