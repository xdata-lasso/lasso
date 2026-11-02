-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, address, phone, email) VALUES (1, NULL, NULL, 'default2', 'default2'), (0, 'default1', 'default1', 'default1', 'default2'), (2, 'default1', 'default1', NULL, NULL), (3, 'default1', NULL, 'default1', 'default1'), (4, 'default1', 'default1', NULL, NULL);
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, 2, NULL, 0.0, '2023-01-02'), (0, 4, NULL, 0.0, '2023-01-01'), (2, 3, NULL, 1.0, '2023-01-01'), (3, 4, 'default2', NULL, NULL), (4, 2, NULL, NULL, '2023-01-02'), (5, 1, 'default1', 1.0, '2023-01-01');
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 3, 'default1', 1.0, NULL), (0, 2, 'default1', 0.0, '2023-01-01 01:00:00.000000'), (2, 3, 'default2', 1.0, NULL), (3, NULL, 'default1', 1.0, '2023-01-01 01:00:00.000000'), (4, 3, NULL, 1.0, '2023-01-01 00:00:00.000000'), (5, 2, 'default2', 0.0, '2023-01-01 00:00:00.000000'), (6, NULL, 'default2', 0.0, NULL), (7, 3, 'default1', 0.0, '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Gold Result:
(None, 0.0)
(None, 1.0)
(2, 0.0)
(2, 0.0)
(3, 1.0)
(3, 2.0)
(3, 3.0)
(3, 3.0)
*/

-- Prediction Query
SELECT account_id, SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date) FROM Transactions;

/*
Prediction Result:
(None, 0.0)
(None, 1.0)
(2, 0.0)
(2, 0.0)
(3, 2.0)
(3, 2.0)
(3, 3.0)
(3, 3.0)
*/