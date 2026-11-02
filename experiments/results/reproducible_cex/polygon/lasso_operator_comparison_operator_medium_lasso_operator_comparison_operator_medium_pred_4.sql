-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (18, '18', '18', '18', '18');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (9, 18, '14', -715, '1000-01-16');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (8, 18, '16', 0, '1000-01-18');
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (11, 8, '18', 18, 18);
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (10, 8, '18', 18, 18);
INSERT INTO "Branches" ("branch_id", "branch_name", "location", "total_assets") VALUES (13, '18', '18', 18);
INSERT INTO "Branches" ("branch_id", "branch_name", "location", "total_assets") VALUES (12, '18', '18', 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance <> 0;

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance <= 0;

/*
Prediction Result:
(18,)
(18,)
*/