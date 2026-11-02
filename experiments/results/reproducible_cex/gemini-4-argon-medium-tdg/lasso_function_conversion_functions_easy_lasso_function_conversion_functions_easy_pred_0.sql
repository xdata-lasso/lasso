-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Standard Widget', 'Hardware', 10.4, 50);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Midpoint Widget', 'Hardware', 10.5, 30);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'High Fraction Widget', 'Hardware', 10.99, 20);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Exact Price Widget', 'Hardware', 25.0, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Sub-Unit Widget', 'Accessories', 0.99, 100);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Free Sample', 'Promotional', 0.0, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(price AS INTEGER) FROM Products;

/*
Gold Result:
(10,)
(10,)
(10,)
(25,)
(0,)
(0,)
*/

-- Prediction Query
SELECT CAST(price AS TEXT) FROM Products;

/*
Prediction Result:
('10.4',)
('10.5',)
('10.99',)
('25.0',)
('0.99',)
('0.0',)
*/