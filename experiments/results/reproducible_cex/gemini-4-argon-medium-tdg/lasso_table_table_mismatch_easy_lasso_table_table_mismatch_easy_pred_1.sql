-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive dataset testing:
-- 1. Unwarranted WHERE filters (is_active = 1/0, NULLs, dates, string patterns).
-- 2. Unwarranted JOINs with Orders/OrderItems (user 1 has multiple orders, user 2 has 1 order, user 3 & 4 have 0 orders).
-- 3. Unwarranted DISTINCT or GROUP BY on non-PK columns (users 3 and 4 have identical non-PK attributes).
-- 4. Unwarranted LIMIT 1 / LIMIT 2 (4 users total).
-- 5. Unwarranted ORDER BY (non-PK attributes out of order relative to user_id).
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Zoe', 'zoe@example.com', '2023-12-31', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (2, 'Alice', NULL, '2020-01-01', 0);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (3, 'Bob', 'bob@example.com', '2022-06-15', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (4, 'Bob', 'bob@example.com', '2022-06-15', 1);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (10, 'Laptop', 'Electronics', 999.99, 5);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (100, 1, '2024-01-01', 999.99, 'Completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2024-01-02', 50.00, 'Pending');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (102, 2, '2020-01-05', 0.00, 'Cancelled');
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1000, 100, 10, 1, 999.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM Users;

/*
Gold Result:
(1, 'Zoe', 'zoe@example.com', '2023-12-31', 1)
(2, 'Alice', None, '2020-01-01', 0)
(3, 'Bob', 'bob@example.com', '2022-06-15', 1)
(4, 'Bob', 'bob@example.com', '2022-06-15', 1)
*/

-- Prediction Query
SELECT * FROM products;

/*
Prediction Result:
(10, 'Laptop', 'Electronics', 999.99, 5)
*/