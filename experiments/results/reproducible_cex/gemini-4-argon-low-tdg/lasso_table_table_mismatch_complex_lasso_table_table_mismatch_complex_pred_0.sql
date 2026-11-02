-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (2, 'Bob', 'bob@example.com', '2023-01-02', 0);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (3, 'Charlie', 'charlie@example.com', '2023-01-03', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (101, 1, '2023-02-01', 50.0, 'shipped');
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (102, 2, '2023-02-02', 75.0, 'pending');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name FROM Users AS u JOIN Orders AS o ON u.user_id = o.user_id WHERE o.status = 'shipped';

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT u.name FROM Users AS u JOIN Products AS p ON u.user_id = p.product_id WHERE p.category = 'shipped';

/*
Prediction Result:
*/