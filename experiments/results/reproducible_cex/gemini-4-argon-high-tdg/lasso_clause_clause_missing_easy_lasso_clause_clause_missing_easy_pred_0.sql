-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-10', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2023-02-01', 150.0, 'Completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (102, 1, '2023-02-05', 50.0, 'Pending');
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Laptop', 'Electronics', 1000.0, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Mouse', 'Electronics', 25.0, 50);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Novel', 'Books', 15.0, 100);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Shirt', 'Clothing', 30.0, 20);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Jeans', 'Clothing', 45.0, 15);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Jacket', 'Clothing', 80.0, 5);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1001, 101, 1, 1, 1000.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1002, 102, 1, 2, 1000.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1003, 101, 3, 1, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category;

/*
Gold Result:
('Books', 1)
('Clothing', 3)
('Electronics', 2)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products;

/*
Prediction Result:
('Electronics', 6)
*/