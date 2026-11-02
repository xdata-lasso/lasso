-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic division of users with and without orders, duplicate names, NULL names, inactive users, and users with multiple orders.
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (2, 'Bob', 'bob1@example.com', '2023-01-02', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (3, 'Bob', 'bob2@example.com', '2023-01-03', 0);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (4, 'Charlie', 'charlie@example.com', '2023-01-04', 0);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (5, NULL, 'null@example.com', '2023-01-05', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2023-02-01', 50.0, 'completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (102, 1, '2023-02-02', 0.0, 'cancelled');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (103, 4, '2023-02-03', 100.0, 'pending');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Users WHERE NOT user_id IN (SELECT user_id FROM Orders);

/*
Gold Result:
('Bob',)
('Bob',)
(None,)
*/

-- Prediction Query
SELECT user_id FROM Orders;

/*
Prediction Result:
(1,)
(1,)
(4,)
*/