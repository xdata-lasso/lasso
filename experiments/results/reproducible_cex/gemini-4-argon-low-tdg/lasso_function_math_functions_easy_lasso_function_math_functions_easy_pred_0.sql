-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests rounding with various decimal precisions (truncation vs rounding up/down, 0, 1, 2, 3, and 4 decimal places) and duplicate rounded outputs (testing DISTINCT vs ALL).
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Item A', 'Cat 1', 10.123, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Item B', 'Cat 1', 10.126, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Item C', 'Cat 2', 10.125, 0);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Item D', 'Cat 2', 10.1, 20);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Item E', 'Cat 3', 10.0, 100);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Item F', 'Cat 3', 10.1234, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(price, 2) FROM Products;

/*
Gold Result:
(10.12,)
(10.13,)
(10.13,)
(10.1,)
(10.0,)
(10.12,)
*/

-- Prediction Query
SELECT ROUND(price, 0) FROM Products;

/*
Prediction Result:
(10.0,)
(10.0,)
(10.0,)
(10.0,)
(10.0,)
(10.0,)
*/