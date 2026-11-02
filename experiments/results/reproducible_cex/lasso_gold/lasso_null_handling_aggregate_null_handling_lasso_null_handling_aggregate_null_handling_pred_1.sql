-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, rating REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "product_name", "category", "rating") VALUES (1009, 'Lance Hoffman', 'sense', 1010.5);
INSERT INTO "products" ("product_id", "product_name", "category", "rating") VALUES (1011, 'Kimberly Robinson', 'perform', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(rating) FROM Products;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(product_id) FROM Products;

/*
Prediction Result:
(2,)
*/