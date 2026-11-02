-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Zoe', 'zoe@example.com', '2023-02-01', 0);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (2, 'Charlie', 'charlie@example.com', '2023-06-15', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (3, 'Alice', 'alice@example.com', '2023-01-10', 1);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (4, 'Bob', 'bob@example.com', '2023-03-20', NULL);
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (5, 'David', 'david@example.com', '2023-09-01', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Users WHERE is_active = 1;

/*
Gold Result:
('Charlie',)
('Alice',)
('David',)
*/

-- Prediction Query
SELECT name FROM Users WHERE is_active = 0;

/*
Prediction Result:
('Zoe',)
*/