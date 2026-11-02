-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483648, -2147483648, 'a_s_f41d21', 86.520366, '2020-09-26');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483647, -2147483648, 'a_s_638351', 779.409124, '2021-05-05');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (2, 1, 'a_s_f41d21', 133.007885, '2020-11-04');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (3, 1, 'a_s_638351', 489.397796, '2022-06-13');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483644, 1, 'a_s_f41d21', NULL, '2025-09-21');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483643, -2147483648, 'a_s_f41d21', NULL, '2021-12-14');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483642, 1, 'a_s_f41d21', 83.204633, '2020-01-23');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483641, 1, '00t5c4ecigc', 623.093099, '2025-03-28');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483640, -2147483648, 'a_s_f41d21', NULL, '2021-06-20');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483639, 1, 'a_s_f41d21', NULL, '2022-02-24');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483638, 1, 'a_s_f41d21', 452.706544, '2024-06-13');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483637, -2147483648, 'a_s_f41d21', 676.357279, '2022-07-11');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483636, 1, 'a_s_f41d21', 478.908865, '2022-04-13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts AS a WHERE balance = (SELECT MAX(balance) FROM Accounts WHERE account_type = a.account_type);

/*
Gold Result:
(-2147483648,)
(1,)
(-2147483648,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance = (SELECT MAX(balance) FROM Accounts);

/*
Prediction Result:
(-2147483648,)
*/