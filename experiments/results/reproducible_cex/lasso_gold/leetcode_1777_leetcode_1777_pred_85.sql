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
SELECT DISTINCT P1.PRODUCT_ID, P2.PRICE AS STORE1, P3.PRICE AS STORE2, P4.PRICE AS STORE3 FROM PRODUCTS AS P1 LEFT JOIN PRODUCTS AS P2 ON P1.PRODUCT_ID = P2.PRODUCT_ID AND P2.STORE = 'store1' LEFT JOIN PRODUCTS AS P3 ON P1.PRODUCT_ID = P3.PRODUCT_ID AND P3.STORE = 'store2' LEFT JOIN PRODUCTS AS P4 ON P1.PRODUCT_ID = P4.PRODUCT_ID AND P4.STORE = 'store3';

/*
Prediction Result:
(None, None, None, None)
(1033, 1036, 1043, 1050)
*/