-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, 'pro_d77c2b', '5k5swwqcgs', 171.746906, 247012447);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, 'pro_d77c2b', '8c4pgu7vfe', 483.665643, -1633151678);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483646, 'a2y', 'Electronics', 797.015047, 1115440883);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483645, 'hsrwbbp', 'Electronics', 503.083789, -1659388584);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483644, 'pro_d77c2b', 'l', 303.05704, -1610064545);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483643, 'n', 'Electronics', NULL, 462974032);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483642, 'posiie5unw6k', 'Electronics', NULL, 1151980946);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483641, NULL, 'a9', 877.276439, 546571701);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483640, NULL, '0t5c4ecigc', 623.093099, -1585009206);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483639, NULL, 'Electronics', NULL, -53231346);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483638, NULL, 'Electronics', NULL, -443340271);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483637, 'pro_d77c2b', 'uo4nrqrofqy', 242.260296, 1884179925);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483636, 'bbp02eut', 'Electronics', 186.190286, 1673584235);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price > (SELECT MIN(price) FROM Products WHERE category = 'Electronics');

/*
Gold Result:
('a2y',)
('hsrwbbp',)
('pro_d77c2b',)
(None,)
(None,)
('pro_d77c2b',)
('pro_d77c2b',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price > (SELECT MAX(price) FROM Products WHERE category = 'Electronics');

/*
Prediction Result:
(None,)
*/