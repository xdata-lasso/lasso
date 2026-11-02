-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date) VALUES (1, NULL, 'default1', 4.0, '2023-01-01'), (5, NULL, 'default2', 4.0, NULL);
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (5, 5, 'default2', 6.0, '2023-01-01 00:00:00.000000'), (0, 5, 'default2', 1.0, '2023-01-01 00:00:00.000000'), (4, 1, NULL, 4.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Transactions GROUP BY account_id ORDER BY SUM(amount) DESC, account_id NULLS LAST LIMIT 5;

/*
Gold Result:
(5,)
(1,)
*/

-- Prediction Query
SELECT account_id FROM Transactions GROUP BY account_id LIMIT 5;

/*
Prediction Result:
(1,)
(5,)
*/