-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, rating REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_name", "category", "rating") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1.0);

INSERT INTO "products" ("product_id", "product_name", "category", "rating") VALUES (-2147483647, '4', 'gu7v', NULL);

INSERT INTO "products" ("product_id", "product_name", "category", "rating") VALUES (-2147483646, 'e4', 'hria2ypuzhs', NULL);

INSERT INTO "products" ("product_id", "product_name", "category", "rating") VALUES (-2147483645, 'rwbbp6luhvd', 'tti', NULL);

INSERT INTO "products" ("product_id", "product_name", "category", "rating") VALUES (-2147483644, 'bnp', 'mdpos', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(rating) FROM Products;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Products;

/*
Prediction Result:
(5,)
*/