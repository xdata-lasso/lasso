-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v');

-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483648, 1, 'e4', 1.0, '2021-05-05');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (2, 1, 'ia2yp', 1.0, '2023-08-23');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (3, 1, 'hsrwbbp', 1.0, '2025-08-22');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483645, 1, 'uhv', 0.0, '2020-08-14');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483644, 1, 'tilbn', 1.0, '2022-09-14');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (4, 1, 'dpos', NULL, '2021-06-28');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (5, 1, '5u', 1.0, '2022-06-13');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (6, 1, 'klfa9000t', 1.0, '2025-07-01');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (7, 1, '4ecigce376n', 1.0, '2021-06-20');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (8, 1, '52zb', 1.0, '2023-08-27');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (9, 1, 'nrqrofqy', 1.0, '2022-09-19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance <> 0;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance <= 0;

/*
Prediction Result:
(1,)
*/