-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice Smith', 'alice@example.com', '2022-01-15', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (2, 'Bob Jones', 'bob@example.org', '2021-06-20', 0);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (3, 'Charlie Brown', 'charlie@sample.net', '2023-11-05', 1);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (10, 'Laptop', 'Electronics', 999.99, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (20, 'Mouse', 'Electronics', 25.50, 0);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (100, 1, '2022-02-01', 999.99, 'Completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2022-03-10', 51.00, 'Pending');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (102, 3, '2023-11-06', 25.50, 'Cancelled');
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1000, 100, 10, 1, 999.99);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1001, 101, 20, 2, 25.50);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1002, 102, 20, 1, 25.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM Users;

/*
Gold Result:
(1, 'Alice Smith', 'alice@example.com', '2022-01-15', 1)
(2, 'Bob Jones', 'bob@example.org', '2021-06-20', 0)
(3, 'Charlie Brown', 'charlie@sample.net', '2023-11-05', 1)
*/

-- Prediction Query
SELECT * FROM orderitems;

/*
Prediction Result:
(1000, 100, 10, 1, 999.99)
(1001, 101, 20, 2, 25.5)
(1002, 102, 20, 1, 25.5)
*/