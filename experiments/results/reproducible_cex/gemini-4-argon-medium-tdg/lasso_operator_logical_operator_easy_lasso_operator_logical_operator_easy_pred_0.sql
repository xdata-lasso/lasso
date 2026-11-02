-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2023-01-10', 100.0, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (102, 1, '2023-01-11', 50.0, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (103, 1, '2023-01-12', 49.99, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (104, 1, '2023-01-13', 50.01, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (105, 1, '2023-01-14', -60.0, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (106, 1, '2023-01-15', 0.0, 'shipped');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE total_amount > 50 AND status = 'shipped';

/*
Gold Result:
(101,)
(104,)
*/

-- Prediction Query
SELECT order_id FROM Orders WHERE total_amount > 50 OR status = 'shipped';

/*
Prediction Result:
(101,)
(102,)
(103,)
(104,)
(105,)
(106,)
*/