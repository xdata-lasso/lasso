-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store", "price") VALUES (4, 'store3', 1);
INSERT INTO "Products" ("product_id", "store", "price") VALUES (4, 'store1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(4, None, None, 1)
*/

-- Prediction Query
SELECT PRODUCT_ID, CASE WHEN SUM(STORE = 'store1') = 0 THEN NULL ELSE SUM((STORE = 'store1') * PRICE) END AS STORE1, CASE WHEN SUM(STORE = 'store2') = 0 THEN NULL ELSE SUM((STORE = 'store2') * PRICE) END AS STORE2, CASE WHEN SUM(STORE = 'store3') = 0 THEN NULL ELSE SUM((STORE = 'store3') * PRICE) END AS STORE3 FROM PRODUCTS GROUP BY PRODUCT_ID;

/*
Prediction Result:
(4, 0, None, 1)
*/