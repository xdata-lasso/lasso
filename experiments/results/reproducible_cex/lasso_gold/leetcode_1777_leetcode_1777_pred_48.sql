-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "store", "price") VALUES (1013, 'brother', 1016);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1013, 'ago', 1016);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(1013, None, None, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, CASE WHEN SUM(STORE1) = 0 THEN NULL ELSE SUM(STORE1) END AS STORE1, CASE WHEN SUM(STORE2) = 0 THEN NULL ELSE SUM(STORE2) END AS STORE2, CASE WHEN SUM(STORE3) = 0 THEN NULL ELSE SUM(STORE3) END AS STORE3 FROM (SELECT PRODUCT_ID, PRICE AS STORE1, 0 AS STORE2, 0 AS STORE3 FROM PRODUCTS WHERE STORE = 'store1' UNION ALL SELECT PRODUCT_ID, 0 AS STORE1, PRICE AS STORE2, 0 AS STORE3 FROM PRODUCTS WHERE STORE = 'store2' UNION ALL SELECT PRODUCT_ID, 0 AS STORE1, 0 AS STORE2, PRICE AS STORE3 FROM PRODUCTS WHERE STORE = 'store3') AS C GROUP BY PRODUCT_ID;

/*
Prediction Result:
*/