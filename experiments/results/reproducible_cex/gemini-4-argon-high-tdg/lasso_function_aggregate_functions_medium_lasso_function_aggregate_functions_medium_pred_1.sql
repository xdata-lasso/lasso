-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-10', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2023-02-15', 999.0, 'Completed');
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Laptop', 'Electronics', 100.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Headphones', 'Electronics', 100.0, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Monitor', 'Electronics', 250.0, 8);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Desk Chair', 'Furniture', 500.0, 3);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1001, 101, 1, 2, 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(price) FROM Products WHERE category = 'Electronics';

/*
Gold Result:
(150.0,)
*/

-- Prediction Query
SELECT SUM(price) FROM Products WHERE category = 'Electronics';

/*
Prediction Result:
(450.0,)
*/