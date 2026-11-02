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

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (2, -2147483648, 'checking', 268.82475, '2020-01-20');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (3, -2147483648, 'puzhsrw', 944.247544, '2020-03-30');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (4, -2147483648, 'checking', 165.344793, '2023-03-15');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (5, -2147483648, 'checking', 833.684115, '2022-12-08');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (6, -2147483648, 'a_s_cec48c', 292.730571, '2022-04-27');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (7, -2147483648, 'a_s_cec48c', 475.173408, '2021-02-11');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (8, -2147483648, 'a_s_cec48c', 520.784135, '2020-12-20');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (9, -2147483648, NULL, 779.409124, '2021-05-05');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (10, -2147483648, NULL, 710.998147, '2020-01-20');

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1, 1, 'withdrawal', 1000.01, '2024-02-11 16:43:27+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (2, 1, 'withdrawal', 1000.01, '2020-12-19 01:52:21+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (3, 1, 'withdrawal', 1000.01, '2022-11-06 10:19:41+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (4, 4, 't_s_f03e56', 1000.01, '2022-12-08 21:38:59+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (5, 5, NULL, 1000.01, '2020-04-30 03:21:27+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (6, 6, 'withdrawal', 1000.01, '2025-02-21 23:30:13+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (7, 7, 't_s_f03e56', 1000.01, '2025-11-08 19:01:33+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (8, 8, NULL, 1000.01, '2020-07-23 07:32:15+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (9, 9, 'withdrawal', 1000.01, '2022-04-15 05:01:35+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (10, 10, 't_s_f03e56', 1000.01, '2023-10-02 15:43:02+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking' AND t.transaction_type = 'withdrawal';

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking';

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
*/