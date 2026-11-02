-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1013, 'Brittany Moore', '6978 Maddox Wall
Lake Jenniferside, WV 35474', '001-551-446-2704x82814', 'kathryn88@example.org');
INSERT INTO "accounts" ("account_id", "customer_id", "account_type", "balance", "open_date") VALUES (1014, 1013, 'checking', 1015.5, '1976-07-07');
INSERT INTO "transactions" ("transaction_id", "account_id", "transaction_type", "amount", "transaction_date") VALUES (1016, 1014, 'withdrawal_z', 1001.0, '1977-08-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id WHERE t.amount > 1000 AND a.account_type = 'checking' AND t.transaction_type = 'withdrawal';

/*
Gold Result:
*/

-- Prediction Query
SELECT t.transaction_id FROM Transactions AS t JOIN Accounts AS a ON t.account_id = a.account_id;

/*
Prediction Result:
(1016,)
*/