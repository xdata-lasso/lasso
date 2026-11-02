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
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 1053, 1060, 1067)
(1033, 1036, 1043, 1050)
*/

-- Prediction Query
SELECT T.PRODUCT_ID, T1.STORE1, T2.STORE2, T3.STORE3 FROM (SELECT DISTINCT PRODUCT_ID FROM PRODUCTS) AS T LEFT JOIN (SELECT PRODUCT_ID, PRICE AS STORE1 FROM PRODUCTS WHERE STORE = 'store1') AS T1 ON T.PRODUCT_ID = T1.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, PRICE AS STORE2 FROM PRODUCTS WHERE STORE = 'store2') AS T2 ON T.PRODUCT_ID = T2.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, PRICE AS STORE3 FROM PRODUCTS WHERE STORE = 'store3') AS T3 ON T.PRODUCT_ID = T3.PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
(1033, 1036, 1043, 1050)
*/