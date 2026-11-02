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
SELECT F1.PRODUCT_ID, STORE1, STORE2, STORE3 FROM (SELECT DISTINCT PRODUCT_ID FROM PRODUCTS) AS F1 LEFT JOIN (SELECT PRODUCT_ID, SUM(CASE WHEN STORE = 'store1' THEN PRICE END) AS STORE1 FROM PRODUCTS GROUP BY PRODUCT_ID) AS F2 ON F1.PRODUCT_ID = F2.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, SUM(CASE WHEN STORE = 'store2' THEN PRICE END) AS STORE2 FROM PRODUCTS GROUP BY PRODUCT_ID) AS F3 ON F1.PRODUCT_ID = F3.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, SUM(CASE WHEN STORE = 'store3' THEN PRICE END) AS STORE3 FROM PRODUCTS GROUP BY PRODUCT_ID) AS F4 ON F1.PRODUCT_ID = F4.PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
(1033, 1036, 1043, 1050)
*/