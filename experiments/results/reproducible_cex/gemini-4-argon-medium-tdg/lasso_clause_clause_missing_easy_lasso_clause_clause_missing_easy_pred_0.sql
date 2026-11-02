-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard GROUP BY behavior, multiple groups with different sizes,
-- duplicate column values (to kill COUNT(DISTINCT ...) mutants),
-- and 0/negative values (to kill WHERE price > 0 or stock_quantity > 0 mutants).
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Laptop', 'Electronics', 1000.0, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Laptop', 'Electronics', 1000.0, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Mouse', 'Electronics', 0.0, 0);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Shirt', 'Apparel', 25.5, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Pants', 'Apparel', -10.0, -5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (6, 'Novel', 'Books', 15.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category;

/*
Gold Result:
('Apparel', 2)
('Books', 1)
('Electronics', 3)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products;

/*
Prediction Result:
('Electronics', 6)
*/