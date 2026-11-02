-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (price = 100.0), floating-point precision boundaries, and standard inequalities
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Below_Int', 'Electronics', 99.0, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Below_Float', 'Electronics', 99.99, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Exact_Boundary', 'Electronics', 100.0, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Above_Float', 'Electronics', 100.01, 10);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (5, 'Above_Int', 'Electronics', 101.0, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price >= 100;

/*
Gold Result:
('Exact_Boundary',)
('Above_Float',)
('Above_Int',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price <> 100;

/*
Prediction Result:
('Below_Int',)
('Below_Float',)
('Above_Float',)
('Above_Int',)
*/