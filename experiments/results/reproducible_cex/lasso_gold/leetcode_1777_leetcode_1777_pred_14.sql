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
SELECT PRODUCT_ID, (SELECT PRICE FROM PRODUCTS AS Q WHERE STORE = 'store1' AND Q.PRODUCT_ID = P.PRODUCT_ID) AS STORE1, (SELECT PRICE FROM PRODUCTS AS Q WHERE STORE = 'store2' AND Q.PRODUCT_ID = P.PRODUCT_ID) AS STORE2, (SELECT PRICE FROM PRODUCTS AS Q WHERE STORE = 'store3' AND Q.PRODUCT_ID = P.PRODUCT_ID) AS STORE3 FROM PRODUCTS AS P GROUP BY PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
(1033, 1036, 1043, 1050)
*/