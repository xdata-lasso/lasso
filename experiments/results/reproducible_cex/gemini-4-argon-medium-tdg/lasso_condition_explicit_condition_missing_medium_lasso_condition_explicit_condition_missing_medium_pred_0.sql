-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic logical operators (AND vs OR), category filtering, and stock_quantity boundary conditions (> 0 vs >= 0, > 1, < 0).
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Laptop', 'Electronics', 999.99, 1);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Smartphone', 'Electronics', 599.99, 0);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Headphones', 'Electronics', 149.99, -5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Desk Chair', 'Furniture', 199.99, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Coffee Table', 'Furniture', 89.99, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE category = 'Electronics' AND stock_quantity > 0;

/*
Gold Result:
('Laptop',)
*/

-- Prediction Query
SELECT name FROM Products WHERE category = 'Electronics';

/*
Prediction Result:
('Laptop',)
('Smartphone',)
('Headphones',)
*/