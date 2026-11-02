-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (6, '9', '9', '9', '9');
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (9, '9', '9', '9', '9');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (8, 9, '9', -1, '1000-01-10');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (7, 9, '9', -2, '1000-01-10');
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (11, 7, '9', 9, 9);
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (10, 8, '9', 9, 9);
INSERT INTO "Branches" ("branch_id", "branch_name", "location", "total_assets") VALUES (13, '9', '9', 9);
INSERT INTO "Branches" ("branch_id", "branch_name", "location", "total_assets") VALUES (12, '9', '9', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, SUM(balance) FROM Accounts GROUP BY customer_id;

/*
Gold Result:
(9, -3.0)
*/

-- Prediction Query
SELECT customer_id, MIN(balance) FROM Accounts GROUP BY customer_id;

/*
Prediction Result:
(9, -2.0)
*/