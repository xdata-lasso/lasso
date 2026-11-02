-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard grouping with varying group sizes, duplicate column values (for COUNT(DISTINCT) mutants), and join-cardiinality traps with OrderItems.
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (1, 1, '2023-02-01', 150.0, 'Completed');
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Laptop', 'Electronics', 1000.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Laptop', 'Electronics', 1000.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Mouse', 'Electronics', 25.0, 0);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Novel', 'Books', 15.0, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Desk', 'Furniture', 200.0, 2);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Chair', 'Furniture', 100.0, 4);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 1, 1000.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (2, 1, 1, 2, 1000.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (3, 1, 4, 1, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category;

/*
Gold Result:
('Books', 1)
('Electronics', 3)
('Furniture', 2)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products;

/*
Prediction Result:
('Electronics', 6)
*/