-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1014, 'Sarah Martin', '0260 Baker Tunnel
Mitchellside, TN 94664', '923.443.0980x5009', 'yuchristopher@example.org');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1018, 'Jeffrey Daniels', '841 Joseph Coves
West Juan, IL 94559', '634-487-4016x40052', 'barnold@example.net');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1015, 1014, 'authority', 1.0, '1976-07-07');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1019, 1018, NULL, 1.0, '1978-09-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts WHERE balance > 0 AND NOT account_type IS NULL;

/*
Gold Result:
(1014,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance > 0;

/*
Prediction Result:
(1014,)
(1018,)
*/