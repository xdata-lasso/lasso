-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Smartphone', 'Electronics', 699.99, 1);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Laptop', 'Electronics', 1299.99, 0);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Backordered GPU', 'Electronics', 899.99, -5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Mystery Gadget', 'Electronics', 49.99, NULL);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Winter Jacket', 'Clothing', 120.00, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Bluetooth Speaker', 'Electronics', 89.50, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE category = 'Electronics' AND stock_quantity > 0;

/*
Gold Result:
('Smartphone',)
('Bluetooth Speaker',)
*/

-- Prediction Query
SELECT name FROM Products WHERE category = 'Electronics';

/*
Prediction Result:
('Smartphone',)
('Laptop',)
('Backordered GPU',)
('Mystery Gadget',)
('Bluetooth Speaker',)
*/