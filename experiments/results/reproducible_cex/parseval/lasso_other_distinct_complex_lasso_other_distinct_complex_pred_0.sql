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
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (2, -2147483648, 'acc_11865c', 86.520366, '2020-09-26');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (3, -2147483648, 'acc_11865c', 779.409124, '2021-05-05');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (4, -2147483648, 'a2y', 797.015047, '2022-09-17');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (5, -2147483648, 'hsrwbbp', 503.083789, '2023-08-07');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (6, -2147483648, 'dlttil', 22.535764, '2022-04-29');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (7, -2147483648, 'mdpos', 133.007885, '2020-11-04');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (8, -2147483648, 'nw6klf', 741.842896, '2024-07-24');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (9, -2147483648, '0t5c4ecigc', 623.093099, '2025-03-28');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (10, -2147483648, 'um5', 452.706544, '2024-06-13');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (11, -2147483648, 'uo4nrqrofqy', 242.260296, '2023-03-15');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (12, -2147483648, 'bbp02eutliqa', 427.383654, '2024-10-14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT account_type) FROM Accounts;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT COUNT(account_type) FROM Accounts;

/*
Prediction Result:
(11,)
*/