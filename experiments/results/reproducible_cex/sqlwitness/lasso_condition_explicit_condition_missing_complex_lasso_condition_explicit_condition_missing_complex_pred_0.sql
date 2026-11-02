-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, address, phone, email) VALUES (1001, 'withdrawal', 'default2', 'default1', 'withdrawal'), (1000, 'default2', 'withdrawal', 'default2', NULL), (0, NULL, NULL, NULL, 'default1'), (999, 'checking', 'default1', 'checking', 'checking'), (1, 'default2', 'checking', 'default1', 'default2'), (2, NULL, 'withdrawal', 'checking', 'default2'), (3, 'default2', 'withdrawal', 'checking', NULL), (4, 'default1', NULL, NULL, NULL), (5, NULL, 'withdrawal', 'default1', NULL), (6, 'default2', 'checking', 'checking', 'withdrawal'), (7, 'default1', NULL, 'withdrawal', 'default1'), (8, NULL, 'default2', 'default2', 'checking'), (9, 'default1', 'withdrawal', 'withdrawal', 'default1'), (10, 'withdrawal', 'default1', 'withdrawal', NULL), (11, 'default2', 'default1', 'checking', 'withdrawal'), (12, 'default1', 'checking', 'default2', 'checking'), (13, 'checking', 'checking', 'default2', 'checking'), (14, 'default1', NULL, 'withdrawal', 'checking'), (15, 'withdrawal', 'default1', 'default2', 'default1'), (16, 'default1', 'default2', 'withdrawal', 'withdrawal'), (17, 'default2', NULL, NULL, 'default2');
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date) VALUES (999, 1001, 'checking', 1001.0, '2023-01-02'), (1, 1, 'checking', 1001.0, '2023-01-01'), (1001, 4, 'default2', 0.0, NULL), (0, 10, 'default1', 999.0, '2023-01-02'), (1000, 17, 'default2', 1001.0, NULL), (2, 17, 'default2', 1.0, '2023-01-02'), (3, 13, 'default1', NULL, NULL), (4, 16, 'checking', NULL, NULL);
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1000, 999, NULL, 1.0, '2023-01-01 00:00:00.000000'), (1, 999, NULL, 1.0, '2023-01-01 01:00:00.000000'), (0, 4, 'default1', NULL, '2023-01-01 01:00:00.000000'), (999, 999, 'withdrawal', 0.0, '2023-01-01 00:00:00.000000'), (1001, 1, NULL, 999.0, NULL), (2, 1, 'withdrawal', 0.0, '2023-01-01 00:00:00.000000'), (3, 1, NULL, 0.0, '2023-01-01 00:00:00.000000'), (4, 3, 'checking', 1000.0, '2023-01-01 00:00:00.000000'), (5, 1001, NULL, 0.0, NULL), (6, 0, 'withdrawal', NULL, '2023-01-01 01:00:00.000000'), (7, 4, NULL, 1001.0, NULL), (8, 4, 'withdrawal', 1001.0, '2023-01-01 00:00:00.000000'), (9, 3, 'default2', 1.0, NULL), (10, 999, 'withdrawal', 999.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking' AND t.transaction_type = 'withdrawal';

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking';

/*
Prediction Result:
(7,)
(8,)
*/