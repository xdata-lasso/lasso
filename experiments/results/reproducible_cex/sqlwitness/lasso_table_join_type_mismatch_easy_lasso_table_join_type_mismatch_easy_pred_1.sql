-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (user_id, name, email, registration_date, is_active) VALUES (1, NULL, 'default2', NULL, 0), (0, 'default2', 'default2', NULL, 1), (2, NULL, 'default1', '2023-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, o.order_date FROM Users AS u LEFT JOIN Orders AS o ON u.user_id = o.user_id;

/*
Gold Result:
('default2', None)
(None, None)
(None, None)
*/

-- Prediction Query
SELECT u.name, o.order_date FROM Users AS u CROSS JOIN Orders AS o ON u.user_id = o.user_id;

/*
Prediction Result:
*/