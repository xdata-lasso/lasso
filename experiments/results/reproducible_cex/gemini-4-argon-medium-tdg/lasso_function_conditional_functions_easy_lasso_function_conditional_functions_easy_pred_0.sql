-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Laptop', 'Electronics', 999.99, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Mouse', 'Electronics', 19.99, 1);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Keyboard', 'Electronics', 49.99, 0);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Monitor', 'Electronics', 199.99, -1);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Desk', 'Furniture', 150.00, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT IIF(stock_quantity > 0, 'In Stock', 'Out of Stock') FROM Products;

/*
Gold Result:
('In Stock',)
('In Stock',)
('Out of Stock',)
('Out of Stock',)
('Out of Stock',)
*/

-- Prediction Query
SELECT IIF(stock_quantity > 0, 'Out of Stock', 'In Stock') FROM Products;

/*
Prediction Result:
('Out of Stock',)
('Out of Stock',)
('In Stock',)
('In Stock',)
('In Stock',)
*/