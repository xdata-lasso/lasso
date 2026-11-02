-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483648, '5k5swwqcgs', 'Electronics', 171.746906, 247012447);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483647, '8c4pgu7vfe', 'pro_ec1de1', NULL, -1633151678);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483646, 'a2y', 'pro_992912', NULL, 1115440883);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483645, 'hsrwbbp', 'Electronics', NULL, 13244799);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483644, 'hvdltt', 'Electronics', NULL, -1610064545);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483643, 'n', 'Electronics', NULL, 462974032);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483642, 'posiie5unw6k', 'Electronics', NULL, 1151980946);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, 'a9', 'Electronics', 1.0, 1620389964);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, '00t5c4ecigc', 'Electronics', 1.0, 528680845);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (4, '76nium52', NULL, 816.814398, -443340271);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (5, 'uo4nrqrofqy', 'Electronics', 242.260296, 1884179925);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (6, 'bbp02eut', 'Electronics', 186.190286, 1673584235);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(price) FROM Products WHERE category = 'Electronics';

/*
Gold Result:
(120.43949760000001,)
*/

-- Prediction Query
SELECT SUM(price) FROM Products WHERE category = 'Electronics';

/*
Prediction Result:
(602.197488,)
*/