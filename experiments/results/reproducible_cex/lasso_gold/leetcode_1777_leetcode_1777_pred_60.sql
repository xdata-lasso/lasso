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
WITH T0 AS (SELECT DISTINCT PRODUCT_ID FROM PRODUCTS), T1 AS (SELECT PRODUCT_ID, PRICE AS PRICE1 FROM PRODUCTS WHERE STORE = 'store1'), T2 AS (SELECT PRODUCT_ID, PRICE AS PRICE2 FROM PRODUCTS WHERE STORE = 'store2'), T3 AS (SELECT PRODUCT_ID, PRICE AS PRICE3 FROM PRODUCTS WHERE STORE = 'store3') SELECT T0.PRODUCT_ID, T1.PRICE1 AS STORE1, T2.PRICE2 AS STORE2, T3.PRICE3 AS STORE3 FROM T0 LEFT JOIN T1 ON T0.PRODUCT_ID = T1.PRODUCT_ID LEFT JOIN T2 ON T0.PRODUCT_ID = T2.PRODUCT_ID LEFT JOIN T3 ON T0.PRODUCT_ID = T3.PRODUCT_ID ORDER BY T0.PRODUCT_ID, STORE1 NULLS LAST, STORE2 NULLS LAST, STORE3 NULLS LAST;

/*
Prediction Result:
(None, None, None, None)
(1033, 1036, 1043, 1050)
*/