-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Alice Smith', '123 Maple St', '555-0101', 'alice@gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'Bob Jones', '456 Oak St', '555-0102', 'bob@yahoo.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Charlie Brown', '789 Pine St', '555-0103', 'charlie@gmail.com.org');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (4, 'Diana Prince', '101 Birch St', '555-0104', 'diana@mygmail.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Customers WHERE email LIKE '%@gmail.com';

/*
Gold Result:
('Alice Smith',)
*/

-- Prediction Query
SELECT c.name FROM Customers AS c JOIN Accounts AS a ON c.customer_id = a.customer_id WHERE c.email LIKE '%@gmail.com';

/*
Prediction Result:
*/