-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483648, '5k5swwqcgs', 'pro_6cc29d', 171.746906, 247012447);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483647, '8c4pgu7vfe', 'pro_6cc29d', 483.665643, -1633151678);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483646, 'a2y', 'pro_6cc29d', 797.015047, 1115440883);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, 'hsrwbbp', 'pro_6cc29d', 503.083789, -1659388584);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, 'l', 'pro_6cc29d', 303.05704, -1610064545);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483645, 'n', 'pro_6cc29d', 240.969194, 462974032);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483642, 'posiie5unw6k', 'pro_6cc29d', 768.216462, 1620389964);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483641, '00t5c4ecigc', 'pro_6cc29d', 623.093099, -1585009206);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483640, '52zb', 'pro_6cc29d', 676.357279, -1179823637);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483639, 'rqro', NULL, 680.514642, 373262291);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483638, 'p5s5bbp', NULL, 705.580387, 743312762);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483637, 'eutliqa11r', NULL, 997.73177, -525979501);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (4, 'oo3o9hl72kl', 'pro_fb6ef4', 74.250383, -305670381);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (5, 'i7z', 'pro_fb6ef4', 353.163664, -2081315180);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (6, '2dwyrq13pyu7', 'd99rljsl0', 27.036693, 1649269347);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483633, 'p5qi2rkf9v', 'pro_fcc9a2', 263.638479, 556727997);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category;

/*
Gold Result:
(None, 3)
('d99rljsl0', 1)
('pro_6cc29d', 9)
('pro_fb6ef4', 2)
('pro_fcc9a2', 1)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products;

/*
Prediction Result:
('pro_6cc29d', 16)
*/