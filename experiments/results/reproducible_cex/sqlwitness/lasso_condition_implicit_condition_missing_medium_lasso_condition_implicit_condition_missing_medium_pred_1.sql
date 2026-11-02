-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, address, phone, email) VALUES (-1, NULL, 'default1', NULL, 'default2');
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, NULL, 'default1', NULL, '2023-01-02'), (0, -1, 'default2', NULL, NULL), (-1, NULL, 'default1', 1.0, '2023-01-02'), (2, -1, 'default1', NULL, '2023-01-01'), (3, NULL, 'default2', 0.0, NULL), (4, -1, NULL, 0.0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND NOT account_type IS NULL;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND account_type IS NULL;

/*
Prediction Result:
*/