-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v');

-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1, -2147483648, 'checking', 86.520366, '2020-09-26');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (2, -2147483648, 'acc_0550ea', 165.344793, '2023-03-15');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (3, -2147483648, NULL, 357.862717, '2022-12-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE account_type = 'checking';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE account_type = 'savings';

/*
Prediction Result:
*/