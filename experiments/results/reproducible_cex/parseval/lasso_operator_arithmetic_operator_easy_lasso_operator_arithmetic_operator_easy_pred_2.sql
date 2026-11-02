-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (-2147483648, 'pro_0a8749', '5k5swwqcgs', 0.0, -51.0, 247012447);

INSERT INTO "products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (2, 'pro_0a8749', '8c4pgu7vfe', 0.0, -51.0, -1633151678);

INSERT INTO "products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (3, 'pro_0a8749', 'a2y', 0.0, -51.0, 1115440883);

INSERT INTO "products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (-2147483645, 'pro_0a8749', 'hsrwbbp', 0.0, 0.0, 13244799);

INSERT INTO "products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (-2147483644, NULL, 'hvdltt', 0.0, -51.0, -1610064545);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price - cost > 50;

/*
Gold Result:
('pro_0a8749',)
(None,)
('pro_0a8749',)
('pro_0a8749',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price / cost > 50;

/*
Prediction Result:
*/