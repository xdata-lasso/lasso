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
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (-2147483648, -2147483648, 'e4', 779.409124, '2021-05-05');

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483648, -2147483648, 'ia2yp', 718.397869, '2024-06-15 00:00:00+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483647, -2147483648, 'hsrwbbp', 503.083789, '2024-06-15 00:00:00+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (2, -2147483648, 'hvdlttilbnpr', 986.066566, '2024-06-15 00:00:00+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (3, -2147483648, 'posiie5unw6k', 768.216462, '2024-06-15 00:00:00+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483646, -2147483648, 'a9000t5c4eci', 734.586266, '2024-06-15 00:00:00+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483643, -2147483648, 'e', 467.07027, '2024-06-15 00:00:00+00:00');

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483642, -2147483648, 'um5', 452.706544, NULL);

INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (-2147483641, -2147483648, 'u', 225.300904, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DATE(transaction_date) FROM Transactions;

/*
Gold Result:
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
(None,)
(None,)
('2024-06-15',)
('2024-06-15',)
*/

-- Prediction Query
SELECT CAST(transaction_date AS REAL) FROM Transactions;

/*
Prediction Result:
(2024.0,)
(2024.0,)
(2024.0,)
(2024.0,)
(None,)
(None,)
(2024.0,)
(2024.0,)
*/