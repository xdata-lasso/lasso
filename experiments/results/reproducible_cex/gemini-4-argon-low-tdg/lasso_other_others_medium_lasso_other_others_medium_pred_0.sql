-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General comprehensive dataset: Tests SUM vs AVG/COUNT/MIN/MAX, SUM(DISTINCT), WHERE filtering, and floating point values.
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (1, 1, '2023-01-02', 50.0, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (2, 1, '2023-01-03', 50.0, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (3, 1, '2023-01-04', 25.5, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (4, 1, '2023-01-05', 100.0, 'pending');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (5, 1, '2023-01-06', 200.0, 'cancelled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(total_amount) FROM Orders WHERE status = 'shipped';

/*
Gold Result:
(125.5,)
*/

-- Prediction Query
SELECT AVG(price) FROM Products;

/*
Prediction Result:
(None,)
*/