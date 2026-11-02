-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (1, 1, '2023-01-01', 100.0, 'completed');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (2, 1, '2023-01-02', 200.0, 'completed');
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Product A', 'Cat 1', 100.0, 10);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 5, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = i.order_id;

/*
Gold Result:
('2023-01-01', 5)
*/

-- Prediction Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = o.order_id;

/*
Prediction Result:
('2023-01-01', 5)
('2023-01-02', 5)
*/