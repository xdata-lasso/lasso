-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Product A', 'Electronics', 10.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Product B', 'Electronics', 20.0, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category FROM Products;

/*
Gold Result:
('Electronics',)
('Electronics',)
*/

-- Prediction Query
SELECT DISTINCT category FROM Products;

/*
Prediction Result:
('Electronics',)
*/