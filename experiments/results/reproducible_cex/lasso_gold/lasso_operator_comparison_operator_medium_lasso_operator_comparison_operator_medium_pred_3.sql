-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1001, 'Allison Hill', '819 Johnson Course
East William, AK 74064', '886.737.9402', 'eric51@example.org');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1002, 1001, 'husband', -1.0, '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance <> 0;

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance >= 0;

/*
Prediction Result:
*/