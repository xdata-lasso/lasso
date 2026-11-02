-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (-2147483648, 'cus_094cfc', '5k5swwqcgs', '9n8', '@gmail.com');

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (2, 'cus_094cfc', '4', 'gu7v', '@gmail.com');

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (3, 'cus_094cfc', 'e4', 'hria2ypuzhs', '@gmail.com');

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (-2147483645, 'cus_094cfc', 'rwbbp6luhvd', 'tti', NULL);

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (-2147483644, NULL, 'bnp', 'mdpos', '@gmail.com');

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (4, 'ie5', 'nw6klf', 'a9000t5c4eci', NULL);

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (5, 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', NULL);

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (6, '2eutliqa11r', 'ytoo3o9', 'l7', NULL);

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (7, 'klex14ji', '7zwau2dwyr', '13pyu', NULL);

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (8, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', NULL);

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (9, 'pz0f8jegd', '1vy9uxj4', 'wb', NULL);

INSERT INTO "customers" ("customer_id", "name", "address", "phone", "email") VALUES (10, 'v', 'ph2', 'nd', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Customers WHERE email LIKE '%@gmail.com';

/*
Gold Result:
('cus_094cfc',)
(None,)
('cus_094cfc',)
('cus_094cfc',)
*/

-- Prediction Query
SELECT name FROM Customers CROSS JOIN Transactions WHERE email LIKE '%@gmail.com';

/*
Prediction Result:
*/