-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store", "price") VALUES (NULL, 'store1', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 10, None, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, SUM(CASE WHEN (PRODUCT_ID, STORE) IN (SELECT PRODUCT_ID, STORE FROM PRODUCTS WHERE STORE = 'store1') THEN PRICE END) AS STORE1, SUM(CASE WHEN (PRODUCT_ID, STORE) IN (SELECT PRODUCT_ID, STORE FROM PRODUCTS WHERE STORE = 'store2') THEN PRICE END) AS STORE2, SUM(CASE WHEN (PRODUCT_ID, STORE) IN (SELECT PRODUCT_ID, STORE FROM PRODUCTS WHERE STORE = 'store3') THEN PRICE END) AS STORE3 FROM PRODUCTS GROUP BY PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
*/