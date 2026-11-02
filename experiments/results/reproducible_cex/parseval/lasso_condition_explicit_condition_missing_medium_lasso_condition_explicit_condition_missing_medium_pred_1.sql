-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483648, 'pro_d3b0e4', 'Electronics', 582.588439, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, 'pro_d3b0e4', 'Electronics', 680.190136, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, 'pro_d3b0e4', 'Electronics', 487.053947, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483645, 'pro_d3b0e4', 'pro_84525b', 486.033807, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483644, 'pro_d3b0e4', 'Electronics', 345.329712, 0);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483643, NULL, 'Electronics', 833.684115, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (4, 'cgsk9', 'Electronics', 206.939346, NULL);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (5, '8c4pgu7vfe', 'pro_32c62d', 483.665643, 0);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (6, 'hria2ypuzhs', 'pro_32c62d', 663.049759, NULL);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (7, 'wbbp6luhvdlt', NULL, 304.02808, 1);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (8, 'bnp', NULL, 787.938887, 0);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (9, 'dpos', NULL, 133.007885, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE category = 'Electronics' AND stock_quantity > 0;

/*
Gold Result:
('pro_d3b0e4',)
(None,)
('pro_d3b0e4',)
('pro_d3b0e4',)
*/

-- Prediction Query
SELECT name FROM Products;

/*
Prediction Result:
('pro_d3b0e4',)
('pro_d3b0e4',)
('pro_d3b0e4',)
(None,)
('pro_d3b0e4',)
('pro_d3b0e4',)
('cgsk9',)
('8c4pgu7vfe',)
('hria2ypuzhs',)
('wbbp6luhvdlt',)
('bnp',)
('dpos',)
*/