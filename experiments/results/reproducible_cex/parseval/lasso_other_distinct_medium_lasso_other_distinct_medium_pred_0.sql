-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483648, '5k5swwqcgs', 'pro_d06b9c', 171.746906, 247012447);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, '8c4pgu7vfe', 'pro_d06b9c', 483.665643, -1633151678);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, 'a2y', 'pro_d06b9c', 797.015047, 1115440883);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483645, 'hsrwbbp', NULL, 503.083789, -1659388584);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category FROM Products;

/*
Gold Result:
('pro_d06b9c',)
(None,)
('pro_d06b9c',)
('pro_d06b9c',)
*/

-- Prediction Query
SELECT DISTINCT category FROM Products;

/*
Prediction Result:
('pro_d06b9c',)
(None,)
*/