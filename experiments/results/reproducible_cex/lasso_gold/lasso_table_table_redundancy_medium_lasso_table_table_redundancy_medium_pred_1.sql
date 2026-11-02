-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (1001, 'Brian Yang', '01338 Anna Stravenue Suite 379
Lisatown, WV 21427', '001-765-642-3511x615', '@gmail.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Customers WHERE email LIKE '%@gmail.com';

/*
Gold Result:
('Brian Yang',)
*/

-- Prediction Query
SELECT name FROM Customers CROSS JOIN Transactions WHERE email LIKE '%@gmail.com';

/*
Prediction Result:
*/