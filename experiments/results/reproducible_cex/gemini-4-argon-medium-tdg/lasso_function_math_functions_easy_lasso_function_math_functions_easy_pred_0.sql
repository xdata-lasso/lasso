-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests precision and rounding boundaries: 3+ decimal places rounding down and up, exact half-way rounding (.005), 0, 1, and 2 decimal places.
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Item A', 'Electronics', 10.123, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Item B', 'Books', 10.126, 0);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Item C', 'Clothing', 10.125, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Item D', 'Home', 15.5, 2);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Item E', 'Toys', 20.0, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(price, 2) FROM Products;

/*
Gold Result:
(10.12,)
(10.13,)
(10.13,)
(15.5,)
(20.0,)
*/

-- Prediction Query
SELECT ROUND(price, 0) FROM Products;

/*
Prediction Result:
(10.0,)
(10.0,)
(10.0,)
(16.0,)
(20.0,)
*/