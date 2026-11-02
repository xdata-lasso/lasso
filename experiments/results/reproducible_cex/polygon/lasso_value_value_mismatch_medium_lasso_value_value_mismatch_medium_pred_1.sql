-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (8, 'checking_wrong17', 'checking_wrong17', 'checking_wrong17', 'checking_wrong17');
INSERT INTO "Customers" ("customer_id", "name", "address", "phone", "email") VALUES (9, 'checking_wrong17', 'checking_wrong17', 'checking_wrong17', 'checking_wrong17');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (20, 9, 'checking_wrong', 15, '1000-01-17');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (17, NULL, 'checking', NULL, NULL);
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (12, 17, 'checking_wrong17', 17, 17);
INSERT INTO "Transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (11, 17, 'checking_wrong17', 17, 17);
INSERT INTO "Branches" ("branch_id", "branch_name", "location", "total_assets") VALUES (14, 'checking_wrong17', 'checking_wrong17', 17);
INSERT INTO "Branches" ("branch_id", "branch_name", "location", "total_assets") VALUES (13, 'checking_wrong17', 'checking_wrong17', 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE account_type = 'checking';

/*
Gold Result:
(17,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE account_type = 'checking_wrong';

/*
Prediction Result:
(20,)
*/