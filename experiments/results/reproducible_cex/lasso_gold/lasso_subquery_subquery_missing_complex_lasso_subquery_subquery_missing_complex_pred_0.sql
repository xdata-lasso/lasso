-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1010, 'Timothy Watts', '30564 Jason Port Suite 376
Thomasberg, IA 98148', '+1-484-996-9653', 'camposmichelle@example.org');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1014, 'Michael Carlson', '480 Erin Plain Suite 514
Mooretown, VA 94830', '282-781-4893x252', 'xsmith@example.com');
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1018, 'Shawn Arroyo', '82278 Joseph Well Suite 383
Raymondstad, NV 68340', '213.331.5098x393', 'perezrebecca@example.com');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1011, 1010, 'product', 1012.5, '1974-05-05');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1013, 1010, 'product', 1012.5, '1975-06-06');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1015, 1014, 'education', NULL, '1976-07-07');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1017, 1014, 'education', NULL, '1977-08-08');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1019, 1018, 'avoid', 1020.5, '1978-09-09');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1021, 1018, 'avoid', 1020.5, '1979-10-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM Accounts AS a WHERE balance = (SELECT MAX(balance) FROM Accounts WHERE account_type = a.account_type);

/*
Gold Result:
(1010,)
(1010,)
(1018,)
(1018,)
*/

-- Prediction Query
SELECT customer_id FROM Accounts WHERE balance = (SELECT MAX(balance) FROM Accounts);

/*
Prediction Result:
(1018,)
(1018,)
*/