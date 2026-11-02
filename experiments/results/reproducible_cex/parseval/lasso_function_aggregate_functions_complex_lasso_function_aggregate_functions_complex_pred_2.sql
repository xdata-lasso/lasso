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
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483648, 1, 'e4', 779.409124, '2021-05-05');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483647, 1, 'ia2yp', 718.397869, '2023-08-23');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483646, 1, 'hsrwbbp', 503.083789, '2023-08-07');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (2, 1, 'hvdlttilbnpr', 986.066566, '2020-07-11');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (3, 1, 'posiie5unw6k', 768.216462, '2020-12-06');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483645, 1, 'a9000t5c4eci', 734.586266, '2021-03-18');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483642, 1, 'e', NULL, '2025-03-28');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483641, 1, '6nium52zb', NULL, '2023-08-27');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483640, 1, '4nrq', NULL, '2023-01-30');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483639, 1, 'fqyp', NULL, '2025-06-25');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483638, 1, '5bbp0', NULL, '2024-12-15');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483637, 1, 'eutliqa11r', NULL, '2024-03-30');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483636, 1, 'oo3o9', NULL, '2021-04-03');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483635, 1, '72klex14ji7z', NULL, '2023-12-17');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483634, 1, '2dwyrq', NULL, '2024-11-10');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483633, 1, '3pyu78d99r', NULL, '2022-01-18');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483632, 1, 'sl0', NULL, '2020-04-20');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483631, 1, 'yp5qi2rk', NULL, '2021-01-15');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (4, 1, 'vqx58pz0f', 2.0, '2021-08-12');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (5, 1, 'gd', 3.0, '2025-01-26');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (6, 1, 'y9uxj4', 1.0, '2021-05-25');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (7, 1, 'd', 1.0, '2023-09-07');

INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (8, 1, '5sw', 357.862717, '2022-12-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, SUM(balance) FROM Accounts GROUP BY customer_id;

/*
Gold Result:
(1, 4854.6227930000005)
*/

-- Prediction Query
SELECT customer_id, AVG(balance) FROM Accounts GROUP BY customer_id;

/*
Prediction Result:
(1, 441.3293448181819)
*/