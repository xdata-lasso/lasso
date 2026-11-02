-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, address, phone, email) VALUES (0, 'default1', 'default2', NULL, 'default1'), (1, 'default1', 'default1', '%@gmail.com', 'default1'), (2, '%@gmail.com', 'default1', 'default1', '%@gmail.com');
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (0, NULL, NULL, NULL, '2023-01-01 00:00:00.000000'), (1, NULL, NULL, 0.0, '2023-01-01 00:00:00.000000'), (2, NULL, 'default2', 0.0, '2023-01-01 00:00:00.000000'), (3, NULL, '%@gmail.com', 0.0, '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Customers WHERE email LIKE '%@gmail.com';

/*
Gold Result:
('%@gmail.com',)
*/

-- Prediction Query
SELECT name FROM Customers CROSS JOIN Transactions WHERE email LIKE '%@gmail.com';

/*
Prediction Result:
('%@gmail.com',)
('%@gmail.com',)
('%@gmail.com',)
('%@gmail.com',)
*/