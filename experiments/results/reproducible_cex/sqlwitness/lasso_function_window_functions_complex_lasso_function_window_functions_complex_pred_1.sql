-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, address, phone, email) VALUES (1, NULL, NULL, 'default2', 'default2'), (0, 'default1', 'default1', 'default1', 'default1'), (2, 'default2', 'default1', 'default1', 'default1'), (3, 'default2', NULL, 'default1', NULL);
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date) VALUES (0, NULL, 'default2', NULL, '2023-01-01'), (1, 3, 'default2', 1.0, NULL), (2, 1, NULL, NULL, NULL), (3, 1, NULL, NULL, NULL);
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (0, 2, 'default2', 1.0, '2023-01-01 00:00:00.000000'), (1, NULL, 'default2', 1.0, NULL), (2, 3, NULL, NULL, '2023-01-01 01:00:00.000000'), (3, 1, 'default1', 1.0, '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Gold Result:
(None, 1.0)
(1, 1.0)
(2, 1.0)
(3, None)
*/

-- Prediction Query
SELECT account_id, SUM(amount) OVER (ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Prediction Result:
(None, 1.0)
(2, 2.0)
(1, 3.0)
(3, 3.0)
*/