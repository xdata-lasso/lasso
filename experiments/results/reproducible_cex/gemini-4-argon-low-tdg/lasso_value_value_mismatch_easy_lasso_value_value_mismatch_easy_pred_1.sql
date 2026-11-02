-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic active vs inactive filtering, duplicate names (kills SELECT DISTINCT), NULL values, and other non-1 truthy integers (kills WHERE is_active without = 1 or >= 1 / != 0 mutants).
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice1@example.com', '2023-01-01', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (2, 'Alice', 'alice2@example.com', '2023-01-02', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (3, 'Bob', 'bob@example.com', '2023-01-03', 0);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (4, 'Charlie', 'charlie@example.com', '2023-01-04', NULL);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (5, 'David', 'david@example.com', '2023-01-05', 2);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (6, 'Eve', 'eve@example.com', '2023-01-06', -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Users WHERE is_active = 1;

/*
Gold Result:
('Alice',)
('Alice',)
*/

-- Prediction Query
SELECT name FROM Users WHERE is_active = 2;

/*
Prediction Result:
('David',)
*/