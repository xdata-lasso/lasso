-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Cheap Phone', 'Electronics', 100.0, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Mid Tablet', 'Electronics', 200.0, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'High Laptop', 'Electronics', 300.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Budget Book', 'Books', 50.0, 20);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Equal Chair', 'Furniture', 100.0, 8);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Pricey Desk', 'Furniture', 150.0, 3);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (7, 'Luxury Sofa', 'Furniture', 400.0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price > (SELECT MIN(price) FROM Products WHERE category = 'Electronics');

/*
Gold Result:
('Mid Tablet',)
('High Laptop',)
('Pricey Desk',)
('Luxury Sofa',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price > (SELECT MAX(price) FROM Products WHERE category = 'Electronics');

/*
Prediction Result:
('Luxury Sofa',)
*/