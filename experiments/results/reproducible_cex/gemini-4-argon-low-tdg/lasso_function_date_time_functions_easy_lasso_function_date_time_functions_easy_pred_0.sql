-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2020-01-01', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2022-12-31', 50.0, 'completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (102, 1, '2023-01-01', 75.0, 'completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (103, 1, '2023-06-15', 100.0, 'pending');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (104, 1, '2023-12-31', 120.0, 'cancelled');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (105, 1, '2024-01-01', 200.0, 'completed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', order_date) = '2023';

/*
Gold Result:
(102,)
(103,)
(104,)
*/

-- Prediction Query
SELECT order_id FROM Orders WHERE STRFTIME('%m', order_date) = '05';

/*
Prediction Result:
*/