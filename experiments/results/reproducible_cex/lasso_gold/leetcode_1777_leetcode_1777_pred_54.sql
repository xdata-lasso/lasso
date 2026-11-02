-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "store", "price") VALUES (1025, 'store1', 1028);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1025, 'store2', 1035.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1025, 'store3', 1042.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1031, 'store1', NULL);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1031, 'store2', NULL);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1031, 'store3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(1025, 1028, 1035, 1042)
(1031, None, None, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, SUM(CASE WHEN STORE = 'store1' THEN COALESCE(PRICE, 0) END) AS STORE1, SUM(CASE WHEN STORE = 'store2' THEN COALESCE(PRICE, 0) END) AS STORE2, SUM(CASE WHEN STORE = 'store3' THEN COALESCE(PRICE, 0) END) AS STORE3 FROM PRODUCTS GROUP BY 1;

/*
Prediction Result:
(1025, 1028, 1035, 1042)
(1031, 0, 0, 0)
*/