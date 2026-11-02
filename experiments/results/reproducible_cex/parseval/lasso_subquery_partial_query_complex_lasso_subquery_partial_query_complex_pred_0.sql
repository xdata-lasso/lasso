-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, customer_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id), FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v');

-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483648, 1, 'e4', 779.409124, '2021-05-05');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (2, 1, 'uzhsrwbbp6lu', 737.440743, '2023-10-03');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (3, 1, 'l', 303.05704, '2021-05-27');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483645, 1, 'fa9', 877.276439, '2024-09-12');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483644, 1, '0t5c4ecigc', 623.093099, '2025-03-28');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483643, 1, '02eutliqa11r', 997.73177, '2024-03-26');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483642, 1, '7zw', 612.02959, '2023-07-07');

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "account_id", "customer_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483648, -2147483648, 1, 'a2y', 797.015047, '2022-01-21 14:23:36+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "customer_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483647, -2147483648, 1, 'n', 240.969194, '2022-04-12 01:47:28+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "customer_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483646, -2147483648, 1, 'dposiie5unw', 992.733505, '2021-05-18 10:50:30+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "customer_id", "transaction_type", "amount", "transaction_date") VALUES (2, -2147483644, 1, 'nium52zbu', 225.300904, '2021-09-24 11:50:48+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "customer_id", "transaction_type", "amount", "transaction_date") VALUES (3, -2147483644, 1, 'rqrofqyp5s5b', 22.720462, '2022-01-05 17:19:47+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "customer_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483643, 3, 1, 'o3o9hl72klex', 913.303855, '2024-02-08 07:13:40+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "customer_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483642, -2147483643, 1, 'dwyrq13p', 375.832821, '2024-06-05 19:22:34+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts INTERSECT SELECT customer_id FROM Transactions;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts;

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/