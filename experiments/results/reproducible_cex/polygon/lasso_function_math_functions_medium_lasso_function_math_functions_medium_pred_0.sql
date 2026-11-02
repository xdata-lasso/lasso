-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (6, '6', '6', '6', '6');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (7, 6, '6', 6, '1000-01-07');
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (6, 7, '6', -550, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ABS(amount) FROM Transactions;

/*
Gold Result:
(550.0,)
*/

-- Prediction Query
SELECT amount FROM Transactions;

/*
Prediction Result:
(-550.0,)
*/