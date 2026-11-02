-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Monitor', 'Electronics', 300.0, 50);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Keyboard', 'Electronics', 100.0, 20);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Mouse', 'Electronics', 100.0, 80);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Webcam', 'Electronics', 200.0, 40);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Headset', 'Electronics', 200.0, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products ORDER BY price ASC, stock_quantity DESC, Products.product_id NULLS LAST;

/*
Gold Result:
('Mouse',)
('Keyboard',)
('Headset',)
('Webcam',)
('Monitor',)
*/

-- Prediction Query
SELECT name FROM Products ORDER BY price DESC, stock_quantity DESC, Products.product_id NULLS LAST;

/*
Prediction Result:
('Monitor',)
('Headset',)
('Webcam',)
('Mouse',)
('Keyboard',)
*/