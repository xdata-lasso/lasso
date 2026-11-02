-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, name, email, registration_date, is_active) VALUES (1, 'Alice', 'alice@example.com', '2023-01-01', 1);
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES (1, 1, '2023-01-02', 100.0, 'Completed');
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (1, 'Prod_Qty_9', 'CatA', 50.0, 20);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (2, 'Prod_Qty_10', 'CatA', 50.0, 20);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (3, 'Prod_Qty_11', 'CatA', 5.0, 5);
INSERT INTO Products (product_id, name, category, price, stock_quantity) VALUES (4, 'Prod_No_Orders', 'CatA', 50.0, 20);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 9, 50.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (2, 1, 2, 10, 50.0);
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES (3, 1, 3, 11, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE product_id IN (SELECT product_id FROM OrderItems WHERE quantity > 10);

/*
Gold Result:
('Prod_Qty_11',)
*/

-- Prediction Query
SELECT name FROM Products WHERE product_id IN (1, 2, 3);

/*
Prediction Result:
('Prod_Qty_9',)
('Prod_Qty_10',)
('Prod_Qty_11',)
*/