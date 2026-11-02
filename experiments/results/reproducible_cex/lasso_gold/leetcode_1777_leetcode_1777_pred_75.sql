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
SELECT PRODUCT_ID, ROUND(AVG(CASE WHEN STORE = 'store1' THEN PRICE END), 0) AS STORE1, ROUND(AVG(CASE WHEN STORE = 'store2' THEN PRICE END), 0) AS STORE2, ROUND(AVG(CASE WHEN STORE = 'store3' THEN PRICE END), 0) AS STORE3 FROM PRODUCTS GROUP BY PRODUCT_ID;

/*
Prediction Result:
(None, 1056.0, 1063.0, 1070.0)
(1033, 1036.0, 1043.0, 1050.0)
*/