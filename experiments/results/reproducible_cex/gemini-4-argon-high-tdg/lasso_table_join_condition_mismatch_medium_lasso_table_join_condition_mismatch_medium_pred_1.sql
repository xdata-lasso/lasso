-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (10, 'Alice', 'alice@example.com', '2020-01-01', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (20, 'Bob', 'bob@example.com', '2021-02-02', 1);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (30, 'Laptop', 'Electronics', 1000.0, 50);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (40, 'Mouse', 'Electronics', 25.0, 200);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (1, 10, '2023-05-10', 1050.0, 'Completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (2, 20, '2023-06-15', 75.0, 'Pending');
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (100, 1, 30, 1, 1000.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (101, 1, 40, 2, 25.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (102, 2, 40, 3, 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = i.order_id;

/*
Gold Result:
('2023-05-10', 1)
('2023-05-10', 2)
('2023-06-15', 3)
*/

-- Prediction Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = o.order_id;

/*
Prediction Result:
('2023-05-10', 1)
('2023-05-10', 2)
('2023-05-10', 3)
('2023-06-15', 1)
('2023-06-15', 2)
('2023-06-15', 3)
*/