-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Precision Scale', 'Hardware', 19.996, 50);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Copper Wire', 'Hardware', 10.124, 120);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Thermal Paste', 'Electronics', 5.555, 30);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Monitor Stand', 'Accessories', 100.0, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Washer', 'Hardware', 0.009, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(price, 2) FROM Products;

/*
Gold Result:
(20.0,)
(10.12,)
(5.55,)
(100.0,)
(0.01,)
*/

-- Prediction Query
SELECT ROUND(price, 0) FROM Products;

/*
Prediction Result:
(20.0,)
(10.0,)
(6.0,)
(100.0,)
(0.0,)
*/