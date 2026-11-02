-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (user_id, name, email, registration_date, is_active) VALUES (0, 'default1', '2023-01-01', '2023-01-01', 1), (1, '01/01/2023', '2023-01-01', '2023-01-02', 0), (2, NULL, 'default2', '2023-01-01', 0), (3, 'default1', '2023-01-01', NULL, 1), (4, '01/01/2023', '2023-01-01', '2022-12-31', 1), (5, 'default1', NULL, '2023-01-01', 1);
INSERT INTO orders (order_id, user_id, order_date, total_amount, status) VALUES (1, 2, '2023-01-01', 0.0, '01/01/2023'), (0, 0, '2023-01-02', 1.0, '2023-01-01'), (2, 2, '2023-01-02', 0.0, NULL), (3, 5, '2023-01-01', NULL, '01/01/2023'), (4, 5, '2023-01-01', 1.0, NULL), (5, 2, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_amount FROM Orders WHERE order_date = '2023-01-01';

/*
Gold Result:
(0.0,)
(None,)
(1.0,)
*/

-- Prediction Query
SELECT total_amount FROM Orders WHERE order_date = '01/01/2023';

/*
Prediction Result:
*/