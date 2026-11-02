-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "store", "price") VALUES (1033, 'store1', 1036);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1033, 'store2', 1043.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1033, 'store3', 1050.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store1', 1053);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store2', 1060.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store3', 1067.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store1', 1058);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store2', 1065.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store3', 1072.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 2111, 2125, 2139)
(1033, 1036, 1043, 1050)
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, MAX(CASE WHEN STORE = 'store1' THEN PRICE ELSE NULL END) AS STORE1, MAX(CASE WHEN STORE = 'store2' THEN PRICE ELSE NULL END) AS STORE2, MAX(CASE WHEN STORE = 'store3' THEN PRICE ELSE NULL END) AS STORE3 FROM PRODUCTS GROUP BY PRODUCT_ID;

/*
Prediction Result:
(None, 1058, 1065, 1072)
(1033, 1036, 1043, 1050)
*/