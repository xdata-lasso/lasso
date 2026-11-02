-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483647, 'pgu7vfe4', 'hria2ypuzhs', 663.049759, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, 'wbbp6luhvdlt', 'ilbnp', 787.938887, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, 'dpos', 'ie5', 327.753528, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483646, 'w6kl', 'a9', 877.276439, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483643, '00t5c4ecigc', 'e376nium52', 816.814398, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483642, 'buo4nrq', 'rofqyp5s5b', 22.720462, NULL);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483641, '02eu', 'liqa1', 982.938576, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT IIF(stock_quantity > 0, 'In Stock', 'Out of Stock') FROM Products;

/*
Gold Result:
('In Stock',)
('In Stock',)
('In Stock',)
('In Stock',)
('Out of Stock',)
('Out of Stock',)
('In Stock',)
('In Stock',)
*/

-- Prediction Query
SELECT IIF(stock_quantity > 0, 'Out of Stock', 'In Stock') FROM Products;

/*
Prediction Result:
('Out of Stock',)
('Out of Stock',)
('Out of Stock',)
('Out of Stock',)
('In Stock',)
('In Stock',)
('Out of Stock',)
('Out of Stock',)
*/