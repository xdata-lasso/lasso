-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive dataset: tests MIN vs MAX/AVG/SUM, > vs >=/<, outer vs inner category filter, global MIN vs Electronics MIN, and NULL handling.
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Cheap Book', 'Books', 10.0, 50);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'USB Cable', 'Electronics', 50.0, 100);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Mid Book', 'Books', 50.0, 30);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Headphones', 'Electronics', 80.0, 40);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Rare Book', 'Books', 100.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Monitor', 'Electronics', 200.0, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (7, 'Mystery Box', 'Misc', NULL, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (8, 'Broken TV', 'Electronics', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price > (SELECT MIN(price) FROM Products WHERE category = 'Electronics');

/*
Gold Result:
('Headphones',)
('Rare Book',)
('Monitor',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price > (SELECT MAX(price) FROM Products WHERE category = 'Electronics');

/*
Prediction Result:
*/