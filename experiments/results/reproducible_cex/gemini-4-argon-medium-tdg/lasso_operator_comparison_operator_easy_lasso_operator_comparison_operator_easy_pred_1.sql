-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (100.0), floating-point precision boundaries (99.99, 100.01), and NULL price handling.
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Product_99_99', 'Books', 99.99, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Product_100_00', 'Electronics', 100.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Product_100_01', 'Home', 100.01, 2);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Product_NULL_Price', 'Misc', NULL, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price >= 100;

/*
Gold Result:
('Product_100_00',)
('Product_100_01',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price <= 100;

/*
Prediction Result:
('Product_99_99',)
('Product_100_00',)
*/