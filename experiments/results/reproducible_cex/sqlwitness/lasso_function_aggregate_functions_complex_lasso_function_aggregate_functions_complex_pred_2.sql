-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, address, phone, email) VALUES (1, 'default1', 'default1', NULL, 'default1'), (0, 'default1', 'default2', 'default1', NULL), (2, 'default2', 'default1', 'default1', 'default2'), (3, 'default2', 'default1', 'default2', NULL);
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date) VALUES (0, 0, 'default1', 0.0, '2023-01-02'), (1, 1, NULL, 0.0, '2023-01-02'), (2, 1, NULL, NULL, '2023-01-01'), (3, NULL, NULL, 0.0, '2023-01-02'), (4, 1, 'default1', 1.0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, SUM(balance) FROM Accounts GROUP BY customer_id;

/*
Gold Result:
(None, 0.0)
(0, 0.0)
(1, 1.0)
*/

-- Prediction Query
SELECT customer_id, AVG(balance) FROM Accounts GROUP BY customer_id;

/*
Prediction Result:
(None, 0.0)
(0, 0.0)
(1, 0.5)
*/