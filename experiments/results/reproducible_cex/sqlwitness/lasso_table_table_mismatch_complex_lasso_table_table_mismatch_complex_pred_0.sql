-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, stock_quantity) VALUES (0, 'shipped', 'default1', 0.0, NULL), (1, 'default2', 'default2', 1.0, 1);
INSERT INTO users (user_id, name, email, registration_date, is_active) VALUES (1, NULL, 'default2', '2023-01-02', NULL), (0, 'default2', 'shipped', '2023-01-01', NULL), (2, 'default1', 'shipped', NULL, 0), (3, 'shipped', 'shipped', '2023-01-01', 0);
INSERT INTO orders (order_id, user_id, order_date, total_amount, status) VALUES (1, 3, NULL, 1.0, 'shipped'), (0, 0, '2023-01-01', NULL, 'default1'), (2, 1, '2023-01-02', 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name FROM Users AS u JOIN Orders AS o ON u.user_id = o.user_id WHERE o.status = 'shipped';

/*
Gold Result:
('shipped',)
*/

-- Prediction Query
SELECT u.name FROM Users AS u JOIN Products AS p ON u.user_id = p.product_id WHERE p.category = 'shipped';

/*
Prediction Result:
*/