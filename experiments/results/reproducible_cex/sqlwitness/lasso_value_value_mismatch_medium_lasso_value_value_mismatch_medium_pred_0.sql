-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, address, phone, email) VALUES (0, 'default2', 'default2', 'savings', 'default1'), (1, NULL, 'savings', 'savings', 'default2'), (2, 'savings', 'default2', 'default2', 'default2'), (3, 'default2', 'default1', 'default1', 'default2'), (4, 'default1', 'default2', 'default2', 'default2'), (5, 'checking', 'checking', 'savings', NULL);
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 3, 'savings', NULL, '2023-01-02'), (0, 3, 'checking', 1.0, '2023-01-02'), (2, 1, NULL, 0.0, '2023-01-02'), (3, 3, 'default2', NULL, '2023-01-01'), (4, 1, 'default2', 1.0, NULL), (5, 5, 'default2', NULL, NULL), (6, 4, 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE account_type = 'checking';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE account_type = 'savings';

/*
Prediction Result:
(1,)
*/