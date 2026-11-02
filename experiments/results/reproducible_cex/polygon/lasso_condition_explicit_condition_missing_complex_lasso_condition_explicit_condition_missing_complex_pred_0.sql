-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (14, 'checking26', 'checking26', 'checking26', 'checking26');
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (27, 'checking26', 'checking26', 'checking26', 'checking26');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (26, 27, 'checking', 28, '1000-01-30');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (15, 14, 'checking26', 26, '1000-01-27');
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (30, 26, 'checking24', 1001, 25);
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (16, NULL, 'checking26', 26, 26);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking' AND t.transaction_type = 'withdrawal';

/*
Gold Result:
*/

-- Prediction Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking';

/*
Prediction Result:
(30,)
*/