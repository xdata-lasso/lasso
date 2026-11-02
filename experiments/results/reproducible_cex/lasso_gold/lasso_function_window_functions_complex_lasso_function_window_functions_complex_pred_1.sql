-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1018, 'Christopher Becker', '9784 Erin Crescent Suite 514
Mooretown, VA 94830', '282-781-4893x252', 'xsmith@example.com');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1023, 'Keith Miller', '227 Joseph Well
Brandtside, WV 96174', '001-734-265-7871x331', 'briannasmith@example.net');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1019, 1018, 'education', 1020.5, '1976-07-07');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1024, 1023, 'program', 1025.5, '1978-09-09');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1021, 1019, 'article', 1022.5, '1977-08-08');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1026, 1024, 'artist', NULL, '1979-10-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Gold Result:
(1019, 1022.5)
(1024, None)
*/

-- Prediction Query
SELECT account_id, SUM(amount) OVER (ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM Transactions;

/*
Prediction Result:
(1019, 1022.5)
(1024, 1022.5)
*/