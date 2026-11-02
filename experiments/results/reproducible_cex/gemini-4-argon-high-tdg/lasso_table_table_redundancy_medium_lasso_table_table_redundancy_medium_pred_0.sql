-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT);

CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, customer_id INTEGER, account_type TEXT, balance REAL, open_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Transactions (transaction_id INTEGER PRIMARY KEY, account_id INTEGER, transaction_type TEXT, amount REAL, transaction_date DATETIME, FOREIGN KEY (account_id) REFERENCES Accounts (account_id));

CREATE TABLE Branches (branch_id INTEGER PRIMARY KEY, branch_name TEXT, location TEXT, total_assets REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (1, 'Charlie Brown', '10 Elm St', '555-0201', 'charlie@gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (2, 'David Clark', '20 Maple St', '555-0202', 'david@gmail.com.uk');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (3, 'Eve Adams', '30 Cedar St', '555-0203', 'eve.gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (4, 'Frank Wright', '40 Birch St', '555-0204', 'frank@gmail.org');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (5, 'Grace Hopper', '50 Walnut St', '555-0205', '@gmail.com');
INSERT INTO Customers (customer_id, name, address, phone, email) VALUES (6, 'Heidi Klum', '60 Chestnut St', '555-0206', 'h@gmail.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Customers WHERE email LIKE '%@gmail.com';

/*
Gold Result:
('Charlie Brown',)
('Grace Hopper',)
('Heidi Klum',)
*/

-- Prediction Query
SELECT c.name FROM Customers AS c JOIN Accounts AS a ON c.customer_id = a.customer_id WHERE c.email LIKE '%@gmail.com';

/*
Prediction Result:
*/