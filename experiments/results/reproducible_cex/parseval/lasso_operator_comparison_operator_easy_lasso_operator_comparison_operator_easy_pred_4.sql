-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483648, 'pro_c431fc', '5k5swwqcgs', 100.0, 247012447);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, 'pro_c431fc', '8c4pgu7vfe', 100.0, -1633151678);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, 'pro_c431fc', 'a2y', 100.0, 1115440883);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483645, 'pro_c431fc', 'hsrwbbp', 99.99, 13244799);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483644, NULL, 'hvdltt', 100.0, -1610064545);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (4, 'n', 'rmdp', NULL, 2026480202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price >= 100;

/*
Gold Result:
('pro_c431fc',)
(None,)
('pro_c431fc',)
('pro_c431fc',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price < 100;

/*
Prediction Result:
('pro_c431fc',)
*/