-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1006, 'Gregory Baker', '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', '664-375-2553', 'amandasanchez@example.com');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1007, 1006, 'hundred', 1008.5, '1972-03-03');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1009, 1007, 'expect', -10.234, '1973-04-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ABS(amount) FROM Transactions;

/*
Gold Result:
(10.234,)
*/

-- Prediction Query
SELECT amount FROM Transactions;

/*
Prediction Result:
(-10.234,)
*/