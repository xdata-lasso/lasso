-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic LEFT JOIN behavior vs INNER JOIN, cross join, and wrong join conditions (e.g., u.user_id = o.order_id).
-- Also tests projection errors (e.g., selecting registration_date or email instead of order_date or name) and spurious WHERE filters on is_active, status, or total_amount.
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (2, 'Bob', 'bob@example.com', '2023-01-02', 0);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (10, 1, '2023-02-01', 0.0, 'Pending');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, o.order_date FROM Users AS u LEFT JOIN Orders AS o ON u.user_id = o.user_id;

/*
Gold Result:
('Alice', '2023-02-01')
('Bob', None)
*/

-- Prediction Query
SELECT u.name, o.order_date FROM Users AS u INNER JOIN Orders AS o ON u.user_id = o.user_id;

/*
Prediction Result:
('Alice', '2023-02-01')
*/