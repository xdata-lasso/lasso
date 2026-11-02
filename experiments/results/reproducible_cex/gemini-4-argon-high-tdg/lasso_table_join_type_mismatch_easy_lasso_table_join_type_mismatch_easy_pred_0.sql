-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (10, 'Alice', 'alice@example.com', '2022-01-01', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (20, 'Bob', 'bob@example.com', '2022-02-01', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (30, 'Charlie', 'charlie@example.com', '2022-03-01', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (10, 30, '2023-01-15', 50.0, 'completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (100, 10, '2023-02-10', 120.5, 'completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 10, '2023-02-20', 75.0, 'completed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, o.order_date FROM Users AS u LEFT JOIN Orders AS o ON u.user_id = o.user_id;

/*
Gold Result:
('Alice', '2023-02-10')
('Alice', '2023-02-20')
('Bob', None)
('Charlie', '2023-01-15')
*/

-- Prediction Query
SELECT u.name, o.order_date FROM Users AS u INNER JOIN Orders AS o ON u.user_id = o.user_id;

/*
Prediction Result:
('Charlie', '2023-01-15')
('Alice', '2023-02-10')
('Alice', '2023-02-20')
*/